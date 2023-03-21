import javascript
import CryptoAPIUsages
import NodeJSCryptoUsage
import WebCryptoAPIUsage

from CryptoAPIUsage usage, string crypto_api_name, string function_name, Location reference, string description, string path, int numArgs, string arg0, string arg1, string arg2, string arg3, string arg4, string arg5, string arg6
where crypto_api_name = usage.getCryptoAPIName()
    and function_name = usage.getFunctionName()
    and reference = usage.getReference()
    and description = usage.getDescription()
    and path = usage.getPath()
    and numArgs = usage.getNumArgs()
    and arg0 = usage.getArg(0)
    and arg1 = usage.getArg(1)
    and arg2 = usage.getArg(2)
    and arg3 = usage.getArg(3)
    and arg4 = usage.getArg(4)
    and arg5 = usage.getArg(5)
    and arg6 = usage.getArg(6)
select crypto_api_name, function_name, usage, reference, description, path, numArgs, arg0, arg1, arg2, arg3, arg4, arg5, arg6