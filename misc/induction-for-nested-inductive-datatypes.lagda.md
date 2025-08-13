# induction over nested inductive datatypes with mutual recursion

This note aims to demonstrate why structural induction are insufficient for reasoning about nested data types and briefly introduces the techniques for defining stronger recursive eliminators for nested data types.

The idea behind all this is that _nested data types are actually mutually recursive definitions_.

## Preliminaries

The following definitions are used in this note.

```agda
data Nat : Set where
    zero : Nat
    suc : Nat → Nat

data List (A : Set) : Set where
    [] : List A
    _∷_ : (x : A) (xs : List A) → List A

data All {A : Set} (P : A → Set) : List A → Set where
    [] : All P []
    _∷_ : ∀ {x xs} (hd : P x) (tl : All P xs) → All P (x ∷ xs)
```

## Rose tree its structural induction principle

Consider the following inductively defined type family indexed by `A`.
The data structure is commonly being referred as _rose tree_.

```agda
data Tree (A : Set) : Set where
    tree : (x : A) (subs : List (Tree A)) -> Tree A
```

The structural induction principle for this data type will be:

```agda
ind-elim : (A : Set) (P : Tree A → Set)
         → ((x : A) (subs : List (Tree A)) → P (tree x subs))
         → (t : Tree A)
         → P t
ind-elim A P merge (tree x subs) = merge x subs
```

As we can see, there is no inductive hypothesis to leverage when establishing the induction step. As a result, this induction principle is useless. We cannot even define the height/size function for Rose trees (the inductive hypothesis is the height/size of the sub trees).

## A better induction principle

To overcome the previously mentioned issue, we might be inspired the usual way to define height/size function for multi-way rooted trees and try to prove the following induction principle:

```agda
rec : Set₁
rec = {A : Set} (P : Tree A → Set)
    → (merge : {x : A} {subs : List (Tree A)} → All P subs → P (tree x subs))
    → (t : Tree A)
    → P t
```

## A failed attempt in proving the induction principle

Intuitively, this induction principle is sound and can be justified by the following arguments:

1. There is no Rose tree of zero node.
2. For a Rose tree of a single node `tree x []`, `merge []` has type `P (tree x [])`.
3. Suppose that the induction principle is sound for all Rose tree of no more than $n$ nodes where $n$ is a natural number.
   - Now consider a Rose tree of $n+1$ nodes `tree x (t ∷ ts)`.
   - All sub trees are of no more than $n$ nodes, thus `All P (t ∷ ts)` can be proved.
   - Finally, apply `merge` to construct `P (tree x (t ∷ ts))`.
4. $(\mathbb{N}, \leq)$ is well-founded. By well-founded induction the induction principle is sound for Rose trees of arbitrary size.

However, to define the `size` function, we will need the induction principle. We ended up in a circular dependency.

## Mutual recursion comes to our rescue

It turns out that such an eliminator is definable in Agda, but we have to resort to mutual recursion.
The idea is that `Tree A` can be regarded a mutual recursively defined with `List (Tree A)` together:

- Base case:
  + For every term `x` of type `A`, the term `tree x []` has type `Tree A`.
  + Term `[]` has type `List (Tree A)`.
- Inductive case:
  + If `x` has type `A` and `ts : List (Tree A)`, then `tree x ts` has type `Tree A`.
  + If `t` has type `Tree A` and `ts` has type `List (Tree A)`, then `t ∷ ts` has type `List (Tree A)`.

Induction principle over the mutual recursively defined datatypes will be:

- For every predicate `P` over `Tree A`,
- Base case:
  + For every term `x` of type `A`, the term `tree x []` is in `P`
  + `All P []` (`nil` constructor).
- Inductive case:
  + If `x` has type `A`, `ts` has type `List (Tree A)`, and `ts` is in `All P ts`, then `tree x ts` is in `P`.
  + If `t` has type `Tree A` and `All P ts`, then `All P (t ∷ ts)` (`cons` constructor of `All P`).
- Conclusion:
  + `P` contains all terms of `Tree A`
  + for every `xs` of type `List (Tree A)`, `xs` is in `All P xs`.

Coded in agda:

```agda
rec-tree : {A : Set} (P : Tree A → Set)
         → (∀ {x subs} → All P subs → P (tree x subs))
         → (t : Tree A)
         → P t
rec-forest : {A : Set} (P : Tree A → Set)
           → (∀ {x subs} → All P subs → P (tree x subs))
           → (subs : List (Tree A))
           → All P subs

rec-forest P merge [] = []
rec-forest P merge (t ∷ ts) = (rec-tree P merge t) ∷ (rec-forest P merge ts)

rec-tree P merge (tree x subs) = merge (rec-forest P merge subs)
```

## Examples

Leveraging this induction principle, we can define, for example, the `height` and `size` of Rose trees.

```agda
max : Nat → Nat → Nat
max zero n = n
max (suc m) zero = suc m
max (suc m) (suc n) = suc (max m n)

sum : Nat → Nat → Nat
sum zero n = n
sum (suc m) n = suc (sum m n)

list-max : {A : Set} {xs : List A} → All (λ _ → Nat) xs → Nat
list-max [] = zero
list-max (x ∷ xs) = max x (list-max xs)

list-sum : {A : Set} {xs : List A} → All (λ _ → Nat) xs → Nat
list-sum [] = zero
list-sum (x ∷ xs) = sum x (list-max xs)

height : {A : Set} → Tree A → Nat
height {A} = rec-tree Height (λ t → suc (list-max t))
  where Height = λ _ → Nat

size : {A : Set} → Tree A → Nat
size {A} = rec-tree Size (λ t → suc (list-sum t))
  where Size = λ _ → Nat
```

## See also

Related general concepts of mutual recursively defined datatypes:

- [nlab: inductive-inductive type in nLab](https://ncatlab.org/nlab/show/inductive-inductive+type)
- [nlab: inductive-recursive type in nLab](https://ncatlab.org/nlab/show/inductive-recursive+type)
- [Patricia Johann](https://cs.appstate.edu/johannp/) who have popularized _deep induction_
