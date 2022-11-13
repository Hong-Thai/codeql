import javascript

class DeprecatedAPI extends DataFlow::CallNode {

    DeprecatedAPI() {
      exists(DataFlow::SourceNode mod |
        mod = DataFlow::moduleImport("crypto") and
        this = mod.getAMemberCall(["createCipher", "createDecipher"])
      )
    }
}

class DeprecatedArguments extends DataFlow::Node {
  DeprecatedArguments(){
    exists(DataFlow::SourceNode mod, DataFlow::Node arg|
      mod = DataFlow::moduleImport("crypto") and
      arg = mod.getAMemberCall("createDiffieHellmanGroup").getArgument(0)
      and arg.getStringValue() = ["modp1","modp2", "modp5"]
      and this = arg
    )
  }
}