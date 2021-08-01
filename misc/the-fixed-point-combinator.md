# note on "the fixed-point combinator"

## fixed-point of any operator

Given any operator $f:S\to S$, we want to find its fixed-point
i.e. $x$ such that $f(x) = x$.  
Let $Y:(S\to S)\to S$ where $x_0= Y(f)$ be the fixed-point of $f$
then $x_0 = f(x_0) \iff Y(f) = f(Y(f))$.  

```haskell
fix:: (a -> a) -> a
fix f = f $ Y f
```

Another (non-recursive) definition:

```haskell
-- *NOTE* this is not a valid haskell program
fix:: (a -> a) -> a
fix f = (\x -> f $ x x) (\x -> f $ x x)
```

## construct recursive functions using the Y combinator

### example: constructing the factorial function

Target: the recursive definition

$$
\begin{aligned}
f&:\mathbb{N}\to\mathbb{N}\\
f(n) &=
  \begin{cases}
    1        & n=0\\
    n f(n-1) & n>0
  \end{cases}
\end{aligned}
$$

```haskell
fact n = if n==0
         then 1
         else n*fact (n-1)
```

The "non-recursive" definition

$$
\begin{aligned}
F&:\mathrm{Function}(\mathbb{N}\to \mathbb{N})\to \mathrm{Function}(\mathbb{N}\to \mathbb{N})\\
F(f)
&=n\to
  \begin{cases}
    1        & n=0\\
    n f(n-1) & n>0
  \end{cases}\\
&=f
\end{aligned}
$$

Clearly, $f$ is a fixed-point of $F$, so $f=Y(F)$

```haskell
fact' f n = if n==0
            then 1
            else n*f (n-1)
f = fix fact'
```

**remained problem: the uniqueness of fixed-point**  
What would happen if $F$ has more than one fixed-point?

### the general approach

$$
\begin{aligned}
f(n) &= g(f(i_1(n)),f(i_2(n)),f(i_3(n))\ldots f(i_k(n)))\\
F(f) &= n\to g(f(i_1(n)),f(i_2(n)),f(i_3(n))\ldots f(i_k(n)))\\
     &= f\\
f    &= Y(f)
\end{aligned}
$$

- how to determin whether fixed-point of $F$ is unique?
  - if $F$ has unique fixed-point, will $Y(F)$ converge to that function?
  - if not, what would $Y(F)$ be?
- $f(n)$ might be unevaluable/uncomputable/undefined for some input $n$,  
(examples: $f(n) = f(n)$ or $f(n)=f(n+1)$)  
Do $Y(F)$ have the same properties?

> taking a "theory of computing: language, automata, computability"
> might be solve the above questions.

## reference

- [wikipedia: entry(fixed-point combinator)](https://en.wikipedia.org/wiki/Fixed-point_combinator)
- [wikipedia: entry(fixed-point theorem).section(In algebra and discrete mathematics)](https://en.wikipedia.org/wiki/Fixed-point_theorem)
- [wikipedia: entry(Knaster-Target theorem)](https://en.wikipedia.org/wiki/Knaster-Tarski_theorem)
