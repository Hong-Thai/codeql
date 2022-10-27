import javascript
import semmle.javascript.security.dataflow.ConstantValuesForCriticalFunctionsQuery
import semmle.javascript.security.SensitiveActions
import DataFlow::PathGraph

from Configuration cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where
  cfg.hasFlowPath(source, sink) 
select sink.getNode(), source, sink
