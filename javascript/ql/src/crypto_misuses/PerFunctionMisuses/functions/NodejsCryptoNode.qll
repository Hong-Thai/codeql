import javascript

module NodeJSCryptoFunctions{
    private class NodeJSCryptoNode extends DataFlow::SourceNode{
        NodeJSCryptoNode(){
            this = DataFlow::moduleImport("crypto")
        }
    }


    class CreateCipheriv extends DataFlow::CallNode {
        NodeJSCryptoNode cryptoNode;
        CreateCipheriv(){
            this = cryptoNode.getAMemberCall("createCipheriv")
        }

        DataFlow::Node getAlgorithm(){
            result = this.getArgument(0)
        }

        DataFlow::Node getKey(){
            result = this.getArgument(1)
        }

        DataFlow::Node getIv(){
            result = this.getArgument(2)
        }

        DataFlow::Node getOptions(){
            result = this.getArgument(3)
        }
    }
}