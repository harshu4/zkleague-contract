program acceptgame.aleo {

   record acceptgame{
        owner: address,
        gates: u64,
        gameid: u64,
        amount: u64,
        issuer: address,
        acceptor: address
        currentmove:u64,
        currentmoveplayer:u64,
        player1points: u64,
        player2points:u64,
        player1move1hash: field,
        player2move1: u64,
        player1move1:u64,
        player1move2hash: field,
        player2move2: u64,
        player1move2:u64
        player1move3hash: field,
        player2move3: u64,
        player1move3:u64
     
    }


    transition issuegame(gameid:u64,amount:u64,acceptor:address) -> acceptgame {
        
        return acceptgame{
            owner:acceptor,
            gates:0u64,
            gameid:gameid,
            amount: amount,
            issuer: self.caller,
            acceptor: acceptor,
            player1move1hash: BHP256::hash(0u64),
             currentmoveplayer:1u64,
        player2move1: 3u64,
        player1move1:3u64,
        player1move2hash: BHP256::hash(0u64),
        player2move2: 3u64,
        player1move2:3u64,
        player1move3hash: BHP256::hash(0u64),
        player2move3: 3u64,
        player1move3:3u64,
            currentmove: 0u64,
            player1points: 0u64,
            player2points: 0u64,
           
        };
        
    
    
    }

    transition acceptorgame(acceptor:acceptgame) -> acceptgame {
        
        return acceptgame{
            owner:acceptor.issuer,
            gates:0u64,
            gameid:acceptor.gameid,
            amount: acceptor.amount,
            issuer: acceptor.issuer,
            acceptor: self.caller,
            player1move1hash: BHP256::hash(0u64),
             currentmoveplayer:0u64,
        player2move1: 3u64,
        player1move1:3u64,
        player1move2hash: BHP256::hash(0u64),
        player2move2: 3u64,
        player1move2:3u64,
        player1move3hash: BHP256::hash(0u64),
        player2move3: 3u64,
        player1move3:3u64,
            currentmove: 0u64,
            player1points: 0u64,
            player2points: 0u64,
           
        };
        
    
    
    }
    

    transition initiatehash(acceptor:acceptgame,hash:field) -> acceptgame {
        assert(acceptor.currentmove <=2u64 );
        let player1move1hash:field = acceptor.player1move1hash;
        let player1move2hash:field = acceptor.player1move2hash;
        let player1move3hash:field = acceptor.player1move3hash;
       
        if(acceptor.currentmove == 0u64){
            assert(player1move1hash == BHP256::hash(0u64));
            player1move1hash = hash;
        }

        else if(acceptor.currentmove == 1u64){
            assert(player1move2hash == BHP256::hash(0u64));
            player1move2hash = hash;
        }

        else if(acceptor.currentmove == 2u64){
            assert(player1move3hash == BHP256::hash(0u64));
            player1move3hash = hash;
        }





        return acceptgame{
            owner:acceptor.acceptor,
            gates:0u64,
            gameid:acceptor.gameid,
            amount: acceptor.amount,
            issuer: acceptor.issuer,
            acceptor: self.caller,
           
          currentmoveplayer:0u64,
                        player1move1hash: player1move1hash,
        player2move1: acceptor.player2move1,
        player1move1:acceptor.player1move1,
        player1move2hash: player1move2hash,
        player2move2: acceptor.player2move2,
        player1move2:acceptor.player1move2,
        player1move3hash: player1move3hash,
        player2move3: acceptor.player2move3,
        player1move3:acceptor.player1move3,
            currentmove: acceptor.currentmove,
            player1points: acceptor.player1points,
            player2points: acceptor.player2points,
           
        };
        
    
    
    }

       transition acceptmove(acceptor:acceptgame,move:u64) -> acceptgame {
          assert(acceptor.currentmove <=2u64 );
        assert(move != 3u64);

        let player2move1:u64 = acceptor.player2move1;
         let player2move2:u64 = acceptor.player2move2;
          let player2move3:u64 = acceptor.player2move3;

               if(acceptor.currentmove == 0u64){
            assert(player2move1 == 3u64);
            player2move1 = move;
        }

        else if(acceptor.currentmove == 1u64){
            assert(player2move2 == 3u64);
            player2move2 = move;
        }

        else if(acceptor.currentmove == 2u64){
            assert(player2move3 == 3u64);
            player2move3 = move;
        }
         else{
            assert(false);
        }



        return acceptgame{
            owner:acceptor.issuer,
            gates:acceptor.gates,
            gameid:acceptor.gameid,
            amount: acceptor.amount,
            issuer: acceptor.issuer,
            acceptor: acceptor.acceptor,
            currentmove: acceptor.currentmove,
            player1points: acceptor.player1points,
            player2points: acceptor.player2points,
                    currentmoveplayer:0u64,
                        player1move1hash: acceptor.player1move1hash,
        player2move1: player2move1,
        player1move1:acceptor.player1move1,
        player1move2hash: acceptor.player1move2hash,
        player2move2: player2move2,
        player1move2:acceptor.player1move2,
        player1move3hash: acceptor.player1move3hash,
        player2move3: player2move3,
        player1move3:acceptor.player1move3,
           
        };
        
    
    
    }



    








       transition changemove(acceptor:acceptgame,won: u64,move: u64) -> acceptgame {
        let player1:u64 = acceptor.player1points;
        let player2:u64 = acceptor.player2points;
        let currentm: u64 = acceptor.currentmove;
        let player1move1:u64 = acceptor.player1move1;
         let player1move2:u64 = acceptor.player1move2;
          let player1move3:u64 = acceptor.player1move3;
        if(acceptor.currentmove == 0u64){
            assert(player1move1 == 3u64);
            player1move1 = move;
            currentm = currentm+1u64;
            
        }

        else if(acceptor.currentmove == 1u64){
            assert(player1move2 == 3u64);
            player1move2 = move;
              currentm = currentm+1u64;
            
        }

        else if(acceptor.currentmove == 2u64){
            assert(player1move3 == 3u64);
            player1move3 = move;
              currentm = currentm+1u64;
        }
        else{
            assert(false);
        }

  
        if(won==1u64){
            player1 = player1+1u64;
            
        }else if(won==2u64){
            player2 = player2+1u64;
        }

                return acceptgame{
            owner:acceptor.issuer,
            gates:acceptor.gates,
            gameid:acceptor.gameid,
            amount: acceptor.amount,
            issuer: acceptor.issuer,
            acceptor: acceptor.acceptor,
            currentmove: currentm,
            player1points: player1,
            player2points: player2,
                    currentmoveplayer:0u64,
                        player1move1hash: acceptor.player1move1hash,
        player2move1: acceptor.player2move1,
        player1move1:player1move1,
        player1move2hash: acceptor.player1move2hash,
        player2move2: acceptor.player2move2,
        player1move2:player1move2,
        player1move3hash: acceptor.player1move3hash,
        player2move3: acceptor.player2move3,
        player1move3:player1move3,
           
        };
    
    
    }
    }
/**
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
**/