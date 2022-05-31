<div align="center">
  <h1 align="center">protostar vs nile</h1>
  <p align="center">
    <a href="https://discord.gg/onlydust">
        <img src="https://img.shields.io/badge/Discord-6666FF?style=for-the-badge&logo=discord&logoColor=white"/>
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=onlydust_xyz">
        <img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white"/>
    </a>
    <a href="https://contributions.onlydust.xyz/">
        <img src="https://img.shields.io/badge/Contribute-6A1B9A?style=for-the-badge&logo=notion&logoColor=white"/>
    </a>
  </p>

</div>

This repository aims at comparing 2 development frameworks for starknet smart contract development:
- [protostar](https://docs.swmansion.com/protostar/)
- [nile](https://github.com/OpenZeppelin/nile)

You can see the results of the comparision below or jump to any subject for more details.

# Table of contents

1. [Installation](./docs/1_installation/)
2. [Project initialization](./docs/2_initialization/)
3. [Compilation](./docs/3_compilation/)
4. [Unit testing](./docs/4_unit-testing/)
   1. [Assertions](./docs/4_unit-testing/1_assertions/)
   2. [Mocking](./docs/4_unit-testing/2_mocking/)
   3. [Debugging](./docs/4_unit-testing/3_debugging/)
5. [Deployment](./docs/5_deployment/)
6. [Performances](./docs/6_performance/)

# Conclusion

Here is the full list of comparisons:

<table>
   <thead>
      <tr>
         <th>Step</th>
         <th>nile</th>
         <th>protostar</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>1. <a href="./docs/1_installation/">Installation</a></td>
         <td>
            :heavy_check_mark: isolated in a python virtual env <br/>
            :x: <code>cairo-lang</code> is not compatible with latest python, requires a dedicated setup
         </td>
         <td>
            :heavy_check_mark: one-liner installation script
         </td>
      </tr>
      <tr>
         <td>2. <a href="./docs/2_initialization/">Project initialization</a></td>
         <td>
            :heavy_check_mark: one-liner to initialize a project<br/>
            :heavy_check_mark: install all required dependencies<br/>
            :heavy_check_mark: generate <code>.gitignore</code> and <code>Makefile</code>
         </td>
         <td>
            :heavy_check_mark: one-liner to initialize a project<br/>
            :x: forces the generation of a git repository
         </td>
      </tr>
      <tr>
         <td>3. <a href="./docs/3_compilation/">Compilation</a></td>
         <td>
            :heavy_check_mark: pretty output<br/>
            :heavy_check_mark: all contracts are automatically detected<br/>
            :x: compilation error messages are difficult to understand<br/>
            :x: does not support multiple contracts with the same name<br/>
            :x: requires a pip module to use an external library
         </td>
         <td>
            :x: need to provide all contract files in <code>protostar.toml</code><br/>
            :x: compilation error messages are difficult to understand<br/>
            :x: requires a git repository to use an external library
         </td>
      </tr>
      <tr>
         <td>4.1. <a href="./docs/4_unit-testing/1_assertions/">Unit testing - Assertions</a></td>
         <td>
            :heavy_check_mark: relies on proven <code>pytest</code> framework<br/>
            :heavy_check_mark: all the power of python<br/>
            :x: need to be familiar with <code>python</code><br/>
            :x: need to explicitely deploy the contract to test it
         </td>
         <td>
            :heavy_check_mark: uses same language as smart contract development<br/>
            :heavy_check_mark: can still use <code>python</code> hints to manipulate data or perform assertions <br/>
            :heavy_check_mark: nice output<br/>
         </td>
      </tr>
      <tr>
         <td>4.2. <a href="./docs/4_unit-testing/2_mocking/">Unit testing - Mocking</a></td>
         <td>
            :x: no built-in mocking strategy 
         </td>
         <td>
            :heavy_check_mark: built-in mocking cheat code<br/>
            :heavy_check_mark: manual mocking is still possible<br/>
            :heavy_check_mark: mocking of blockchain data using cheat codes <br/>
            :x: cannot mock function calls based on parameters
         </td>
      </tr>
      <tr>
         <td>4.3. <a href="./docs/4_unit-testing/3_debugging/">Unit testing - Debugging</a></td>
         <td>
            :x: no extra tool to help unit test debugging
         </td>
         <td>
            :heavy_check_mark: usage of hints are very useful for debugging purposes
         </td>
      </tr>
      <tr>
         <td>5. <a href="./docs/5_deployment/">Deployment</a></td>
         <td>
            :heavy_check_mark: several useful commands to deploy and interact with a contract<br/>
            :heavy_check_mark: support of a local node using <a href="https://github.com/Shard-Labs/starknet-devnet/"><code>starknet-devnet</code></a>
         </td>
         <td>
            :heavy_check_mark: support of contract deployment<br/>
            :x: lack of local devnet
         </td>
      </tr>
      <tr>
         <td>6. <a href="./docs/6_performance/">Performances</a></td>
         <td>
            :x: Compilation: 35s<br/>
            :x: Test: 1min 29s
         </td>
         <td>
            :heavy_check_mark: Compilation: 17s<br/>
            :heavy_check_mark: Test: 35s
         </td>
      </tr>
   </tbody>
</table>

As a conclusion, `protostar` offers more features during the development life cycle and is also way faster. Which is a nice advantage especially when using TDD.

`nile`, on the other hand, offers more feature during the deployment, especially thanks to its compatibility with [`starknet-devnet`](https://github.com/Shard-Labs/starknet-devnet/) for running a local node.

Let's see how both projects evolve in the future and if more features are added.