program issuegame.aleo {

    record issuegame{
        owner: address,
        gates: u64,
        gameid: u64,
        amount: u64,
        issuer: address
    }


    transition issuegames(gameid:u64,amount:u64) -> issuegame {
        
        return issuegame{
            owner:self.caller,
            gates:0u64,
            gameid:gameid,
            amount: amount,
            issuer: self.caller
        };
        
    
    
    }







}