import javascript

from DataFlow::SourceNode mod, DataFlow::SourceNode crypto
where mod = DataFlow::globalVariable("window") and crypto = mod.getAPropertyRead("crypto")
select crypto