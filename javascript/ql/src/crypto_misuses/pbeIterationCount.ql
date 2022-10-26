import javascript

from DataFlow::CallNode node, DataFlow::SourceNode mod
where mod = DataFlow::moduleImport("crypto") 
    and node = mod.getAMemberCall("pbkdf2"+ ["","Sync"])
    and node.getArgument(2).getIntValue() < 1000
select node