import javascript

class DeprecatedAPI extends DataFlow::CallNode {

    DeprecatedAPI() {
      exists(DataFlow::SourceNode mod |
        mod = DataFlow::moduleImport("crypto") and
        this = mod.getAMemberCall(["createCipher", "createDecipher"])
      )
    }
}