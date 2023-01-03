program finalizemove.aleo {

     record finalizemove {
        owner: address,
        gates: u64,
        gameid: u64,
        movenum: u64,
        issuermove: u64,
        acceptormove:u64,
        winner:u64
    }

     transition finalizemoves(gameid:u64,movenum:u64,issuemov:u64,acceptormove:u64,winner:u64) -> finalizemove {
        
        return finalizemove{
            owner:self.caller,
            gates:0u64,
            gameid:gameid,
            movenum:movenum,
            issuermove:issuemov,
            acceptormove:acceptormove,
            winner:winner
        };
        
    
    
    }



}