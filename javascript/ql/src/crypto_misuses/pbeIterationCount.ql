import javascript

from DataFlow::CallNode node, DataFlow::SourceNode mod, string msg
where mod = DataFlow::moduleImport("crypto") 
    and node = mod.getAMemberCall("pbkdf2"+ ["","Sync"])
    and node.getArgument(2).getIntValue() < 1000
    and msg = "A PBE function " + node +" has an iteration count smaller than 1000. Consider increasing that number to 1000 or higher."
select node, msg