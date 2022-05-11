# 4.3 Unit testing - Debugging

Another aspect of unit testing is how to debug when a unit test is failing.
As far as I know, there is no step-by-step debugger for starknet smart contract.
Although it is possible to debug a cairo program using [some tricks](https://www.cairo-lang.org/docs/how_cairo_works/debugging_tricks.html), it is not really straightforward

## nile

:x: no extra tool to help unit test debugging

## protostar

As protostar allows the usage of hints in a unit test, it is also possible to use them in the smart contract code -- as long as the tested function is imported in the unit test (and not deployed using a hint)

Here is an example.

In `library.cairo`, we can add a hint to add some debugging traces:
```python
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

        %{ print('{} + {} + {} = {}'.format(ids.res, ids.amount, ids.provided_value, ids.total)) %}
        balance.write(total)

        # Emit the event
        balance_increased.emit(amount)

        return ()
    end
```

When running the test, you will see in the console the following output:
```
0 + 42 + 1 = 43
```

When you learn how the [memory is structured](https://www.cairo-lang.org/docs/how_cairo_works/cairo_intro.html#memory-model), you can do more advanced debugging, like [drawing a grid with ships positions](https://github.com/onlydustxyz/starkonquest/blob/main/contracts/test/grid_helper.cairo).

:heavy_check_mark: usage of hints are very useful for debugging purposes

## Conclusion

| nile                                          | protostar                                                                |
| --------------------------------------------- | ------------------------------------------------------------------------ |
| :x: no extra tool to help unit test debugging | :heavy_check_mark: usage of hints are very useful for debugging purposes |
