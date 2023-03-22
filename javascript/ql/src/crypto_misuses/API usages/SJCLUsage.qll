import CryptoAPIUsages
import Utils::Utils

class SJCLUsage extends CryptoAPIUsage {
    DataFlow::SourceNode call;
    Location location;
    int numArgs;
    string function_name;

    SJCLUsage(){
        exists(DataFlow::SourceNode mod |
            mod = DataFlow::moduleImport("sjcl")
            and call = mod.getAPropertyRead() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = 0
            and function_name = getPropertiesAll(call)
        )
        or
        exists(DataFlow::SourceNode mod |
            mod.toString() = "sjcl"
            and call = mod.getAPropertyRead() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = 0
            and function_name = getPropertiesAll(call)
        )
    }

    override string getCryptoAPIName() { result = "SJCL" }

    override string getFunctionName() { result = function_name }

    override Location getReference() { result = location }

    override string getPath() { result = location.getFile().getRelativePath() }

    override int getNumArgs() { result = numArgs }

    override string getArg(int i) { 
        i in [0..100] and
        result = ""
    }
}