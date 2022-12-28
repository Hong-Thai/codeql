import javascript

from DataFlow::SourceNode mod, DataFlow::CallNode call, string crypto_api_name, string function_name, Location reference, string description, int numArgs, string arg1, string arg2, string arg3, string arg4, string arg5, string arg6, string arg7
where mod = DataFlow::moduleImport("crypto") and call = mod.getAMethodCall()
and crypto_api_name = "NodeJsCrypto" and function_name = call.getCalleeName()
and reference = call.asExpr().getLocation()
and description = "Usage of " + function_name + " from the following API: " + crypto_api_name
and numArgs = call.getNumArgument()
and
(
(numArgs = 0 and arg1 =""and arg2 =""and arg3 =""and arg4 =""and arg5 =""and arg6 =""and arg7 ="")
or
(numArgs = 1 and arg1 =call.getArgument(0).toString()and arg2 =""and arg3 =""and arg4 =""and arg5 =""and arg6 =""and arg7 ="")
or
(numArgs = 2 and arg1 =call.getArgument(0).toString()and arg2 =call.getArgument(1).toString()and arg3 =""and arg4 =""and arg5 =""and arg6 =""and arg7 ="")
or
(numArgs = 3 and arg1 =call.getArgument(0).toString()and arg2 =call.getArgument(1).toString()and arg3 =call.getArgument(2).toString()and arg4 =""and arg5 =""and arg6 =""and arg7 ="")
or
(numArgs = 4 and arg1 =call.getArgument(0).toString()and arg2 =call.getArgument(1).toString()and arg3 =call.getArgument(2).toString()and arg4 =call.getArgument(3).toString()and arg5 =""and arg6 =""and arg7 ="")
or
(numArgs = 5 and arg1 =call.getArgument(0).toString()and arg2 =call.getArgument(1).toString()and arg3 =call.getArgument(2).toString()and arg4 =call.getArgument(3).toString()and arg5 =call.getArgument(4).toString()and arg6 =""and arg7 ="")
or
(numArgs = 6 and arg1 =call.getArgument(0).toString()and arg2 =call.getArgument(1).toString()and arg3 =call.getArgument(2).toString()and arg4 =call.getArgument(3).toString()and arg5 =call.getArgument(4).toString()and arg6 =call.getArgument(5).toString()and arg7 ="")
or
(numArgs = 7 and arg1 =call.getArgument(0).toString()and arg2 =call.getArgument(1).toString()and arg3 =call.getArgument(2).toString()and arg4 =call.getArgument(3).toString()and arg5 =call.getArgument(4).toString()and arg6 =call.getArgument(5).toString()and arg7 =call.getArgument(6).toString())
)

select crypto_api_name, function_name, call, reference, description,numArgs,arg1,arg2,arg3,arg4,arg5,arg6,arg7