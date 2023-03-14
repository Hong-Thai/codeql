//Taken from CWE-326

import javascript

from CryptographicKeyCreation key, int size, string algo,
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
  size = key.getSize() and
  (
    algo = key.getAlgorithm() + " "
    or
    not exists(key.getAlgorithm()) and algo = ""
  ) and
  (
    size < 128 and
    key.isSymmetricKey() and
    misuse_message =
      "Creation of an symmetric " + algo + "key uses " + size +
        " bits, which is below 128 and considered breakable."
    or
    size < 2048 and
    not key.isSymmetricKey() and
    misuse_message =
      "Creation of an asymmetric " + algo + "key uses " + size +
        " bits, which is below 2048 and considered breakable."
  )
  and reference = key.asExpr().getLocation()
    and crypto_api_name = "NodeJsCrypto"
    and function_name = ""
    and function_category = "key creation"
    and misuse_category = "Short number"
    and status = "MISUSE"
    and path = reference.getFile().getRelativePath()
    and extra_information = algo +";"+ size
    and source_reference = "FILE:keySize.ql;SIZE:"+size
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
