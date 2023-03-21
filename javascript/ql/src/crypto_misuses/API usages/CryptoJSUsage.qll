import CryptoAPIUsages

predicate hasPropertyRead(DataFlow::SourceNode src) {
    exists(DataFlow::SourceNode succ |
        src.getAPropertyRead() = succ
    )
}

string getPropertiesAll(DataFlow::SourceNode src) {
    if hasPropertyRead(src)
    then result = describeExpression(src.asExpr()).substring(17,describeExpression(src.asExpr()).length()-1)+"."+getPropertiesAll(src.getAPropertyRead())
    else
    result = describeExpression(src.asExpr()).substring(17,describeExpression(src.asExpr()).length()-1)
}

class CryptoJSUsage extends CryptoAPIUsage {
    DataFlow::SourceNode call;
    Location location;
    int numArgs;
    string function_name;

    CryptoJSUsage(){
        exists(DataFlow::SourceNode mod |
            mod = DataFlow::moduleImport("crypto-js")
            and call = mod.getAPropertyRead() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = 0
            and function_name = getPropertiesAll(call)
        )
        or
        exists(DataFlow::SourceNode mod, DataFlow::CallNode call_node, string import_name |
            import_name = "crypto-js/"+["md5",
            "sha1",
            "sha256",
            "sha224",
            "sha512",
            "sha384",
            "sha3",
            "ripemd160",
            "hmac-md5",
            "hmac-sha1",
            "hmac-sha256",
            "hmac-sha224",
            "hmac-sha512",
            "hmac-sha384",
            "hmac-sha3",
            "hmac-ripemd160",
            "pbkdf2",
            "aes",
            "tripledes",
            "rc4",
            "rabbit",
            "rabbit-legacy",
            "evpkdf",
            "mode-cfb",
            "mode-ctr",
            "mode-ctr-gladman",
            "mode-ofb",
            "mode-ecb"]
            and
            mod = DataFlow::moduleImport(import_name)
            and call_node = mod
            and call = call_node.getACall()
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = 0
            and function_name = call_node.getCalleeName()
        )
    }

    override string getCryptoAPIName() { result = "CryptoJS" }

    override string getFunctionName() { result = function_name }

    override Location getReference() { result = location }

    override string getPath() { result = location.getFile().getRelativePath() }

    override int getNumArgs() { result = numArgs }

    override string getArg(int i) { 
        i in [0..100] and
        result = ""
    }
}