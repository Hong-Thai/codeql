import javascript

abstract class CryptoAPIUsage extends DataFlow::Node {
    abstract string getCryptoAPIName();

    abstract string getFunctionName();

    abstract Location getReference();

    string getDescription() { result = "" }

    abstract string getPath();

    int getNumArgs() { result = 0 }

    string getArg(int i) { i = 0 and result = ""}
}