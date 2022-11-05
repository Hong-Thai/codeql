import javascript
import ShortNumberMisuses

from GenerateKeyPairNumbers generateKeyPair, int size, string msg
where
    size = generateKeyPair.getSaltLength() and
    size < 16 and
    msg = "generateKeyPair uses an salt of size "+ size + " .The recommended size is 16 or greater" //TODO: research
select generateKeyPair, msg

