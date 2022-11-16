import javascript
import ShortNumberMisuses

from CreateCipherivNumbers createCipheriv, int size,
  Location reference,
  string crypto_api_name, 
  string function_name, 
  string function_category, 
  string misuse_category, 
  string misuse_message,
  string status,
  string path,
  string extra_information
where
    size = createCipheriv.getIvLength() and
  
    size < 16 and
    misuse_message = "createCipheriv uses an initialization vector of size "+ size + " .The recommended size is 16 or greater"
    and reference = createCipheriv.asExpr().getLocation()
    and crypto_api_name = "NodeJsCrypto"
    and function_name = "createCipheriv"
    and function_category = "encryption"
    and misuse_category = "ShortNumber"
    and status = "MISUSE"
    and path = reference.getFile().getRelativePath()
    and extra_information = ""
select crypto_api_name, function_name, function_category, misuse_category, misuse_message, status, reference, path, extra_information
