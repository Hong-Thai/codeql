import javascript
import semmle.javascript.security.dataflow.ConstantValuesForCriticalFunctionsQuery
import semmle.javascript.security.SensitiveActions
import DataFlow::PathGraph

from Configuration cfg, DataFlow::PathNode source, DataFlow::PathNode sink, string msg
where
  cfg.hasFlowPath(source, sink) 
  and msg = "Don't your the constant value " + source + " as a parameter to the function " + sink
select sink.getNode(), source, sink, msg
