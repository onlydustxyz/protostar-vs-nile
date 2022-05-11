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

`protostar` does not provide any command/tool to help with the deployment/interaction of a contract.
It also does not provide a local devnet for testing purposes.
It fully relies on `starknet-*` commands. The full list can be found [here](https://www.cairo-lang.org/docs/hello_starknet/cli.html)

:x: lack of local devnet


## Conclusion

| nile                                                                                                                 | protostar                |
| -------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| :heavy_check_mark: several useful commands to deploy and interact with a contract                                    | :x: lack of local devnet |
| :heavy_check_mark: support of a local node using [`starknet-devnet`](https://github.com/Shard-Labs/starknet-devnet/) |                          |
