# Bitcoin-Miner

run `mix escribt.build` to create executable `project1`

run `./project1 3` on on machine . Here 3 is value of K and it tries to find all strings which have 5 starting zeros in their SHA256 hash. Increasing K can reduce the number of strings found or atleast delay the success of finding such a string. 

It will also ask you the ip you want this server to listen on for incoming connections in order to distribute this bruteforce hashing work.

On another machine run `project1 <ip of 1st machine>` this will request the server for work and some of the hashes will be computed on this machine but the output i.e the successful strings found ( bitcoins ) are always printed only on the main server machine terminal.   
