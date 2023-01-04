import javascript

from DataFlow::SourceNode mod, DataFlow::CallNode call, string crypto_api_name, string function_name, Location reference, string description, int num, string arg0
where mod = DataFlow::moduleImport("crypto") and call = mod.getAMethodCall()
and crypto_api_name = "NodeJsCrypto" and function_name = call.getCalleeName()
and reference = call.asExpr().getLocation()
and description = "Usage of " + function_name + " from the following API: " + crypto_api_name
and num = call.getNumArgument()
and
arg0 = [call.getAnArgument().toString()]
select crypto_api_name, function_name, call, reference, description,arg0