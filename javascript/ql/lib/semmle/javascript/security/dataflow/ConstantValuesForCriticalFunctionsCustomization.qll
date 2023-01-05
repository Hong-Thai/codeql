/**
 * Provides default sources, sinks and sanitizers for reasoning about
 * sensitive information in broken or weak cryptographic algorithms,
 * as well as extension points for adding your own.
 */

import javascript
private import semmle.javascript.security.SensitiveActions

module ConstantValue {
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
  abstract class Sink extends DataFlow::Node {
    abstract string getAPIName();

    abstract DataFlow::CallNode getFunction();
   }

  /**
   * 
   */
  abstract class Sanitizer extends DataFlow::Node {}

  /**
   * 
   */
  class FSReadValuesSource extends Source {
    FSReadValuesSource() {
      exists(DataFlow::SourceNode fs, DataFlow::CallNode node |
        fs = DataFlow::moduleImport("fs") 
        and
        node = fs.getAMemberCall("readFile"+["","Sync"])
        |
        this = node
      )
    }
  }

  class HardcodedValuesSource extends Source {
    HardcodedValuesSource() {
      this.asExpr() instanceof ConstantString
    }
  }

  class ConstantValuesReadAsyncSource extends Source {
    ConstantValuesReadAsyncSource() {
      exists(DataFlow::SourceNode fs, DataFlow::FunctionNode callback, DataFlow::Node param|
        fs = DataFlow::moduleImport("fs") 
        and
        callback = fs.getAMemberCall("readFile").getArgument(2)
        and
        param = callback.getParameter(1)
        |
        this = param
      )
    }
  }
  

  class ConstantValuesSink extends Sink {
    DataFlow::CallNode node;
    ConstantValuesSink(){
        exists(DataFlow::SourceNode crypto |
          crypto = DataFlow::moduleImport("crypto") 
          and
          (node = crypto.getAMemberCall("publicEncrypt")
          or
          node = crypto.getAMemberCall("privateEncrypt")
          or
          node = crypto.getAMemberCall("pbkdf2" + ["", "Sync"])
          or
          node = crypto.getAMemberCall("scrypt" + ["", ["Sync"]])
          or
          node = crypto.getAMemberCall("createPrivateKey")
          or
          node = crypto.getAMemberCall("createPublicKey")
          or
          node = crypto.getAMemberCall("createSecretKey")
          )
            |
            this = node.getArgument(0)
        )
        or
          exists(DataFlow::SourceNode crypto |
            crypto = DataFlow::moduleImport("crypto") 
            and
            (node = crypto.getAMemberCall("createCipheriv")
            or
            node = crypto.getAMemberCall("createHmac")
            or
            node = crypto.getAMemberCall("hkdf" + ["", "Sync"])
            or
            node = crypto.getAMemberCall("pbkdf2" + ["", "Sync"])
            or
            node = crypto.getAMemberCall("scrypt" + ["", ["Sync"]])
            )
              |
              this = node.getArgument(1)
          )
          or
          exists(DataFlow::SourceNode crypto |
            crypto = DataFlow::moduleImport("crypto") 
            and
            (
            node = crypto.getAMemberCall("createCipheriv")
            or
            node = crypto.getAMemberCall("hkdf" + ["", "Sync"])
            or
            node = crypto.getAMemberCall("sign")
            )
              |
              this = node.getArgument(2)
          )
        or
        exists(DataFlow::SourceNode crypto |
          crypto = DataFlow::moduleImport("crypto") 
          and
          (
          node = crypto.getAMemberCall("diffieHellman")
          )
            |
            this = node.getOptionArgument(0, "privateKey")
        )
    }

    override string getAPIName(){
      result = "NodeJSCrypto"
    }

    override DataFlow::CallNode getFunction(){
      result = node
    }
  }

  class W3CConstantValueSink extends Sink {
    DataFlow::CallNode function;

    W3CConstantValueSink(){
      exists(
        DataFlow::SourceNode window, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle,
        DataFlow::SourceNode inner
      |
        window = DataFlow::globalVariable("window") and
        crypto = window.getAPropertyRead("crypto") and
        subtle = crypto.getAPropertyRead("subtle") and
        function = subtle.getAMethodCall("importKey")
        |
        this = function.getArgument(1)

        )
    }
    override string getAPIName(){
      result = "W3C"
    }

    override DataFlow::CallNode getFunction(){
      result = function
    }
  }

}
