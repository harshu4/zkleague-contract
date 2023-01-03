

program acceptmove.aleo {

     record acceptmove{
        owner: address,
        gates: u64,
        gameid: u64,
        movenum: u64,
        issuehash: field,
        acceptormove:u64,
    }

    transition acceptmoves(gameid:u64,movenum:u64,issuehash:field,acceptormove:u64) -> acceptmove {

        return acceptmove{
            owner:self.caller,
            gates: 0u64,
            gameid: gameid,
            movenum:movenum,
            issuehash:issuehash,
            acceptormove:acceptormove
        };


    }



}