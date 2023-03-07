/**
 * Provides default sources, sinks and sanitizers for reasoning about
 * sensitive information in broken or weak cryptographic algorithms,
 * as well as extension points for adding your own.
 */

import javascript
private import semmle.javascript.security.SensitiveActions

module ConstantValue {

  boolean isHardcodedArray(ArrayExpr arr, int i) {
    i in [0 .. arr.getSize()] and 
    if arr.getSize() = 0 then result = false else
    if arr.getSize() = i 
        then result = true else 
            if not arr.getElement(i) instanceof NumberLiteral 
                then result = false
                    else result = isHardcodedArray(arr, i+1)
    
}


  /**
   * 
   */
  abstract class Source extends DataFlow::Node {

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

  class HardcodedStringSource extends Source {
    HardcodedStringSource() {
      this.asExpr() instanceof ConstantString
    }
  }

  class NumberSource extends DataFlow::SourceNode::Range {
    NumberSource(){
        exists( NumberLiteral num | 
            this.asExpr() =  num
            )
        
    }
  }

  class HardcodedArrayBufferSource extends Source {
    HardcodedArrayBufferSource(){
    exists(ArrayExpr num, DataFlow::InvokeNode src | 
      isHardcodedArray(num, 0) = true 
      and src.getCalleeName() = "Uint"+[8, 16, 32, 64]+"Array" 
      and src.getArgument(0).asExpr() = num
      | 
      this = src)
    }
  }

  class HardcodedArraySource extends Source {
    HardcodedArraySource(){
    exists(ArrayExpr num | 
      isHardcodedArray(num, 0) = true 
      | 
      this.asExpr() = num)
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
        DataFlow::SourceNode window, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle
      |
        window = DataFlow::globalVariable("window") and
        crypto = window.getAPropertyRead("crypto") and
        subtle = crypto.getAPropertyRead("subtle") and
        (
          function = subtle.getAMethodCall("deriveBits")
          or
          function = subtle.getAMethodCall("deriveKey")
          or
          function = subtle.getAMethodCall("encrypt")
          or
          function = subtle.getAMethodCall("deriveBits")
          or
          function = subtle.getAMethodCall("wrapKey")
          or
          function = subtle.getAMethodCall("unwrapKey")
        )
        |
        this = function.getOptionArgument(0, "salt")
          or
        this = function.getOptionArgument(0, "iv")
          or
        this = function.getOptionArgument(0, "counter")
          or
        this = function.getOptionArgument(3, "iv")
          or
        this = function.getOptionArgument(3, "counter")
        )
    }
    override string getAPIName(){
      result = "W3C"
    }

    override DataFlow::CallNode getFunction(){
      result = function
    }
  }

  class ConstantNodeJSCryptoWebCryptoAPISink extends Sink {
    DataFlow::CallNode function;

    ConstantNodeJSCryptoWebCryptoAPISink(){
      exists(
        DataFlow::SourceNode crypto, DataFlow::SourceNode subtle
      |
        crypto = DataFlow::moduleImport("crypto") and
        subtle = crypto.getAPropertyRead("webcrypto").getAPropertyRead("subtle") and
        (
          function = subtle.getAMethodCall("deriveBits")
          or
          function = subtle.getAMethodCall("deriveKey")
          or
          function = subtle.getAMethodCall("encrypt")
          or
          function = subtle.getAMethodCall("deriveBits")
          or
          function = subtle.getAMethodCall("wrapKey")
          or
          function = subtle.getAMethodCall("unwrapKey")
        )
        |
        this = function.getOptionArgument(0, "salt")
          or
        this = function.getOptionArgument(0, "iv")
          or
        this = function.getOptionArgument(0, "counter")
          or
        this = function.getOptionArgument(3, "iv")
          or
        this = function.getOptionArgument(3, "counter")
        )
    }
    override string getAPIName(){
      result = "NodeJSCrypto"
    }

    override DataFlow::CallNode getFunction(){
      result = function
    }
  }

}
