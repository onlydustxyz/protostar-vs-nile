%lang starknet
from src.library import internal, balance
from starkware.cairo.common.cairo_builtins import HashBuiltin

@view
func test_increase_balance{syscall_ptr : felt*, range_check_ptr, pedersen_ptr : HashBuiltin*}():
    alloc_locals

    const PROVIDER_ADDRESS = 123  # fake address

    let (result_before) = balance.read()
    assert result_before = 0

    %{
        expect_events({"name": "balance_increased", "data": [42]}) 
        mock_call(ids.PROVIDER_ADDRESS, 'provide', [1])
    %}
    internal.initialize(PROVIDER_ADDRESS)
    internal.increase_balance(42)

    let (local result_after) = balance.read()
    local expected_result = 43

    with_attr error_message(
            "Invalid balance after update, expected {expected_result}, got {result_after}"):
        assert result_after = expected_result  # Added the mocked provided value
    end
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
