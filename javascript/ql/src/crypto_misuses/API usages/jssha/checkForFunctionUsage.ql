import javascript

from DataFlow::NewNode classInstance, string crypto_api_name, string function_name, Location reference, string description, string path, int numArgs, string arg0, string arg1, string arg2, string arg3, string arg4, string arg5, string arg6
where classInstance.getCalleeName() = "jsSHA"
and crypto_api_name = "jsSHA" and function_name = classInstance.getCalleeName()
and reference = classInstance.asExpr().getLocation()
and description = "Usage of " + function_name + " from the following API: " + crypto_api_name
and numArgs = classInstance.getNumArgument()
and path = reference.getFile().getRelativePath()
and
(
(numArgs = 0 and arg0 =""and arg1 =""and arg2 =""and arg3 =""and arg4 =""and arg5 =""and arg6 ="")
or
(numArgs = 1 and arg0 =classInstance.getArgument(0).toString()and arg1 =""and arg2 =""and arg3 =""and arg4 =""and arg5 =""and arg6 ="")
or
(numArgs = 2 and arg0 =classInstance.getArgument(0).toString()and arg1 =classInstance.getArgument(1).toString()and arg2 =""and arg3 =""and arg4 =""and arg5 =""and arg6 ="")
or
(numArgs = 3 and arg0 =classInstance.getArgument(0).toString()and arg1 =classInstance.getArgument(1).toString()and arg2 =classInstance.getArgument(2).toString()and arg3 =""and arg4 =""and arg5 =""and arg6 ="")
or
(numArgs = 4 and arg0 =classInstance.getArgument(0).toString()and arg1 =classInstance.getArgument(1).toString()and arg2 =classInstance.getArgument(2).toString()and arg3 =classInstance.getArgument(3).toString()and arg4 =""and arg5 =""and arg6 ="")
or
(numArgs = 5 and arg0 =classInstance.getArgument(0).toString()and arg1 =classInstance.getArgument(1).toString()and arg2 =classInstance.getArgument(2).toString()and arg3 =classInstance.getArgument(3).toString()and arg4 =classInstance.getArgument(4).toString()and arg5 =""and arg6 ="")
or
(numArgs = 6 and arg0 =classInstance.getArgument(0).toString()and arg1 =classInstance.getArgument(1).toString()and arg2 =classInstance.getArgument(2).toString()and arg3 =classInstance.getArgument(3).toString()and arg4 =classInstance.getArgument(4).toString()and arg5 =classInstance.getArgument(5).toString()and arg6 ="")
or
(numArgs = 7 and arg0 =classInstance.getArgument(0).toString()and arg1 =classInstance.getArgument(1).toString()and arg2 =classInstance.getArgument(2).toString()and arg3 =classInstance.getArgument(3).toString()and arg4 =classInstance.getArgument(4).toString()and arg5 =classInstance.getArgument(5).toString()and arg6 =classInstance.getArgument(6).toString())
)
select crypto_api_name, function_name, classInstance, reference, description, path, numArgs, arg0, arg1, arg2, arg3, arg4, arg5, arg6

