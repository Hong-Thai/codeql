import javascript

from DataFlow::SourceNode mod
where mod = DataFlow::moduleImport("sjcl")
or mod = DataFlow::globalVariable("nacl_factory")
select mod
