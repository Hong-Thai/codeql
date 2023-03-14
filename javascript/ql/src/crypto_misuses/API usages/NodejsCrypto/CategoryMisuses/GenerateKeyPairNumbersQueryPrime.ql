import javascript
import ShortNumberMisuses

from GenerateKeyPairNumbers generateKeyPair, int size,
Location reference,
  string crypto_api_name, 
  string function_name, 
  string function_category, 
  string misuse_category, 
  string misuse_message,
  string status,
  string path,
  string extra_information,
  string source_reference,
  string sink_reference,
  string source_path,
  string sink_path
where
    size = generateKeyPair.getPrimeLength() and
    size < 2048 and
    misuse_message = "generateKeyPair uses a prime of size "+ size + " .The recommended size is 2048 or greater" //TODO: research
    and reference = generateKeyPair.asExpr().getLocation()
    and crypto_api_name = "NodeJsCrypto"
    and function_name = "generateKeyPair prime"
    and function_category = "key creation"
    and misuse_category = "Short number"
    and status = "MISUSE"
    and path = reference.getFile().getRelativePath()
    and extra_information = "FILE:generateKeyPairNumbersQueryPrime.ql;SIZE:"+size
    and source_reference = ""
    and sink_reference = reference.toString()
    and source_path = ""
    and sink_path = path
    
select crypto_api_name, 
function_name, 
function_category,
misuse_category, 
misuse_message, 
status, 
reference, 
path, 
extra_information,
source_reference, 
sink_reference, 
source_path, 
sink_path
