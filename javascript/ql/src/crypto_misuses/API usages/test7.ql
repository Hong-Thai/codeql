import javascript
import NumberSource
import semmle.javascript.security.dataflow.ConstantValuesForCriticalFunctionsCustomization

boolean isHardcodedArray(ArrayExpr arr, int i) {
    i in [0 .. arr.getSize()] and 
    if arr.getSize() = 0 then result = false else
    if arr.getSize() = i 
        then result = true else 
            if not arr.getElement(i) instanceof NumberLiteral 
                then result = false
                    else result = isHardcodedArray(arr, i+1)
    
}

/*  from ArrayExpr num, DataFlow::CallNode call, DataFlow::SourceNode src, DataFlow::Node sink
//where num.getLocation().toString().substring(0, 9) = "constTest" and src.asExpr() = num
//where call.getCalleeName() = "testConst" and sink = call.getArgument(0) and src.asExpr() = num and src.flowsTo(sink)
where 
isHardcodedArray(num, 0) = true and 
call.getCalleeName() = "testConst" and sink = call.getOptionArgument(0, "tet") and src.asExpr() = num and src.flowsTo(sink)
select src,sink  
 */
/* from ArrayExpr num
where isHardcodedArray(num, 0) = true
select num */
/* 
from ArrayExpr num, DataFlow::CallNode call, DataFlow::SourceNode src, DataFlow::Node sink, ConstantValue::Sink s
//where num.getLocation().toString().substring(0, 9) = "constTest" and src.asExpr() = num
//where call.getCalleeName() = "testConst" and sink = call.getArgument(0) and src.asExpr() = num and src.flowsTo(sink)
where 
isHardcodedArray(num, 0) = true and 
src.asExpr() = num and src.flowsTo(s)
select src,s */

from ArrayExpr num, DataFlow::CallNode call, DataFlow::SourceNode src, DataFlow::Node sink, ConstantValue::Sink s, DataFlow::InvokeNode funSrc
//where num.getLocation().toString().substring(0, 9) = "constTest" and src.asExpr() = num
//where call.getCalleeName() = "testConst" and sink = call.getArgument(0) and src.asExpr() = num and src.flowsTo(sink)
where 
isHardcodedArray(num, 0) = true and 
funSrc.getCalleeName() = "Uint"+[8, 16, 32, 64]+"Array" and funSrc.getArgument(0).asExpr() = num
//src.asExpr() = num 
and funSrc.flowsTo(s)
select funSrc, s

/* from DataFlow::InvokeNode funSrc
where funSrc.getCalleeName() = "Uint8Array"
select funSrc */

/* from DataFlow::SourceNode window, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle, DataFlow::CallNode function,
ArrayExpr num, DataFlow::CallNode call, DataFlow::SourceNode src, DataFlow::Node sink
where window = DataFlow::globalVariable("window") and
      crypto = window.getAPropertyRead("crypto") and
      subtle = crypto.getAPropertyRead("subtle") and
      function = subtle.getAMethodCall("deriveBits") and
      sink = function.getOptionArgument(0, "salt")
      and isHardcodedArray(num, 0) = true and 
      src.asExpr() = num and src.flowsTo(sink)
select src, sink */