/**
 * Provides a taint tracking configuration for reasoning about
 * sensitive information in broken or weak cryptographic algorithms.
 *
 * Note, for performance reasons: only import this file if
 * `BrokenCryptoAlgorithm::Configuration` is needed, otherwise
 * `BrokenCryptoAlgorithmCustomizations` should be imported instead.
 */

import javascript
import ConstantValuesForCriticalFunctionsCustomization::ConstantValue

/**
 * 
 */
class Configuration extends TaintTracking::Configuration {
  Configuration() { this = "ConstantValue" }

  override predicate isSource(DataFlow::Node source) { source instanceof Source }

  override predicate isSink(DataFlow::Node sink) { sink instanceof Sink }

  override predicate isSanitizer(DataFlow::Node node) {
    super.isSanitizer(node) or
    node instanceof Sanitizer
  }

}
