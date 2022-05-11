# 3. Compilation

Both frameworks generate a smart contract sample as well as a unit test.
Both generated contracts are similar. This will ease the rest of the work.
Sometimes, we need to rely on external libraries. We will also compare how to integrate external dependencies.

## nile
```bash
nile compile
```

The compiled artifacts are generated in the `artifacts` folder. This folder contains both compiled contracts and abis.
All contracts are automatically detected.
However, note that if 2 contracts ahev the same name, `nile` won't complain about it but will silently fail later.

External dependencies (such as [OpenZeppelin](https://github.com/OpenZeppelin/cairo-contracts)) are managed using python module.
In order to install it, you can run
```
pip install openzeppelin-cairo-contracts
```

:heavy_check_mark: Pretty output<br/>
:heavy_check_mark: All contracts are automatically detected

:x: compilation error messages are difficult to understand
:x: does not support multiple contracts with the same name
:x: requires a pip module to use an external library

## protostar
```
protostar build
```
The compiled artifacts are generated in the `build` folder. This folder contains both compiled contracts and abis.

`protostar` offers a compilation flag `--disable-hint-validation` to allow hints to be part of a smart contract, which is really convenient for debugging purposes.

External dependencies (such as [OpenZeppelin](https://github.com/OpenZeppelin/cairo-contracts)) are managed using git submodules.
In order to install it, you can run
```bash
protostar install https://github.com/OpenZeppelin/cairo-contracts 
```

:heavy_check_mark: Faster to compile

:x: need to provide all contract files in `protostar.toml` <br/>
:x: compilation error messages are difficult to understand
:x: requires a git repository to use an external library

## Conclusion

| nile                                                        | protostar                                                  |
| ----------------------------------------------------------- | ---------------------------------------------------------- |
| :heavy_check_mark: pretty output                            | :x: need to provide all contract files in `protostar.toml` |
| :heavy_check_mark: all contracts are automatically detected | :x: compilation error messages are difficult to understand |
| :x: compilation error messages are difficult to understand  |                                                            |
