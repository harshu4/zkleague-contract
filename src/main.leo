// The `program` scope defines the data types, functions, and state associated with the `token` program.
import issuegame.leo;
import acceptgame.leo;
import issuemove.leo;
import acceptmove.leo;
import finalizemove.leo;

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
    /* Balance */

    transition start (
        gameid:u64,
        amount:u64,
    ) -> issuegame.leo/issuegame.record {

        let state : issuegame = issuegame.leo/issuegames(gameid,amount);
        return state;

    }

    transition accept (
        game: issuegame.leo/issuegame.record
    ) -> acceptgame.leo/acceptgame.record{
        let state: acceptgame = acceptgame.leo/acceptgames(game.gameid,game.amount,game.issuer);
        return state;   
    }

    transition initiatemove
    (
    game:acceptgame.leo/acceptgame.record,
    move:u64,
    ) -> issuemove.leo/issuemove.record{
        let movenum:u64 = game.currentmove+1u64;
        let hash:field = BHP256::hash(move);
        let state: issuemove = issuemove.leo/issuemoves(game.gameid,movenum,hash);
        return state  ;


    }


    transition challengemove(
        move:issuemove.leo/issuemove.record,
        mymove:u64
    ) -> acceptmove.leo/acceptmove.record{

        let state : acceptmove = acceptmove.leo/acceptmoves(move.gameid,move.movenum,move.issuehash,mymove);
        return state;

    }

    transition  finalizemov(

        game: acceptgame.leo/acceptgame.record,
        move:acceptmove.leo/acceptmove.record,
       
         playermove: u64,
    ) -> acceptgame.leo/acceptgame.record{
        assert(game.currentmove<3u64);
        assert_eq(BHP256::hash(playermove),move.issuehash);
        let playermov: u64 = playermove.mod(1009u64);
        let winner:u64 = 0u64;
        if(playermov == move.acceptormove){
                   winner = 0u64;

        }
        // 0 = wand , 1= talwar, 2=defense
        else{
            if(playermov==0u64 && move.acceptormove == 1u64){
             winner = 2u64;
            }
            else if(playermov==1u64 && move.acceptormove == 0u64){
                  winner = 1u64;
            
            }

            else if(playermov==0u64 && move.acceptormove == 2u64){
                   winner = 1u64;
            }

            else if(playermov==2u64 && move.acceptormove == 0u64){
                   winner= 2u64;
            }

            else if(playermov==2u64 && move.acceptormove == 1u64){
                    winner= 1u64;
            }

            else if(playermov==1u64 && move.acceptormove == 2u64){
                    winner= 2u64;
            }
        }
        let mov:u64 = game.currentmove+1u64;
        let state2: acceptgame = acceptgame.leo/changemove(game,mov,winner);
        let state: finalizemove = finalizemove.leo/finalizemoves(game.gameid,move.movenum,playermov,move.acceptormove,winner);
        return (state2);

    }


    transition main(public a: u32, b: u32) -> u32 {
        let c: u32 = a + b;
        return c;
    }
    
}