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
  abstract class Sink extends DataFlow::Node {
    abstract string getAPIName();

    abstract DataFlow::CallNode getFunction();
  }

  /**
   * A sanitizer for sensitive information in broken or weak cryptographic algorithms.
   */
  abstract class Sanitizer extends DataFlow::Node { }

  class AlgorithmSource extends Source {
    CryptographicAlgorithm algorithm;

    AlgorithmSource() {
      this.asExpr() instanceof ConstantString and
      algorithm.matchesName(this.getStringValue())
    }

    override CryptographicAlgorithm getAlgorithm() { result = algorithm }
  }

  class BrokenAlgorithmSource extends Source {
    CryptographicAlgorithm algorithm;

    BrokenAlgorithmSource() {
      this.asExpr() instanceof ConstantString and
      algorithm.matchesName(this.getStringValue()) and
      algorithm.isWeak()
    }

    override CryptographicAlgorithm getAlgorithm() { result = algorithm }
  }

  /**
   * An expression used by a broken or weak cryptographic algorithm.
   */
  class NodeJSCryptoAlgorithmSink extends Sink {
    DataFlow::CallNode function;

    NodeJSCryptoAlgorithmSink() {
      exists(DataFlow::SourceNode mod |
        mod = DataFlow::moduleImport("crypto") and
        (
          function = mod.getAMemberCall("create" + ["Hash", "Hmac", "Sign", "Cipher", "Cipheriv"]) or
          function = mod.getAMemberCall(["hkdf", "hkdfSync"])
        ) and
        this = function.getArgument(0)
      )
    }

    override string getAPIName() { result = "NodeJSCrypto" }

    override DataFlow::CallNode getFunction() { result = function }
  }

  class W3CNoWindowAlgorithmSink extends Sink {
    DataFlow::CallNode function;

    W3CNoWindowAlgorithmSink() {
      exists(DataFlow::SourceNode crypto, DataFlow::SourceNode subtle, DataFlow::SourceNode inner |
        crypto = DataFlow::globalVariable("crypto") and
        subtle = crypto.getAPropertyRead("subtle") and
        (
          // Functions with "hash" as the first OptionArgument
          (
            function = subtle.getAMemberCall("deriveBits")
            or
            function = subtle.getAMemberCall("deriveKey")
            or
            function = subtle.getAMemberCall("generateKey")
            or
            function = subtle.getAMemberCall("sign")
            or
            function = subtle.getAMemberCall("verify")
          ) and
          (
            this = function.getOptionArgument(0, "hash")
            or
            inner = function.getOptionArgument(0, "hash") and
            this = inner.getAPropertyWrite("name").getRhs()
          )
          or
          // Functions with hash as the first argument
          (
            function = subtle.getAMemberCall("digest") and
            this = function.getArgument(0)
          )
          or
          // Functions with "hash" as the third OptionArgument
          (
            function = subtle.getAMemberCall("importKey") 
            and
            (
              this = function.getOptionArgument(2, "hash")
              or
              inner = function.getOptionArgument(2, "hash") and
              this = inner.getAPropertyWrite("name").getRhs()
            )
          )
          or
          // Functions with "hash" as the fifth OptionArgument
          (
            function = subtle.getAMemberCall("unwrapKey") 
            and
            (
              this = function.getOptionArgument(4, "hash")
              or
              inner = function.getOptionArgument(4, "hash") and
              this = inner.getAPropertyWrite("name").getRhs()
            )
          )
        )
      )
    }

    override string getAPIName() { result = "W3C" }

    override DataFlow::CallNode getFunction() { result = function }
  }

  class W3CWindowAlgorithmSink extends Sink {
    DataFlow::CallNode function;

    W3CWindowAlgorithmSink() {
      exists(
        DataFlow::SourceNode window, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle,
        DataFlow::SourceNode inner
      |
        window = DataFlow::globalVariable("window") and
        crypto = window.getAPropertyRead("crypto") and
        subtle = crypto.getAPropertyRead("subtle") and
        (
          // Functions with "hash" as the first OptionArgument
          (
            function = subtle.getAMemberCall("deriveBits")
            or
            function = subtle.getAMemberCall("deriveKey")
            or
            function = subtle.getAMemberCall("generateKey")
            or
            function = subtle.getAMemberCall("sign")
            or
            function = subtle.getAMemberCall("verify")
          ) and
          (
            this = function.getOptionArgument(0, "hash")
            or
            inner = function.getOptionArgument(0, "hash") and
            this = inner.getAPropertyWrite("name").getRhs()
          )
          or
          // Functions with hash as the first argument
          (
            function = subtle.getAMemberCall("digest") and
            this = function.getArgument(0)
          )
          or
          // Functions with "hash" as the third OptionArgument
          (
            function = subtle.getAMemberCall("importKey") 
            and
            (
              this = function.getOptionArgument(2, "hash")
              or
              inner = function.getOptionArgument(2, "hash") and
              this = inner.getAPropertyWrite("name").getRhs()
            )
          )
          or
          // Functions with "hash" as the fifth OptionArgument
          (
            function = subtle.getAMemberCall("unwrapKey") 
            and
            (
              this = function.getOptionArgument(4, "hash")
              or
              inner = function.getOptionArgument(4, "hash") and
              this = inner.getAPropertyWrite("name").getRhs()
            )
          )
        )
      )
    }

    override string getAPIName() { result = "W3C" }

    override DataFlow::CallNode getFunction() { result = function }
  }

  class NodeJSWebCryptoAPISink extends Sink{
    DataFlow::CallNode function;
    NodeJSWebCryptoAPISink(){
      exists(
        DataFlow::SourceNode crypto, DataFlow::SourceNode subtle,
        DataFlow::SourceNode inner
      |
        crypto = DataFlow::moduleImport("crypto") and
        subtle = crypto.getAPropertyRead("webcrypto").getAPropertyRead("subtle") and
        (
          // Functions with "hash" as the first OptionArgument
          (
            function = subtle.getAMemberCall("deriveBits")
            or
            function = subtle.getAMemberCall("deriveKey")
            or
            function = subtle.getAMemberCall("generateKey")
            or
            function = subtle.getAMemberCall("sign")
            or
            function = subtle.getAMemberCall("verify")
          ) and
          (
            this = function.getOptionArgument(0, "hash")
            or
            inner = function.getOptionArgument(0, "hash") and
            this = inner.getAPropertyWrite("name").getRhs()
          )
          or
          // Functions with hash as the first argument
          (
            function = subtle.getAMemberCall("digest") and
            this = function.getArgument(0)
          )
          or
          // Functions with "hash" as the third OptionArgument
          (
            function = subtle.getAMemberCall("importKey") 
            and
            (
              this = function.getOptionArgument(2, "hash")
              or
              inner = function.getOptionArgument(2, "hash") and
              this = inner.getAPropertyWrite("name").getRhs()
            )
          )
          or
          // Functions with "hash" as the fifth OptionArgument
          (
            function = subtle.getAMemberCall("unwrapKey") 
            and
            (
              this = function.getOptionArgument(4, "hash")
              or
              inner = function.getOptionArgument(4, "hash") and
              this = inner.getAPropertyWrite("name").getRhs()
            )
          )
        )
      )
    }
    override string getAPIName() { result = "NodeJSCrypto" }

    override DataFlow::CallNode getFunction() { result = function }
  }
}


