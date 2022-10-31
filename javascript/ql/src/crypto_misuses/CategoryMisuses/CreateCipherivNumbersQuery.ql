import javascript
import ShortNumberMisuses

from CreateCipherivNumbers createCipheriv, int size, string msg
where
    size = createCipheriv.getIvLength() and
  
    size < 16 and
    msg = "createCipheriv uses an initialization vector of size "+ size + " .The recommended size is 16 or greater"
select createCipheriv, msg
