import javascript

from DataFlow::SourceNode mod, DataFlow::CallNode call, string crypto_api_name, string function_name, Location reference, string description, int numArgs, string arg0, string arg1, string arg2, string arg3, string arg4, string arg5, string arg6, string arg7
where mod = DataFlow::moduleImport("crypto-js") and call = mod.getAMethodCall()
and crypto_api_name = "crypto-js" and function_name = call.getCalleeName()
and reference = call.asExpr().getLocation()
and description = "Usage of " + function_name + " from the following API: " + crypto_api_name
and numArgs = call.getNumArgument()
and
(numArgs > 0 and arg0 = call.getArgument(0).toString() or arg0 = "")
and
(numArgs > 1 and arg1 = call.getArgument(1).toString() or arg1 = "")
and
(numArgs > 2 and arg2 = call.getArgument(2).toString() or arg2 = "")
and
(numArgs > 3 and arg3 = call.getArgument(3).toString() or arg3 = "")
and
(numArgs > 4 and arg4 = call.getArgument(4).toString() or arg4 = "")
and
(numArgs > 5 and arg5 = call.getArgument(5).toString() or arg5 = "")
and
(numArgs > 6 and arg6 = call.getArgument(6).toString() or arg6 = "")
and
(numArgs > 7 and arg7 = call.getArgument(7).toString() or arg7 = "")
select crypto_api_name, function_name, call, reference, description,numArgs,arg0,arg1,arg2,arg3,arg4,arg5,arg6,arg7