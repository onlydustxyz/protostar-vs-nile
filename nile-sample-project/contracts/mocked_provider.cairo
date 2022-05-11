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
