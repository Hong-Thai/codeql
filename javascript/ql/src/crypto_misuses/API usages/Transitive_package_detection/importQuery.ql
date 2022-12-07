import javascript

from DataFlow::ModuleImportNode node, string function, string importedPackage
where node.getAMethodCall().getCalleeName() = function and importedPackage = node.getPath()
select node, importedPackage, function