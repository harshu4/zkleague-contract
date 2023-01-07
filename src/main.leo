// The `program` scope defines the data types, functions, and state associated with the `token` program.

import acceptgame.leo;

program game.aleo {
    // On-chain storage of an `account` map, with `address` as the key,
    // and `u64` as the value.
    mapping account: address => u64;

    record token {
        // The token owner.
        owner: address,
        // The Aleo balance (in gates).
        gates: u64,
        // The token amount.
        amount: u64,
    }


     transition faucet() -> token {
        return token {
            owner: self.caller,
            gates: 0u64,
            amount: 50u64,
        };
    }




    /* Balance */

    transition start (
        gameid:u64,
        amount:u64,
        rec:token,
        acceptor:address
    ) -> (acceptgame.leo/acceptgame.record,token) {
        assert(rec.amount>=amount);
        let transferred: token = token {
            owner : self.caller,
            gates: 0u64,
            amount: rec.amount-amount,
        };
        let state : acceptgame = acceptgame.leo/issuegame(gameid,amount,acceptor);
        return (state,transferred);

    }

    transition accept (
        game: acceptgame.leo/acceptgame.record,
        rec :token
    ) -> (acceptgame.leo/acceptgame.record,token){
         assert(rec.amount>=game.amount);
        let transferred: token = token {
            owner : self.caller,
            gates: 0u64,
            amount: rec.amount-game.amount,
        };
       
        
        let state: acceptgame = acceptgame.leo/acceptorgame(game);
        return (state,transferred);   
    }

      transition main(public a: u32, b: u32) -> u32 {
        let c: u32 = a + b;
        return c;
    }



    transition initiatemove
    (
    game:acceptgame.leo/acceptgame.record,
    move:u64,
    ) -> (acceptgame.leo/acceptgame.record){
        assert_eq(game.issuer,self.caller);
        let hash:field = BHP256::hash(move);
         let boba: acceptgame =   acceptgame.leo/initiatehash(game,hash);     
        return boba;


    }


    transition challengemove(
      
        game: acceptgame.leo/acceptgame.record,
        move:u64
    ) -> (acceptgame.leo/acceptgame.record){
        

        let boba: acceptgame =   acceptgame.leo/acceptmove(game,move);     
        return boba;

    }


    transition  finalizemov(

        game: acceptgame.leo/acceptgame.record,
       
         playermove: u64
    ) -> acceptgame.leo/acceptgame.record{
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
        
        let state2: acceptgame = acceptgame.leo/changemove(game,winner,playermov);

        
        return (state2);

    }


}
/**

    transition winners( game: acceptgame.leo/acceptgame.record)->  token{
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
             
    }
      
    


    transition main(public a: u32, b: u32) -> u32 {
        let c: u32 = a + b;
        return c;
    }
    
}
**/