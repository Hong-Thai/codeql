//Taken from CWE-327

import javascript
import semmle.javascript.security.dataflow.BrokenCryptoAlgorithmQuery
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
  string extra_information,
  string source_reference,
  string sink_reference,
  string source_path,
  string sink_path
where
  cfg.hasFlowPath(source, sink) and
  not source.getNode() instanceof CleartextPasswordExpr // flagged by js/insufficient-password-hash
  and crypto_api_name = "NodeJsCrypto"
  and function_ref.getAnArgument() = sink.getNode()
  and function_name = function_ref.getCalleeName()
  and function_category = ""
  and misuse_category = "Broken crypto algorithm"
  and reference1 = source.getNode().asExpr().getLocation()
  and reference2 = sink.getNode().asExpr().getLocation()
  and reference = reference1 + " -> " + reference2
  and path = reference1.getFile().getRelativePath() + " -> " + reference2.getFile().getRelativePath()
  and misuse_message = "A broken or weak cryptographic algorithm depends on sensitive data from" + source.getNode().(Source).describe()
  and status = "MISUSE"
  and extra_information = ""
  and source_reference = reference1.toString()
  and sink_reference = reference2.toString()
  and source_path = reference1.getFile().getRelativePath()
  and sink_path = reference2.getFile().getRelativePath()
select crypto_api_name,
  function_name,
  function_category,
  misuse_category, status,
  misuse_message, 
  reference, 
  path, 
  extra_information, 
  source_reference, 
  sink_reference, 
  source_path, 
  sink_path