import javascript

from DataFlow::SourceNode mod, DataFlow::CallNode call, string crypto_api_name, string function_name, Location reference, string description
where mod = DataFlow::moduleImport("js-nacl") and call = mod.getAMethodCall()
and crypto_api_name = "js-nacl" and function_name = call.getCalleeName()
and reference = call.asExpr().getLocation()
and description = "Usage of " + function_name + " from the following API: " + crypto_api_name
select crypto_api_name, function_name, call, reference, description
