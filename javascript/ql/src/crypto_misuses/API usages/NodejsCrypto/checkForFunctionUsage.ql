import javascript

from DataFlow::SourceNode mod, DataFlow::CallNode reference, string crypto_api_name, string function_name
where mod = DataFlow::moduleImport("crypto") and reference = mod.getAMethodCall()
and crypto_api_name = "NodeJsCrypto" and function_name = reference.getCalleeName()
select crypto_api_name, function_name, reference
