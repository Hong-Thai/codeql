import javascript
import semmle.javascript.security.dataflow.AlgorithmToArgumentQuery
import semmle.javascript.security.dataflow.AlgorithmToArgumentCustomization
import DataFlow::PathGraph


from DataFlow::PathNode src, DataFlow::PathNode sink, Configuration cfg
where cfg.hasFlowPath(src,sink)
and src.getNode() instanceof BrokenAlgorithmSource
select src, sink