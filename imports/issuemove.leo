program issuemove.aleo {

     record issuemove{
        owner: address,
        gates: u64,
        gameid: u64,
        movenum: u64,
        issuehash: field
    }


    transition issuemoves(gameid:u64,movenum:u64,issuehash:field) -> issuemove {
        
        return issuemove{
            owner:self.caller,
            gates:0u64,
            gameid:gameid,
            movenum:movenum,
            issuehash:issuehash
        };
        
    
    
    }




}