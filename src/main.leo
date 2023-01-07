// The `program` scope defines the data types, functions, and state associated with the `token` program.


program game.aleo {
    // On-chain storage of an `account` map, with `address` as the key,
    // and `u64` as the value.
    mapping account: address => u64;
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
        player1move3:u64,
     
    }




    /* Balance */

    transition start (
        gameid:u64,
        amount:u64,
        acceptor:address
    ) -> acceptgame {
        
        
      
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


/**
     function issuegame(gameid:u64,amount:u64,acceptor:address,sol:address) -> acceptgame {
        
        return acceptgame{
            owner:acceptor,
            gates:0u64,
            gameid:gameid,
            amount: amount,
            issuer: sol,
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
**/
    transition accept (
        game: acceptgame,
    
    ) -> acceptgame{
        
        
       
        
         return acceptgame{
            owner:game.issuer,
            gates:0u64,
            gameid:game.gameid,
            amount: game.amount,
            issuer: game.issuer,
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

    /**
  function acceptorgame(acceptor:acceptgame,sol:address) -> acceptgame {
        
        return acceptgame{
            owner:acceptor.issuer,
            gates:0u64,
            gameid:acceptor.gameid,
            amount: acceptor.amount,
            issuer: acceptor.issuer,
            acceptor: sol,
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
    **/
    
 



    transition initiatemove
    (
    game:acceptgame,
    move:u64
    ) -> acceptgame{
        assert_eq(game.issuer,self.caller);
        let hash:field = BHP256::hash(move);
assert(game.currentmove <=2u64 );
        let player1move1hash:field = game.player1move1hash;
        let player1move2hash:field = game.player1move2hash;
        let player1move3hash:field = game.player1move3hash;
       
        if(game.currentmove == 0u64){
            assert(player1move1hash == BHP256::hash(0u64));
            player1move1hash = hash;
        }

        else if(game.currentmove == 1u64){
            assert(player1move2hash == BHP256::hash(0u64));
            player1move2hash = hash;
        }

        else if(game.currentmove == 2u64){
            assert(player1move3hash == BHP256::hash(0u64));
            player1move3hash = hash;
        }





        return acceptgame{
            owner:game.acceptor,
            gates:0u64,
            gameid:game.gameid,
            amount: game.amount,
            issuer: game.issuer,
            acceptor: game.acceptor,
           
          currentmoveplayer:0u64,
                        player1move1hash: player1move1hash,
        player2move1: game.player2move1,
        player1move1:game.player1move1,
        player1move2hash: player1move2hash,
        player2move2: game.player2move2,
        player1move2:game.player1move2,
        player1move3hash: player1move3hash,
        player2move3: game.player2move3,
        player1move3:game.player1move3,
            currentmove: game.currentmove,
            player1points: game.player1points,
            player2points: game.player2points,
           
        };
    


    }


/**
     function initiatehash(acceptor:acceptgame,hash:field) -> acceptgame {
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
            acceptor: acceptor.acceptor,
           
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

**/

    transition challengemove(
      
        game: acceptgame,
        move:u64
    ) -> acceptgame{
        
 assert(game.currentmove <=2u64 );
        assert(move != 3u64);

        let player2move1:u64 = game.player2move1;
         let player2move2:u64 = game.player2move2;
          let player2move3:u64 = game.player2move3;

               if(game.currentmove == 0u64){
            assert(player2move1 == 3u64);
            player2move1 = move;
        }

        else if(game.currentmove == 1u64){
            assert(player2move2 == 3u64);
            player2move2 = move;
        }

        else if(game.currentmove == 2u64){
            assert(player2move3 == 3u64);
            player2move3 = move;
        }
         else{
            assert(false);
        }



        return acceptgame{
            owner:game.issuer,
            gates:game.gates,
            gameid:game.gameid,
            amount: game.amount,
            issuer: game.issuer,
            acceptor: game.acceptor,
            currentmove: game.currentmove,
            player1points: game.player1points,
            player2points: game.player2points,
                    currentmoveplayer:0u64,
                        player1move1hash: game.player1move1hash,
        player2move1: player2move1,
        player1move1:game.player1move1,
        player1move2hash: game.player1move2hash,
        player2move2: player2move2,
        player1move2:game.player1move2,
        player1move3hash: game.player1move3hash,
        player2move3: player2move3,
        player1move3:game.player1move3,
         

    };
    }
      
 /**     function acceptmove(acceptor:acceptgame,move:u64) -> acceptgame {
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

**/
    transition  finalizemov(

        game: acceptgame,
       
         playermove: u64
    ) -> acceptgame{
        assert(game.currentmove<3u64);
        let acceptormove:u64 = 3u64;

          if(game.currentmove == 0u64){
            assert(game.player1move1hash == BHP256::hash(playermove));
             acceptormove = game.player2move1;
        }

        else if(game.currentmove == 1u64){
             assert(game.player1move2hash == BHP256::hash(playermove)); 
             acceptormove = game.player2move2;

        }

        else if(game.currentmove == 2u64){
            assert(game.player1move3hash == BHP256::hash(playermove)); 
             acceptormove = game.player2move3;
           
        }
        else{
            assert(false);
        }

        assert(acceptormove != 3u64);
        let playermov: u64 = playermove.mod(1009u64);
        let winner:u64 = 0u64;
        if(playermov == acceptormove){
                   winner = 0u64;

        }
        // 0 = wand , 1= talwar, 2=defense
        else{
            if(playermov==0u64 && acceptormove == 1u64){
             winner = 2u64;
            }
            else if(playermov==1u64 && acceptormove == 0u64){
                  winner = 1u64;
            
            }

            else if(playermov==0u64 && acceptormove == 2u64){
                   winner = 1u64;
            }

            else if(playermov==2u64 && acceptormove == 0u64){
                   winner= 2u64;
            }

            else if(playermov==2u64 && acceptormove == 1u64){
                    winner= 1u64;
            }

            else if(playermov==1u64 && acceptormove == 2u64){
                    winner= 2u64;
            }
        }
        
        let player1:u64 = game.player1points;
        let player2:u64 = game.player2points;
        let currentm: u64 = game.currentmove;
        let player1move1:u64 = game.player1move1;
         let player1move2:u64 = game.player1move2;
          let player1move3:u64 = game.player1move3;
        if(game.currentmove == 0u64){
            assert(player1move1 == 3u64);
            player1move1 = playermov;
            currentm = currentm+1u64;
            
        }

        else if(game.currentmove == 1u64){
            assert(player1move2 == 3u64);
            player1move2 = playermov;
              currentm = currentm+1u64;
            
        }

        else if(game.currentmove == 2u64){
            assert(player1move3 == 3u64);
            player1move3 = playermov;
              currentm = currentm+1u64;
        }
        else{
            assert(false);
        }

  
        if(winner==1u64){
            player1 = player1+1u64;
            
        }else if(winner==2u64){
            player2 = player2+1u64;
        }

                return acceptgame{
            owner:game.issuer,
            gates:game.gates,
            gameid:game.gameid,
            amount: game.amount,
            issuer: game.issuer,
            acceptor: game.acceptor,
            currentmove: currentm,
            player1points: player1,
            player2points: player2,
                    currentmoveplayer:0u64,
                        player1move1hash: game.player1move1hash,
        player2move1: game.player2move1,
        player1move1:player1move1,
        player1move2hash: game.player1move2hash,
        player2move2: game.player2move2,
        player1move2:player1move2,
        player1move3hash: game.player1move3hash,
        player2move3: game.player2move3,
        player1move3:player1move3,
       
    };}
    

/**
           function changemove(acceptor:acceptgame,won: u64,move: u64) -> acceptgame {
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
**/




  /**  transition winners( game: acceptgame.leo/acceptgame.record)->  token{
        assert(game.currentmove>=3u64);
        if(game.player1points > game.player2points)  {
            return token{
                owner : game.issuer,
                gates : 0u64,
                amount : game.amount*2u64
            };

        }
        else if (game.player2points > game.player1points){
            return token{
                owner : game.acceptor,
                gates : 0u64,
                amount : game.amount*2u64
            };

        }
        else{
            if (self.caller==game.issuer) {
                  return token{
                owner : game.issuer,
                gates : 0u64,
                amount : game.amount
                };
            }
            else if (self.caller== game.acceptor){
                  return token{
                owner : game.acceptor,
                gates : 0u64,
                amount : game.amount
                };
            }

        }
          return token{
              owner : game.acceptor,
                gates : 0u64,
                amount : 0u64
        };
             
    }**/
      
    


    transition main(public a: u32, b: u32) -> u32 {
        let c: u32 = a + b;
        return c;
    }
    
}
