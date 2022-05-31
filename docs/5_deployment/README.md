# 5. Deployment and interaction

Once our smart contract is built and tested, it is time to deploy it and interact with it.

## nile 

`nile` offers several commands to help during contracts deployments:
- `nile node` to run a local node using [`starknet-devnet`](https://github.com/Shard-Labs/starknet-devnet/)
- `nile deploy contract --alias my_contract` to deploy a smart contract
- `nile setup <private_key_alias>` to deploy an account 
- `nile send <private_key_alias> <contract_identifier> <method> [PARAM_1, PARAM2...]` to interact with a deployed contract using a given account
- `nile [call|invoke] <contract_identifier> <method> [PARAM_1, PARAM2...]` to perform read/write operations on a contract

However, if we compare the CLI of `nile` with the built-in [starknet CLI](https://www.cairo-lang.org/docs/hello_starknet/cli.html), we can observe there are not a lot of differences.
The main added value is the support of the `localhost` network.

:heavy_check_mark: several useful commands to deploy and interact with a contract <br/>
:heavy_check_mark: support of a local node using [`starknet-devnet`](https://github.com/Shard-Labs/starknet-devnet/)

## protostar

`protostar` offers the possibility to [deploy a smart contract](https://docs.swmansion.com/protostar/docs/tutorials/guides/deploying) once it has been compiled.
The interface is similar to the [`starknet-deploy`](https://www.cairo-lang.org/docs/hello_starknet/cli.html) API:
```
protostar deploy ./build/main.json --network alpha-goerli
```
However, there is local devnet support.

:heavy_check_mark: support of contract deployment <br/>
:x: lack of local devnet


## Conclusion

| nile                                                                                                                 | protostar                                         |
| -------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| :heavy_check_mark: several useful commands to deploy and interact with a contract                                    | :heavy_check_mark: support of contract deployment |
| :heavy_check_mark: support of a local node using [`starknet-devnet`](https://github.com/Shard-Labs/starknet-devnet/) | :x: lack of local devnet                          |
