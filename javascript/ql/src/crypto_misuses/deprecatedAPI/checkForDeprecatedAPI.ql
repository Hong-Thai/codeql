import javascript
import deprecatedAPIs


from DataFlow::SourceNode mod, string msg
where mod instanceof DeprecatedAPI
and msg = mod + " is deprecated and should not be used."
select mod