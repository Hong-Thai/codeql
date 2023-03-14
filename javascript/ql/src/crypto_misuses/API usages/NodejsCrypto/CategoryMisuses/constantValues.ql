import javascript
import semmle.javascript.security.dataflow.ConstantValuesForCriticalFunctionsQuery
import semmle.javascript.security.SensitiveActions
import DataFlow::PathGraph

from Configuration cfg, DataFlow::PathNode source, DataFlow::PathNode sink,
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
  string extra_information,
  string source_reference,
  string sink_reference,
  string source_path,
  string sink_path
where
  cfg.hasFlowPath(source, sink) 
  and crypto_api_name = sink.getNode().(Sink).getAPIName()
  and
  (
    sink.getNode() instanceof ConstantNodeJSCryptoWebCryptoAPISink
    and
    function_name = "webcrypto.subtle." + sink.getNode().(Sink).getFunction().getCalleeName()
    or
    not sink.getNode() instanceof ConstantNodeJSCryptoWebCryptoAPISink
    and
    function_name = sink.getNode().(Sink).getFunction().getCalleeName()
  )
  and function_category = ""
  and misuse_category = "Constant/Hardcoded values to sensitive functions"
  and reference1 = source.getNode().asExpr().getLocation()
  and reference2 = sink.getNode().asExpr().getLocation()
  and reference = reference1 + " -> " + reference2
  and path = reference1.getFile().getRelativePath() + " -> " + reference2.getFile().getRelativePath()
  and status = "MISUSE" and extra_information = "FILE:constantValues.ql;VALUE:"+source.toString() 
  and misuse_message = "The constant/hardcoded value: " + source + " flows into the sensitive function: " + sink + ". It is recommended to use freshly generated values for this." 
  and source_reference = reference1.toString()
  and sink_reference = reference2.toString()
  and source_path = reference1.getFile().getRelativePath()
  and sink_path = reference2.getFile().getRelativePath()
select crypto_api_name, 
function_name, 
function_category, 
misuse_category, 
status, 
misuse_message, 
reference, 
path, 
extra_information,
source_reference, 
sink_reference, 
source_path, 
sink_path
