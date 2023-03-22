import javascript

module Utils {
    predicate hasPropertyRead(DataFlow::SourceNode src) {
        exists(DataFlow::SourceNode here | here = src)
        and
        exists(DataFlow::SourceNode succ |
            src.getAPropertyRead() = succ
        )
    }

    string getPropertiesAll_(DataFlow::SourceNode src, int i) {
        i in [0..5] and
        if hasPropertyRead(src) and i < 5
        then result = describeExpression(src.asExpr()).substring(17,describeExpression(src.asExpr()).length()-1)+"."+getPropertiesAll_(src.getAPropertyRead(), i+1)
        else
        result = describeExpression(src.asExpr()).substring(17,describeExpression(src.asExpr()).length()-1)
    }
    
    string getPropertiesAll(DataFlow::SourceNode src) {
        result = getPropertiesAll_(src, 0)
    }
}