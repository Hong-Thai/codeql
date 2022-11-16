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
  abstract class Sink extends DataFlow::Node { }

  /**
   * 
   */
  abstract class Sanitizer extends DataFlow::Node { }

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
    ConstantValuesSink(){
        exists(DataFlow::SourceNode crypto, DataFlow::CallNode node |
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
          exists(DataFlow::SourceNode crypto, DataFlow::CallNode node |
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
          exists(DataFlow::SourceNode crypto, DataFlow::CallNode node |
            crypto = DataFlow::moduleImport("crypto") 
            and
            (
            node = crypto.getAMemberCall("hkdf" + ["", "Sync"])
            or
            node = crypto.getAMemberCall("sign")
            )
              |
              this = node.getArgument(2)
          )
        or
        exists(DataFlow::SourceNode crypto, DataFlow::CallNode node |
          crypto = DataFlow::moduleImport("crypto") 
          and
          (
          node = crypto.getAMemberCall("diffieHellman")
          )
            |
            this = node.getOptionArgument(0, "privateKey")
        )
    }
  }
}
