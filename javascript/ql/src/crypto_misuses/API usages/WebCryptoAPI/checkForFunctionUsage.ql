import javascript

from DataFlow::SourceNode mod, DataFlow::CallNode call, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle, string crypto_api_name, string function_name, Location reference, string description
where mod = DataFlow::globalVariable("window") and crypto = mod.getAPropertyRead("crypto") and subtle = crypto.getAPropertyRead("subtle")
and call = subtle.getAMethodCall()
and crypto_api_name = "WebCryptoAPI" and function_name = call.getCalleeName()
and reference = call.asExpr().getLocation()
and description = "Usage of " + function_name + " from the following API: " + crypto_api_name
select crypto_api_name, function_name, call, reference, description

