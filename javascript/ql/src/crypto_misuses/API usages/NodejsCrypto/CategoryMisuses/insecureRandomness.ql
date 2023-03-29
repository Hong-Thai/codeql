//Taken from CWE 338

import javascript
import semmle.javascript.security.dataflow.InsecureRandomnessQuery
import semmle.javascript.security.dataflow.InsecureRandomnessCustomizations
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
  and 
    (sink.getNode().(Sink) instanceof SensitiveWriteSink and status = "WARNING"
    or
    not sink.getNode().(Sink) instanceof SensitiveWriteSink and status = "MISUSE")
  and extra_information = ""
  and source_reference = reference1.toString()
  and sink_reference = reference2.toString()
  and source_path = reference1.getFile().getRelativePath()
  and sink_path = reference2.getFile().getRelativePath()
select sink.getNode(), source, sink, 
crypto_api_name,
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