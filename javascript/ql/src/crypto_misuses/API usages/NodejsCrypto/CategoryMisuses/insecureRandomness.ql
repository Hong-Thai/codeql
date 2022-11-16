//Taken from CWE 338

import javascript
import semmle.javascript.security.dataflow.InsecureRandomnessQuery
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
  string extra_information
where cfg.hasFlowPath(source, sink)
and crypto_api_name = ""
  and function_name = ""
  and function_category = ""
  and misuse_category = "Insecure Randomness"
  and reference1 = source.getNode().asExpr().getLocation()
  and reference2 = sink.getNode().asExpr().getLocation()
  and reference = reference1 + " -> " + reference2
  and path = reference1.getFile().getRelativePath() + " -> " + reference2.getFile().getRelativePath()
  and misuse_message = "This security context depends on a cryptographically insecure random number"
  and status = "MISUSE"
  and extra_information = ""
select crypto_api_name, function_name, function_category, misuse_category, status, misuse_message, reference, path, extra_information