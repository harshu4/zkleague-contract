program acceptgame.aleo {

   record acceptgame{
        owner: address,
        gates: u64,
        gameid: u64,
        amount: u64,
        issuer: address,
        acceptor: address
        currentmove:u64,
        player1points: u64,
        player2points:u64,
     
    }


    transition acceptgames(gameid:u64,amount:u64,issuer:address) -> acceptgame {
        
        return acceptgame{
            owner:self.caller,
            gates:0u64,
            gameid:gameid,
            amount: amount,
            issuer: issuer,
            acceptor: self.caller,
            currentmove: 0u64,
            player1points: 0u64,
            player2points: 0u64,
           
        };
        
    
    
    }

       transition changemove(acceptor:acceptgame,movenum : u64,won: u64) -> acceptgame {
        let player1:u64 = acceptor.player1points;
        let player2:u64 = acceptor.player2points;
  
        if(won==1u64){
            player1 = player1+1u64;
            
        }else if(won==2u64){
            player2 = player2+1u64;
        }

        return acceptgame{
            owner:acceptor.owner,
            gates:acceptor.gates,
            gameid:acceptor.gameid,
            amount: acceptor.amount,
            issuer: acceptor.issuer,
            acceptor: acceptor.acceptor,
            currentmove: movenum,
            player1points:player1,
            player2points:player2
        };
        
    
    
    }

    transition mock(accepto:acceptgame) -> acceptgame{
        let ab: u64 = accepto.currentmove;
       
        return acceptgame{
            owner:accepto.owner,
            gates:accepto.gates,
            gameid:accepto.gameid,
            amount: accepto.amount,
            issuer: accepto.issuer,
            acceptor: accepto.acceptor,
            currentmove:accepto.currentmove,
            player1points:accepto.player1points,
            player2points:accepto.player2points
        };
    }


}