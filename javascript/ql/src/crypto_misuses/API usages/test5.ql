import javascript
import semmle.javascript.security.dataflow.AlgorithmToArgumentCustomization::AlgorithmToArgument

from AlgorithmToArgument::Source sha,AlgorithmToArgument::Sink arg , DataFlow::SourceNode src, DataFlow::SourceNode window, DataFlow::SourceNode crypto, DataFlow::SourceNode subtle, DataFlow::CallNode function
where sha = src and 
src.flowsTo(arg)
select arg
