/**
 * Provides default sources, sinks and sanitizers for reasoning about
 * sensitive information in broken or weak cryptographic algorithms,
 * as well as extension points for adding your own.
 */

 import javascript
 private import semmle.javascript.security.SensitiveActions
 
 module AlgorithmToArgument {
   /**
    * A data flow source for sensitive information in broken or weak cryptographic algorithms.
    */
   abstract class Source extends DataFlow::Node {
     /** Gets a string that describes the type of this data flow source. */
     //abstract string describe();
     abstract CryptographicAlgorithm getAlgorithm();
   }
 
   /**
    * A data flow sink for sensitive information in broken or weak cryptographic algorithms.
    */
   abstract class Sink extends DataFlow::Node { }
 
   /**
    * A sanitizer for sensitive information in broken or weak cryptographic algorithms.
    */
   abstract class Sanitizer extends DataFlow::Node { }
 
   class AlgorithmSource extends Source {
    CryptographicAlgorithm algorithm;
    AlgorithmSource(){
        this.asExpr() instanceof ConstantString
        and algorithm.matchesName(this.getStringValue())
    }

    override CryptographicAlgorithm getAlgorithm(){
        result = algorithm
    }
   }
 
   /**
    * An expression used by a broken or weak cryptographic algorithm.
    */
   class NodeJSCryptoAlgorithmSink extends Sink {
    DataFlow::CallNode function;
    NodeJSCryptoAlgorithmSink() {
        exists(DataFlow::SourceNode mod |
            mod = DataFlow::moduleImport("crypto") and
            (function = mod.getAMemberCall("create" + ["Hash", "Hmac", "Sign", "Cipher", "Cipheriv"]) or 
            function = mod.getAMemberCall(["hkdf", "hkdfSync"])
            ) and
            this = function.getArgument(0))
     }
     DataFlow::CallNode getFunction(){
        result = function
       }
     }
   }

   
 