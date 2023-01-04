 import javascript
 import semmle.javascript.security.dataflow.CryptoExportQuery

 
 from Configuration cfg, DataFlow::PathNode source, DataFlow::PathNode sink
 where
   cfg.hasFlowPath(source, sink)
 select source, sink
 