import CryptoAPIUsages

class JSShaUsage extends CryptoAPIUsage {
    DataFlow::NewNode call;
    Location location;
    int numArgs;

    JSShaUsage(){
        exists(DataFlow::NewNode classInstance |
            classInstance.getCalleeName() = "jsSHA"
            and call = classInstance
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = call.getNumArgument() 
        )
    }

    override string getCryptoAPIName() { result = "JSSha" }

    override string getFunctionName() { result = call.getCalleeName() }

    override Location getReference() { result = location }

    override string getPath() { result = location.getFile().getRelativePath() }

    override int getNumArgs() { result = numArgs }

    override string getArg(int i) { 
        i in [0..100] and
        if (i >= numArgs) then result = "" else result = call.getArgument(0).toString()
        
    }
}