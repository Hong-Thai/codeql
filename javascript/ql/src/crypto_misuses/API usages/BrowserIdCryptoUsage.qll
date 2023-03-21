import CryptoAPIUsages

class BrowseridCryptoUsage extends CryptoAPIUsage {
    DataFlow::CallNode call;
    Location location;
    int numArgs;

    BrowseridCryptoUsage(){
        exists(DataFlow::SourceNode mod |
            mod = DataFlow::moduleImport("browserid-crypto")
            and call = mod.getAMethodCall() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = call.getNumArgument() 
        )
    }

    override string getCryptoAPIName() { result = "browserid-crypto" }

    override string getFunctionName() { result = call.getCalleeName() }

    override Location getReference() { result = location }

    override string getPath() { result = location.getFile().getRelativePath() }

    override int getNumArgs() { result = numArgs }

    override string getArg(int i) { 
        i in [0..100] and
        if (i >= numArgs) then result = "" else result = call.getArgument(0).toString()
        
    }
}