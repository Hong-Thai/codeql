import javascript

from DataFlow::SourceNode mod, DataFlow::CallNode call
where mod = DataFlow::moduleImport("crypto") and call = mod.getAMethodCall()
select call, call.getCalleeName()
