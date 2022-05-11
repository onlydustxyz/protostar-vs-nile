%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.provider import IProvider

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

namespace internal:
    func increase_balance{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        amount : felt
    ):
        with_attr error_message("Amount must be positive. Got: {amount}."):
            assert_nn(amount)
        end

        let (provider) = provider_.read()
        let (provided_value) = IProvider.provide(provider)
        let (res) = balance.read()
        let total = res + amount + provided_value

        # %{ print('{} + {} + {} = {}'.format(ids.res, ids.amount, ids.provided_value, ids.total)) %}
        balance.write(total)

        # Emit the event
        balance_increased.emit(amount)

        return ()
    end

    func get_balance{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
        res : felt
    ):
        let (res) = balance.read()
        return (res)
    end

    func initialize{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        provider_contract : felt
    ):
        balance.write(0)
        provider_.write(provider_contract)
        return ()
    end
end
