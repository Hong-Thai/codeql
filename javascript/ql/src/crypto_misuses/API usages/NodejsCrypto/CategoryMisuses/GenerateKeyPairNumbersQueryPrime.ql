import javascript
import ShortNumberMisuses

from GenerateKeyPairNumbers generateKeyPair, int size, string msg
where
    size = generateKeyPair.getPrimeLength() and
    size < 2048 and
    msg = "generateKeyPair uses a prime of size "+ size + " .The recommended size is 2048 or greater" //TODO: research
    
select generateKeyPair, msg
