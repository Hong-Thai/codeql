import javascript
import ShortNumberMisuses

from DeriveKey deriveKey, int size,
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
    size = deriveKey.getIterationsForPbkdf2() and
    size < 1000 and
    misuse_message = "deriveKey uses PBKDF2 with then 1000 iterations ("+ size + "). This is considered dangerous and should not be used for encryption."
    and reference = deriveKey.asExpr().getLocation()
    and crypto_api_name = "W3C"
    and function_name = "deriveKey"
    and function_category = "KeyCreation"
    and misuse_category = "Short number"
    and status = "MISUSE"
    and path = reference.getFile().getRelativePath()
    and extra_information = ""
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


