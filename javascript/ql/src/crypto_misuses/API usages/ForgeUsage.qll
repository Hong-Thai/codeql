import CryptoAPIUsages
import Utils::Utils

class ForgeUsage extends CryptoAPIUsage {
    DataFlow::SourceNode call;
    Location location;
    int numArgs;
    string function_name;

    ForgeUsage(){
        exists(DataFlow::SourceNode mod |
            mod = DataFlow::moduleImport("node-forge")
            and call = mod.getAPropertyRead() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = 0
            and function_name = getPropertiesAll(call)
        )
        or
        exists(DataFlow::SourceNode mod |
            mod.toString() = "forge"
            and call = mod.getAPropertyRead() 
            |
            this = call
            and location = call.asExpr().getLocation() 
            and numArgs = 0
            and function_name = getPropertiesAll(call)
        )
    }

    override string getCryptoAPIName() { result = "Forge" }

    override string getFunctionName() { result = function_name }

    override Location getReference() { result = location }

    override string getPath() { result = location.getFile().getRelativePath() }

    override int getNumArgs() { result = numArgs }

    override string getArg(int i) { 
        i in [0..100] and
        result = ""
    }
}