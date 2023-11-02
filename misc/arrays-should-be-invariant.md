# Why array/list should not be co-variant nor contra-variant

[Covariance and contravariance (computer science) - Wikipedia](https://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)) This Wikipedia entry does a good job in explaning the relevant concepts.

## Notations

- terms/values: `t, x, y ...` lower case letters.
- type variables: `A, B, C ...` upper case letters. A type is a subset of all terms.
- type assertion: `t: A`. `t` has type `A` or `t` is in the term subset determined by `A`.
- subtype: `A <: B`. `A` is a subtype of `B`. That is `t: A` implies `t: B` for all term `t`.
- Function type: `F(A,B)` where `A` is the parameter type and `B` is the return type.

## Subtype of function types

- covariant in the return type: If `F(A,B) <: F(A',B')` then `B <: B'`.  
  If `f: F(A,B)` implies `f: F(A',B')`, it must be the case that the return value of `f` can be treated as a term of type `B'`, which requires `B <: B'`.
- contravariant in the parameter type: If `F(A,B) <: F(A',B')` then `A' <: A'`.  
  If `f: F(A,B)` implies `f: F(A',B')`, it must be the case that `f` can take an argument of type `A'`, therefore `A' <: A`.

## Inheritance subtyping and member subtyping constraint

In an object oriented programming language, subtyping is usually done by inheritance.
That is: if a  `class B` is derived from `class A`, then `B <: A`. For that to be true, the following constraint will be imposed:
If `class A` has a member `m` of type `T`, then `class B` must also have a member `m` of type `T'` where `T' <: T`.

This is quite intuitive, since `B <: A` requires that an object of type `B` can be treated as an object of type `A`.

## Methods of list type

```haskell
data List a = Nil | Cons a (List a)

head :: List a -> a
head Nil = error "head of an empty list"
head (Cons x _) = x

tail :: List a -> List a
tail Nil = Nil
tail (Cons _ xs) = xs

prepend :: List a -> a -> List a
prepend x xs = Cons x xs
```

We see that 

- In `head` function: `a` appears as the return type.
- In `prepend` function: `a` appears as the parameter type.

## What if list type is co-variant

Suppose that `A <: B` implies `List A <: List B` for all `(A,B)`.

Consider the `prepend` function, we will have `F(List A, F(A, List A)) <: F(List B, F(B, List B))`.
By return type co-variant property, `F(A, List A) <: F(B, List B)`.
By parameter type contra-variant property, `B <: A`.

`B <: A` is not always true, so "`A <: B` implies `List A <: List B`" is not true for all `(A,B)`.

The list type is not co-variant.

## What if list type is contra-variant

Suppose that `A <: B` implies `List B <: List A` for all `A`, `B`.

Consider the `head` function, we will have `F(List B, B) <: F(List A, A)`.
By return type co-variant property, `B <: A`.

`B <: A` is not always true, so "`A <: B` implies `List B <: List A`" is not true for all `(A,B)`.

The list type is not contra-variant.

## Disclaimer

The statement that "if a  `class B` is derived from `class A`, then `B <: A`" is not correct in every practical object-oriented programming language. For example, in C++ private inheritance does not create subtype relation.

The pseudo-code in this note is written in Haskell syntax, however Haskell does not have subtyping polymorphism.
