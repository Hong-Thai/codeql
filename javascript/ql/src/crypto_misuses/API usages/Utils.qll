import javascript

module Utils {
    predicate hasPropertyRead(DataFlow::SourceNode src) {
        exists(DataFlow::SourceNode succ |
            src.getAPropertyRead() = succ
        )
    }
    
    string getPropertiesAll(DataFlow::SourceNode src) {
        if hasPropertyRead(src)
        then result = describeExpression(src.asExpr()).substring(17,describeExpression(src.asExpr()).length()-1)+"."+getPropertiesAll(src.getAPropertyRead())
        else
        result = describeExpression(src.asExpr()).substring(17,describeExpression(src.asExpr()).length()-1)
    }
}