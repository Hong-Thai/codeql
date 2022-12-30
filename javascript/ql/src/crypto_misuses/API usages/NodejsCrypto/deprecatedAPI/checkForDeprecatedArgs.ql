import javascript
import deprecatedAPIs

from DeprecatedArguments arg,
Location reference,
DataFlow::CallNode function_ref,
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
where misuse_message = arg + " is deprecated and should not be used."
and reference = arg.asExpr().getLocation()
    and crypto_api_name = "NodeJsCrypto"
    and function_ref.getAnArgument() = arg
    and function_name = function_ref.getCalleeName()
    and function_category = ""
    and misuse_category = "Deprecated call"
    and status = "MISUSE"
    and path = reference.getFile().getRelativePath()
    and extra_information = arg.toString()
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