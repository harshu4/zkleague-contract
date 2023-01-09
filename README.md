
## ZK League

Game Link :  [Click Here](https://game.galacticwar.live/)

Github Link :  [Click Here](https://github.com/harshu4/zkleague-contract)


A zero knowledge PvP game between two players so they can play the game and decide the winner themselves without depending on any third party. The game is built on Aleo and utilizes the record based model to utilize the zk. 


## Why ❓

Gamers have recently understood that centralized institutions are fragile. By utilizing ZK-proofs we can essentailly eliminate centralized servers and still no player would be  able to cheat.  

## Gameplay 📜


**Battle in a trustless manner with ZK**  

The core of this game lies in a trustless setup battle, there are two players and three rounds. each player can choose among the following three moves: 

- Wand :- This is the magical power move
- Sword :- An action move
- Defends :- Defends against the opponent 

Whoever has  the most points after three rounds wins the battle !

**Utilizing ZK**

 We have utilizied Zero-knowledge proofs to make this rounds trustless, 
 
- The first player computes the hash of prime_number*randomnumber+move and passes it as a record to the second player
- The second player tells his value for the round
- Now the first player discloses this value of move for the round and it is easily verifiable that the if the value is pre-image of hash or not 

Note that the prime number is known by both parties but the random number is not and it is used as an salt so that the player2 can't pre-compute the hash of all moves. Taking a big enough primenumber and random number will stop player2 from attempting to be malicious



## Architecture ✨

Aleo : We have used Aleo's record based model to accomodate our zero knowledge logic that we built using the leo language. 

Slingshot : Slingshot is a local node that we are using so we can maintain the commitments as deployment is currently not available on testnet3

Unity : We have built this game using unity webgl

