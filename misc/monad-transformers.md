# Note on Monad Transformers

> This is a note on Haskell programming. It does not touch any category theory behind monadic programming.

## Composable computation with monads

Backgrounds: `Functor`, `Applicative`, `Monad` typeclasses in Haskell.

- failable computation: `Maybe` monad
- error handling: `Either` or `Exception` monad
- non-deterministic computation: list `[]` monad
- stateful computation: `State` monad
- side effect: `ST` or `IO` monad

## Simple 

## Reference

- [Monad Transformers Step by Step -- Martin Grabmüller](https://github.com/mgrabmueller/TransformersStepByStep)
