/**
 * Provides default sources, sinks and sanitizers for reasoning about
 * sensitive information in broken or weak cryptographic algorithms,
 * as well as extension points for adding your own.
 */

import javascript
private import semmle.javascript.security.SensitiveActions

module CryptoExport {
  /**
   * 
   */
  abstract class Source extends DataFlow::Node {
    /** Gets a string that describes the type of this data flow source. */
    //abstract string describe();
  }

  /**
   * 
   */
  abstract class Sink extends DataFlow::Node { }

  /**
   * 
   */
  abstract class Sanitizer extends DataFlow::Node { }

  /**
   * import javascript

from DataFlow::SourceNode mod, DataFlow::CallNode call, string crypto_api_name, string function_name, Location reference, string description
where mod = DataFlow::moduleImport("poly-crypto") and call = mod.getAMethodCall()
and crypto_api_name = "poly-crypto" and function_name = call.getCalleeName()
and reference = call.asExpr().getLocation()
and description = "Usage of " + function_name + " from the following API: " + crypto_api_name
select crypto_api_name, function_name, call, reference, description

   */
  class CryptoFunctionSource extends Source {
    CryptoFunctionSource(){
        exists(DataFlow::SourceNode crypto, DataFlow::CallNode function |
            crypto = DataFlow::moduleImport(["crypto", "browserid-crypto", "cryptico", "crypto-js", "node-forge", "js-nacl", "JSEncrypt", "openpgp", "poly-crypto", "sjcl"]) 
            and
            function = crypto.getAMethodCall()
            |
            this = function
          )
    }
  }

  class ExportSink extends Sink {
    ExportSink(){
      exists(DataFlow::Node node, ExportDeclaration exports|
        node.getAstNode() = exports.getAChild()
        | this = node
      )
    }
  }
  
}
