# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_nn
from contracts.provider import IProvider

# Define a storage variable.
@storage_var
func balance() -> (res : felt):
end

@storage_var
func provider_() -> (res : felt):
end

# Define the event
@event
func balance_increased(amount : felt):
end

# Increases the balance by the given amount.
@external
func increase_balance{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    amount : felt
):
    with_attr error_message("Amount cannot be negative"):
        assert_nn(amount)
    end

    let (provider) = provider_.read()
    let (provided_value) = IProvider.provide(provider)

    let (res) = balance.read()
    balance.write(res + amount + provided_value)

    # Emit the event
    balance_increased.emit(amount)
    return ()
end

# Returns the current balance.
@view
func get_balance{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    res : felt
):
    let (res) = balance.read()
    return (res)
end

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    provider_contract : felt
):
    provider_.write(provider_contract)
    return ()
end
