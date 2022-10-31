import javascript

class CreateCipherivNumbers extends DataFlow::CallNode {
    CreateCipherivNumbers(){
        exists(DataFlow::SourceNode mod |
            mod = DataFlow::moduleImport("crypto") and
            this = mod.getAMemberCall("createCipheriv")
        )
    }

    int getIvLength(){
        result = this.getArgument(2).getStringValue().length()
    }
}

class GenerateKeyPairNumbers extends DataFlow::CallNode {
    GenerateKeyPairNumbers(){
        exists(DataFlow::SourceNode mod |
            mod = DataFlow::moduleImport("crypto") and
            this = mod.getAMemberCall("generateKeyPair"+["","Sync"])
        )
    }

    int getSaltLength(){
        result = this.getOptionArgument(1, "saltLength").getIntValue()
    }

    int getPrimeLength(){
        result = this.getOptionArgument(1, "primeLength").getIntValue()
    }
}

class ScryptNumbers extends DataFlow::CallNode {
    ScryptNumbers(){
        exists(DataFlow::SourceNode mod |
            mod = DataFlow::moduleImport("crypto") and
            this = mod.getAMemberCall("scrypt"+["","Sync"])
        )
    }

    int getSaltLength(){
        result = this.getArgument(1).getStringValue().length()
    }

    int getCost(){
        result = this.getOptionArgument(3, "cost").getIntValue()
    }
}