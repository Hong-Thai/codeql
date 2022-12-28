import javascript
import semmle.javascript.security.dataflow.AlgorithmToArgumentQuery
import semmle.javascript.security.dataflow.AlgorithmToArgumentCustomization
import semmle.javascript.security.SensitiveActions
import DataFlow::PathGraph
import semmle.javascript.security.internal.CryptoAlgorithmNames

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
  cfg.hasFlowPath(source, sink) and
  not source.getNode() instanceof CleartextPasswordExpr // flagged by js/insufficient-password-hash
  and source.getNode() instanceof BrokenAlgorithmSource
//  and (isWeakHashingAlgorithm(source.toString()) 
//    or isWeakEncryptionAlgorithm(source.toString()) 
//    or isWeakPasswordHashingAlgorithm(source.toString()))
  and crypto_api_name = "NodeJsCrypto"
  and function_ref.getAnArgument() = sink.getNode()
  and function_name = function_ref.getCalleeName()
  and function_category = ""
  and misuse_category = "Broken crypto algorithm"
  and reference1 = source.getNode().asExpr().getLocation()
  and reference2 = sink.getNode().asExpr().getLocation()
  and reference = reference1 + " -> " + reference2
  and path = reference1.getFile().getRelativePath() + " -> " + reference2.getFile().getRelativePath()
  and misuse_message = ""
  and status = "MISUSE"
  and extra_information = ""
select crypto_api_name, function_name, function_category, misuse_category, status, misuse_message, reference, path, extra_information, source, sink