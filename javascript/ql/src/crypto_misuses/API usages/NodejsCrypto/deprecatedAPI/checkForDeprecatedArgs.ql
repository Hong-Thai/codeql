import javascript
import deprecatedAPIs

from DeprecatedArguments arg, string msg
where msg = arg + " is deprecated and should not be used."
select arg, msg