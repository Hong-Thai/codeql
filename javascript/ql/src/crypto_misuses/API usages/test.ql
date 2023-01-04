import javascript
//res = export.getSourceNode("unsafehash") or

from DataFlow::Node res, ExportDeclaration export, DataFlow::Node exportsVar, NodeModule node
where export.getAChild() = exportsVar.getAstNode()
select export