import javascript
import semmle.javascript.security.dataflow.ConstantValuesForCriticalFunctionsQuery
import semmle.javascript.security.SensitiveActions
import DataFlow::PathGraph

from Configuration cfg, DataFlow::PathNode source, DataFlow::PathNode sink,
  DataFlow::CallNode function_ref,
  Location reference1,
  Location reference2,
  string crypto_api_name, 
  string function_name, 
  string function_category, 
  string misuse_category, 
  string misuse_message,
  string status,
  string reference,
  string path,
  string extra_information
where
  cfg.hasFlowPath(source, sink) 
  and crypto_api_name = "NodeJsCrypto"
  and function_ref.getAnArgument() = sink.getNode()
  and function_name = function_ref.getCalleeName()
  and function_category = ""
  and misuse_category = "Constant/Hardcoded values to sensitive functions"
  and reference1 = source.getNode().asExpr().getLocation()
  and reference2 = sink.getNode().asExpr().getLocation()
  and reference = reference1 + " -> " + reference2
  and path = reference1.getFile().getRelativePath() + " -> " + reference2.getFile().getRelativePath()
  and ((source.getNode() instanceof HardcodedValuesSource and status = "MISUSE" and extra_information = source.toString() 
      and misuse_message = "The constant/hardcoded value: " + source + " flows into the sensitive function: " + sink + ". It is recommended to use freshly generated values for this.")
   or (not source.getNode() instanceof HardcodedValuesSource and status = "WARNING" and extra_information = ""
      and misuse_message = "A value read from a file using " + source + " flows into the sensitive function: " + sink + ". It is recommended to use freshly generated values for this."))
select crypto_api_name, function_name, function_category, misuse_category, status, misuse_message, reference, path, extra_information
