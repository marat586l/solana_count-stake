# solana_count-stake
Calculates the total stack on the account from all withdrawers and the total amount
Calculates the total stake on the account from all  withdrawers  and the total amount.
If the script is called without parameters, it looks for the file ~/solana/vote-account-keypair.json  in the current directory. Otherwise, you need to specify a public key for counting. If the request is made to another network, then the second parameter must be specified as -ut or -um, respectively.
