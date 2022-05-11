# 4.2 Unit testing - Mocking

To compare the mocking functionnalities, we will create a secondary contract, named `provider.cairo` with the only purpose is to act as an external dependancy. The code of this contract will be really straightforward:

```python
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@contract_interface
namespace IProvider:
    func provide() -> (value : felt):
    end
end

@external
func provide{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (value : felt):
    return (value=33)
end
```

Then we will modify the main contract to add the provider address and use it in the increase_balance() function.
```python
from contracts.provider import IProvider

@storage_var
func provider_() -> (res : felt):
end

@external
func increase_balance{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    amount : felt
):
    # ...
    let (provider) = provider_.read()
    let (provided_value) = IProvider.provide(provider)

    let (res) = balance.read()
    balance.write(res + amount + provided_value)
    # ...

    return ()
end

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    provider_contract : felt
):
    # ...
    provider_.write(provider_contract)
    return ()
end
```

Now let's try to mock this provider contract to make it return something else that `33`

## nile
I could not find an easier way to mock contracts using `nile` than creating a contract mock in cairo and providing its address.

Here is the `mocked_provider.cairo` code:
```python
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func mocked_value_() -> (res : felt):
end

@external
func provide{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (value : felt):
    return mocked_value_.read()
end

@external
func set_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(value : felt):
    mocked_value_.write(value)
    return ()
end
```

```python
MOCKED_PROVIDER_FILE = os.path.join("contracts", "mocked_provider.cairo")

# The testing library uses python's asyncio. So the following
# decorator and the ``async`` keyword are needed.
@pytest.mark.asyncio
async def test_increase_balance():
    # ...

    # Deploy the mocked provider
    mocked_provider = await starknet.deploy(
        source=MOCKED_PROVIDER_FILE,
    )

    # Deploy the contract.
    contract = await starknet.deploy(
        source=CONTRACT_FILE,
        constructor_calldata=[mocked_provider.contract_address]
    )

    # Set the mocked value 
    await mocked_provider.set_value(1).invoke()

    # ...

    # Check the result of get_balance().
    execution_info = await contract.get_balance().call()
    assert execution_info.result == (32,) # Added twice the mocked value
```

:x: no built-in mocking strategy

## protostar

Using protostar, it is much easier to mock a function call. There is a cheat code for that.
However, having a constructor with arguments will cause some pain here.
As we are importing the functions inside the unit tests, it will also import the constructor.
Which will make the test fail as you cannot control how the unit test is being created.

There are 2 solutions:
1. Deploy the contract using the `deploy_contract` cheat code. Using this will prevent the usage of hooks in the contract code, which limits the debugging possibilities. But we will cover that later.
2. Move all the internal logic into a dedicated cairo file (let's call it `library.cairo`) without constructor nor external/view functions. The contract will import the functions to use in its own external/view functions and the unit test will test the library. The drawback of this solution is that the contract it self is not being tested and would require a dedicated integration test for that, using option 1.

Option 2 is [considered best practice](https://github.com/OpenZeppelin/cairo-contracts/blob/main/docs/Extensibility.md) to improve encapsulation.
So I will choose this option in this repository.

Here is the updated unit test:
```python
%lang starknet
from src.library import internal, balance
from starkware.cairo.common.cairo_builtins import HashBuiltin

@view
func test_increase_balance{syscall_ptr : felt*, range_check_ptr, pedersen_ptr : HashBuiltin*}():
    const PROVIDER_ADDRESS = 123  # fake address

    let (result_before) = balance.read()
    assert result_before = 0

    %{
        expect_events({"name": "balance_increased", "data": [42]}) 
        mock_call(ids.PROVIDER_ADDRESS, 'provide', [1])
    %}
    internal.initialize(PROVIDER_ADDRESS)
    internal.increase_balance(42)

    let (result_after) = balance.read()
    assert result_after = 43  # Added the mocked provided value
    return ()
end

@view
func test_cannot_increase_balance_with_negative_value{
    syscall_ptr : felt*, range_check_ptr, pedersen_ptr : HashBuiltin*
}():
    let (result_before) = balance.read()
    assert result_before = 0

    %{ expect_revert("TRANSACTION_FAILED", "Amount must be positive") %}
    internal.increase_balance(-42)

    return ()
end
```

It is also possible to mock blockchain data using cheat codes:
- `start_prank/stop_prank` to mock the caller address
- `roll` to mock the current block number
- `warp` to mock the current block timestamp

:heavy_check_mark: built-in mocking cheat code <br/>
:heavy_check_mark: manual mocking is still possible <br/>
:heavy_check_mark: mocking of blockchain data using cheat codes

:x: cannot mock function calls based on parameters

## Conclusion

| nile                             | protostar                                                       |
| -------------------------------- | --------------------------------------------------------------- |
| :x: no built-in mocking strategy | :heavy_check_mark: built-in mocking cheat code                  |
|                                  | :heavy_check_mark: manual mocking is still possible             |
|                                  | :heavy_check_mark: mocking of blockchain data using cheat codes |
|                                  | :x: cannot mock function calls based on parameters              |
