import javascript
import ShortNumberMisuses

from GenerateKey generateKey, int size,
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
    (size = generateKey.getModulusLengthForRSA() and
    size < 2048 and
    misuse_message = "generateKey uses RSA with modulusLength less then 2048 bits ("+ size + "). This is considered dangerous and should not be used for encryption."
    or
    size = generateKey.getLengthForHMAC() and
    size < 128 and
    misuse_message = "generateKey uses HMAC with length less then 128 bits ("+ size + "). This is considered dangerous and should not be used for encryption. Eighter omit length or keep is at least 128 bits"
    )
    and reference = generateKey.asExpr().getLocation()
    and crypto_api_name = "W3C"
    and function_name = "generateKey"
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


