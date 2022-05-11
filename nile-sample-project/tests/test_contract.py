"""contract.cairo test file."""
from copyreg import constructor
import os

import pytest
from starkware.starknet.testing.starknet import Starknet
from starkware.starknet.business_logic.execution.objects import Event
from starkware.starknet.public.abi import get_selector_from_name
from starkware.starkware_utils.error_handling import StarkException

def assert_event_emitted(tx_exec_info, from_address, name, data):
    assert (
        Event(
            from_address=from_address,
            keys=[get_selector_from_name(name)],
            data=data,
        )
        in tx_exec_info.raw_events
    )

async def assert_revert(fun, reverted_with=None):
    try:
        await fun
        assert False
    except StarkException as err:
        _, error = err.args
        if reverted_with is not None:
            assert reverted_with in error["message"]


# The path to the contract source code.
CONTRACT_FILE = os.path.join("contracts", "contract.cairo")
MOCKED_PROVIDER_FILE = os.path.join("contracts", "mocked_provider.cairo")


# The testing library uses python's asyncio. So the following
# decorator and the ``async`` keyword are needed.
@pytest.mark.asyncio
async def test_increase_balance():
    """Test increase_balance method."""
    # Create a new Starknet class that simulates the StarkNet
    # system.
    starknet = await Starknet.empty()

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

    # Invoke increase_balance() twice.
    execution_info = await contract.increase_balance(amount=10).invoke()
    assert_event_emitted(execution_info, contract.contract_address, 'balance_increased', [10])

    await contract.increase_balance(amount=20).invoke()

    # Check the result of get_balance().
    execution_info = await contract.get_balance().call()
    assert execution_info.result == (32,) # Added twice the mocked value

    # Check for transaction revert
    await assert_revert(contract.increase_balance(amount=-1).invoke(), "Amount cannot be negative")
