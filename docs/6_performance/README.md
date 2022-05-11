# 6. Performance

During the development lifecycle, we are usually building and testing iteratively (especially when using [TDD](https://en.wikipedia.org/wiki/Test-driven_development)).
It is therefore important to compare the speed of unit testing.

For this purpose, let's duplicate the contract and the unit test by a factor 20 and measure both compile and test times.

## nile 

```bash
$ time make
nile compile
🤖 Compiling all Cairo contracts in the contracts directory
🔨 Compiling contracts/provider.cairo
🔨 Compiling contracts/contract-4.cairo
🔨 Compiling contracts/contract-7.cairo
🔨 Compiling contracts/contract-13.cairo
🔨 Compiling contracts/contract-15.cairo
🔨 Compiling contracts/contract-8.cairo
🔨 Compiling contracts/contract-6.cairo
🔨 Compiling contracts/contract-12.cairo
🔨 Compiling contracts/contract-3.cairo
🔨 Compiling contracts/contract-9.cairo
🔨 Compiling contracts/contract-10.cairo
🔨 Compiling contracts/contract-17.cairo
🔨 Compiling contracts/contract-20.cairo
🔨 Compiling contracts/mocked_provider.cairo
🔨 Compiling contracts/contract.cairo
🔨 Compiling contracts/contract-14.cairo
🔨 Compiling contracts/contract-5.cairo
🔨 Compiling contracts/contract-19.cairo
🔨 Compiling contracts/contract-11.cairo
🔨 Compiling contracts/contract-2.cairo
🔨 Compiling contracts/contract-16.cairo
🔨 Compiling contracts/contract-18.cairo
✅ Done
make  33,80s user 1,78s system 100% cpu 35,567 total
```

```bash
$ time make test
pytest tests/
================================================== test session starts ===================================================
platform linux -- Python 3.9.12, pytest-7.1.2, pluggy-1.0.0
rootdir: /home/abuisset/Workspace/OnlyDust/protostar-vs-nile/nile-sample-project
plugins: typeguard-2.13.3, asyncio-0.18.3, web3-5.29.0
asyncio: mode=legacy
collected 20 items                                                                                                       

tests/test_contract-10.py .                                                                                        [  5%]
tests/test_contract-11.py .                                                                                        [ 10%]
tests/test_contract-12.py .                                                                                        [ 15%]
tests/test_contract-13.py .                                                                                        [ 20%]
tests/test_contract-14.py .                                                                                        [ 25%]
tests/test_contract-15.py .                                                                                        [ 30%]
tests/test_contract-16.py .                                                                                        [ 35%]
tests/test_contract-17.py .                                                                                        [ 40%]
tests/test_contract-18.py .                                                                                        [ 45%]
tests/test_contract-19.py .                                                                                        [ 50%]
tests/test_contract-2.py .                                                                                         [ 55%]
tests/test_contract-20.py .                                                                                        [ 60%]
tests/test_contract-3.py .                                                                                         [ 65%]
tests/test_contract-4.py .                                                                                         [ 70%]
tests/test_contract-5.py .                                                                                         [ 75%]
tests/test_contract-6.py .                                                                                         [ 80%]
tests/test_contract-7.py .                                                                                         [ 85%]
tests/test_contract-8.py .                                                                                         [ 90%]
tests/test_contract-9.py .                                                                                         [ 95%]
tests/test_contract.py .                                                                                           [100%]

======================================= 20 passed, 2 warnings in 88.09s (0:01:28) ========================================
make test  89,04s user 0,17s system 100% cpu 1:29,20 total
```
| Compilation | Test     |
| ----------- | -------- |
| 35s         | 1min 29s |

## protostar

```bash
$ time protostar build
protostar build  17,05s user 0,12s system 99% cpu 17,171 total
```

```bash
$ time protostar test
11:16:58 [INFO] Collected 20 suits, and 40 test cases
[PASS] tests/test_main-20.cairo test_increase_balance
[PASS] tests/test_main-13.cairo test_increase_balance
[PASS] tests/test_main-20.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-3.cairo test_increase_balance
[PASS] tests/test_main-11.cairo test_increase_balance
[PASS] tests/test_main-5.cairo test_increase_balance
[PASS] tests/test_main-13.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-8.cairo test_increase_balance
[PASS] tests/test_main.cairo test_increase_balance
[PASS] tests/test_main-15.cairo test_increase_balance
[PASS] tests/test_main-3.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-11.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-5.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-15.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-8.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-17.cairo test_increase_balance
[PASS] tests/test_main-17.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-16.cairo test_increase_balance
[PASS] tests/test_main-19.cairo test_increase_balance
[PASS] tests/test_main-6.cairo test_increase_balance
[PASS] tests/test_main-16.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-7.cairo test_increase_balance
[PASS] tests/test_main-10.cairo test_increase_balance
[PASS] tests/test_main-18.cairo test_increase_balance
[PASS] tests/test_main-19.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-6.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-7.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-2.cairo test_increase_balance
[PASS] tests/test_main-10.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-18.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-2.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-4.cairo test_increase_balance
[PASS] tests/test_main-12.cairo test_increase_balance
[PASS] tests/test_main-4.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-14.cairo test_increase_balance
[PASS] tests/test_main-12.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-9.cairo test_increase_balance
[PASS] tests/test_main-14.cairo test_cannot_increase_balance_with_negative_value
[PASS] tests/test_main-9.cairo test_cannot_increase_balance_with_negative_value

11:17:20 [INFO] Test suits: 20 passed, 20 total
11:17:20 [INFO] Tests:      40 passed, 40 total

protostar test  162,68s user 1,11s system 469% cpu 34,913 total
```
| Compilation | Test |
| ----------- | ---- |
| 17s         | 35s  |

## Conclusion

|             | nile         | protostar              |
| ----------- | ------------ | ---------------------- |
| Compilation | :x: 35s      | :heavy_check_mark: 17s |
| Test        | :x: 1min 29s | :heavy_check_mark: 35s |
