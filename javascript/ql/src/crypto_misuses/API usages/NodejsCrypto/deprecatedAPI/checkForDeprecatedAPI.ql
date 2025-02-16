import javascript
import deprecatedAPIs


from DataFlow::SourceNode mod,
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
where mod instanceof DeprecatedAPI
and misuse_message = mod + " is deprecated and should not be used."
and reference = mod.asExpr().getLocation()
    and crypto_api_name = "NodeJsCrypto"
    and function_name = mod.toString()
    and function_category = ""
    and misuse_category = "Deprecated call"
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