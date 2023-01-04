import javascript

from ConstantString str, DataFlow::Node arg, DataFlow::SourceNode src, DataFlow::SourceNode window, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle, DataFlow::CallNode function
where src.asExpr() = str and window = DataFlow::globalVariable("window") 
and
crypto = window.getAPropertyRead("crypto")
and subtle = crypto.getAPropertyRead("subtle")
and 
function = subtle.getAMemberCall("deriveBits")
and
arg = function.getOptionArgument(0, "hash")
and 
src.flowsTo(arg)
select arg
