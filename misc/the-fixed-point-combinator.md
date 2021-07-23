# note on "the fixed-point combinator"

## fixed-point of any operator

Given any operator $f:S\to S$, we want to find its fixed-point $x$ such that $f(x) = x$.  
Let $Y:(S\to S)\to S$ where $x_0= Y(f)$ is the fixed-point of $f$ i.e. $x_0 = f(x_0) \iff Y(f) = f(Y(f))$.  

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
f&:\mathrm{Function}(\mathbb{N}\to \mathbb{N})\to \mathrm{Function}(\mathbb{N}\to \mathbb{N})\\
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



## reference

- [wikipedia: fixed-point combinator](https://en.wikipedia.org/wiki/Fixed-point_combinator)
