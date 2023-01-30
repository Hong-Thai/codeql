import javascript

class CreateCipherivNumbers extends DataFlow::CallNode {
  CreateCipherivNumbers() {
    exists(DataFlow::SourceNode mod |
      mod = DataFlow::moduleImport("crypto") and
      this = mod.getAMemberCall("createCipheriv")
    )
  }

  int getIvLength() { result = this.getArgument(2).getStringValue().length() }
}

class GenerateKeyPairNumbers extends DataFlow::CallNode {
  GenerateKeyPairNumbers() {
    exists(DataFlow::SourceNode mod |
      mod = DataFlow::moduleImport("crypto") and
      this = mod.getAMemberCall("generateKeyPair" + ["", "Sync"])
    )
  }

  int getSaltLength() { result = this.getOptionArgument(1, "saltLength").getIntValue() }

  int getPrimeLength() { result = this.getOptionArgument(1, "primeLength").getIntValue() }
}

class ScryptNumbers extends DataFlow::CallNode {
  ScryptNumbers() {
    exists(DataFlow::SourceNode mod |
      mod = DataFlow::moduleImport("crypto") and
      this = mod.getAMemberCall("scrypt" + ["", "Sync"])
    )
  }

  int getSaltLength() { result = this.getArgument(1).getStringValue().length() }

  int getCost() { result = this.getOptionArgument(3, "cost").getIntValue() }
}

//W3C
class DeriveBits extends DataFlow::CallNode {
  string apiName;
  string functionName;
  DeriveBits() {
    exists(DataFlow::SourceNode window, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle |
      window = DataFlow::globalVariable("window") and
      crypto = window.getAPropertyRead("crypto") and
      subtle = crypto.getAPropertyRead("subtle") and
      this = subtle.getAMemberCall("deriveBits")
      and apiName = "W3C"
      and functionName = "deriveBits"
    )
    or
    exists(DataFlow::SourceNode crypto, DataFlow::SourceNode subtle
    |
      crypto = DataFlow::moduleImport("crypto") and
      subtle = crypto.getAPropertyRead("webcrypto").getAPropertyRead("subtle") and
      this = subtle.getAMemberCall("deriveBits")
      and apiName = "NodeJSCrypto"
      and functionName = "webcrypto.subtle.deriveBits"
    )
  }

  int getIterationsForPbkdf2() { result = this.getOptionArgument(0, "iterations").getIntValue() }

  int getLength() { result = this.getArgument(2).getIntValue() }

  string getAPIName() {result = apiName}
  string getFunctionName() {result = functionName}
}

class DeriveKey extends DataFlow::CallNode {
  string apiName;
  string functionName;
  DeriveKey() {
    exists(DataFlow::SourceNode window, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle |
      window = DataFlow::globalVariable("window") and
      crypto = window.getAPropertyRead("crypto") and
      subtle = crypto.getAPropertyRead("subtle") and
      this = subtle.getAMemberCall("deriveKey")
      and apiName = "W3C"
      and functionName = "deriveKey"
    )
    or
    exists(DataFlow::SourceNode crypto, DataFlow::SourceNode subtle
      |
        crypto = DataFlow::moduleImport("crypto") and
        subtle = crypto.getAPropertyRead("webcrypto").getAPropertyRead("subtle") and
        this = subtle.getAMemberCall("deriveKey")
        and apiName = "NodeJSCrypto"
        and functionName = "webcrypto.subtle.deriveKey"
      )
  }

  int getIterationsForPbkdf2() { result = this.getOptionArgument(0, "iterations").getIntValue() }
  string getAPIName() {result = apiName}
  string getFunctionName() {result = functionName}
}


class GenerateKey extends DataFlow::CallNode {
  string apiName;
  string functionName;
    GenerateKey() {
      exists(DataFlow::SourceNode window, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle |
        window = DataFlow::globalVariable("window") and
        crypto = window.getAPropertyRead("crypto") and
        subtle = crypto.getAPropertyRead("subtle") and
        this = subtle.getAMemberCall("generateKey")
        and apiName = "W3C"
        and functionName = "generateKey"
      )
      or
      exists(DataFlow::SourceNode crypto, DataFlow::SourceNode subtle
        |
          crypto = DataFlow::moduleImport("crypto") and
          subtle = crypto.getAPropertyRead("webcrypto").getAPropertyRead("subtle") and
          this = subtle.getAMemberCall("deriveKey")
          and apiName = "NodeJSCrypto"
          and functionName = "webcrypto.subtle.generateKey"
        )
    }
  
    int getModulusLengthForRSA() { result = this.getOptionArgument(0, "modulusLength").getIntValue() }
  
    int getLengthForHMAC() {result = this.getOptionArgument(0, "length").getIntValue() }
    string getAPIName() {result = apiName}
    string getFunctionName() {result = functionName}
  }
  