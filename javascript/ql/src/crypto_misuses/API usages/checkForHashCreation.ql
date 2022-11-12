import javascript

from DataFlow::SourceNode mod, DataFlow::CallNode hash
where mod = DataFlow::moduleImport("crypto")
    and hash = mod.getAMemberCall("createHash")
    and hash.getArgument(0).getStringValue() = "SHA1"
select hash


