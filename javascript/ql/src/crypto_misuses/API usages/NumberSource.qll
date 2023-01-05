import javascript

class NumberSource extends DataFlow::SourceNode::Range {
    NumberSource(){
        exists( NumberLiteral num | 
            this.asExpr() =  num
            )
        
    }
}