import CryptoAPIUsages

class WebCryptoAPIUsage extends CryptoAPIUsage {
    DataFlow::CallNode call;
    Location location;
    int numArgs;

    WebCryptoAPIUsage(){
        exists(DataFlow::SourceNode subtle |
            subtle = DataFlow::globalVariable("window").getAPropertyRead("crypto").getAPropertyRead("subtle")
            and call = subtle.getAMethodCall() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = call.getNumArgument() 
        )
        or
        exists(DataFlow::SourceNode subtle |
            subtle = DataFlow::globalVariable("crypto").getAPropertyRead("subtle")
            and call = subtle.getAMethodCall() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = call.getNumArgument() 
        )
        or
        exists(DataFlow::SourceNode subtle |
            subtle = DataFlow::globalVariable("window").getAPropertyRead("crypto")
            and call = subtle.getAMethodCall() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = call.getNumArgument() 
        )
        or
        exists(DataFlow::SourceNode subtle |
            subtle = DataFlow::globalVariable("crypto")
            and call = subtle.getAMethodCall() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = call.getNumArgument() 
        )
    }

    override string getCryptoAPIName() { result = "WebCryptoAPI" }

    override string getFunctionName() { result = call.getCalleeName() }

    override Location getReference() { result = location }

    override string getPath() { result = location.getFile().getRelativePath() }

    override int getNumArgs() { result = numArgs }

    override string getArg(int i) { 
        i in [0..100] and
        if (i >= numArgs) then result = "" else result = call.getArgument(0).toString()
        
    }
}