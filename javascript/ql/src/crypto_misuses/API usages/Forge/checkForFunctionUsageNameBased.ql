import javascript

predicate hasPropertyRead(DataFlow::SourceNode src) {
    exists(DataFlow::SourceNode succ |
        src.getAPropertyRead() = succ
    )
}

string getPropertiesAll(DataFlow::SourceNode src) {
    if hasPropertyRead(src)
    then result = describeExpression(src.asExpr()).substring(17,describeExpression(src.asExpr()).length()-1)+"."+getPropertiesAll(src.getAPropertyRead())
    else
    result = describeExpression(src.asExpr()).substring(17,describeExpression(src.asExpr()).length()-1)
}

from DataFlow::SourceNode call, string crypto_api_name, string function_name, Location reference, string description, string path, int numArgs, string arg0, string arg1, string arg2, string arg3, string arg4, string arg5, string arg6
where call.toString() = "forge" and function_name = getPropertiesAll(call)
and crypto_api_name = "forge"
and reference = call.asExpr().getLocation()
and description = "Usage of " + function_name + " from the following API: " + crypto_api_name
and numArgs = 0
and path = reference.getFile().getRelativePath()
and (numArgs = 0 and arg0 =""and arg1 =""and arg2 =""and arg3 =""and arg4 =""and arg5 =""and arg6 ="")
select crypto_api_name, function_name, call, reference, description, path, numArgs, arg0, arg1, arg2, arg3, arg4, arg5, arg6