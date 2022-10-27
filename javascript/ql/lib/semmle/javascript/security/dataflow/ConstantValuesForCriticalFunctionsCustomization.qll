/**
 * Provides default sources, sinks and sanitizers for reasoning about
 * sensitive information in broken or weak cryptographic algorithms,
 * as well as extension points for adding your own.
 */

import javascript
private import semmle.javascript.security.SensitiveActions

module ConstantValue {
  /**
   * 
   */
  abstract class Source extends DataFlow::Node {
    /** Gets a string that describes the type of this data flow source. */
    //abstract string describe();
  }

  /**
   * 
   */
  abstract class Sink extends DataFlow::Node { }

  /**
   * 
   */
  abstract class Sanitizer extends DataFlow::Node { }

  /**
   * 
   */
  class ConstantValuesSource extends Source {
    ConstantValuesSource() {
      exists(DataFlow::SourceNode fs, DataFlow::CallNode node|
        fs = DataFlow::moduleImport("fs") 
        and
        node = fs.getAMemberCall("readFileSync")
        |
        this = node
      )
    }
  }
  

  class ConstantValuesSink extends Sink {
    ConstantValuesSink(){
        exists(DataFlow::CallNode test, DataFlow::InvokeNode node |
            test.getCalleeName() = "publicEncryptTest"
            |
            this = test.getArgument(0)
          )
    }
  }
}
