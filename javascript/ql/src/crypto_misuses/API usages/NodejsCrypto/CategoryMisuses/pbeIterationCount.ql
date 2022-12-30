import javascript

from DataFlow::CallNode node, DataFlow::SourceNode mod,
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
where mod = DataFlow::moduleImport("crypto") 
    and node = mod.getAMemberCall("pbkdf2"+ ["","Sync"])
    and node.getArgument(2).getIntValue() < 1000
    and misuse_message = "A PBE function (pbkdf2) " + node +" has an iteration count smaller than 1000. Consider increasing that number to 1000 or higher."
    and reference = node.asExpr().getLocation()
    and crypto_api_name = "NodeJsCrypto"
    and function_name = node.toString()
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
