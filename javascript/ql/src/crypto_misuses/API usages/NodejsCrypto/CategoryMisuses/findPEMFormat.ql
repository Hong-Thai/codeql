import javascript


from ConstantString str,
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
where str.getStringValue().prefix(10) = "-----BEGIN" and str.getStringValue().indexOf("-----END") > 0 and
    misuse_message = "A constant/hardcoded string that might represent a key in PEM format was found in the code. A hardcoded key is considered dangerous and should not be used in a security context." 
    and reference = str.getLocation()
    and crypto_api_name = ""
    and function_name = ""
    and function_category = ""
    and misuse_category = "Constant/Hardcoded values to sensitive functions"
    and status = "WARNING"
    and path = reference.getFile().getRelativePath()
    and extra_information = str.getStringValue()
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