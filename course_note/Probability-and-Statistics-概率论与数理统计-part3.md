# 概率论与数理统计 note. part 3

## MISC

### Poisson approximation

If $X_n\sim \mathrm{Bin}(n,\frac{\lambda}{n})$ then as $n\to \infty$, we have $X_{\infty}\sim \mathrm{Pois}(\lambda)$.  

For $n$ (weakly) independent rare events $A_1,A_2\ldots A_n$ where $\mathbb{E}(I(A_i))=P(A_i)=p_i$ is small,
and $\lambda=\sum_{i} p_i$.
Let $X=\sum_{i}I(A_i)$ approximately, has a Poisson distribution $\mathrm{Pois}(\lambda)$.

### Poisson process and Exponential distribution

- number of arrivals in an interval of length $t$ is a $\mathrm{Pois}(\lambda t)=e^{-\lambda t}\frac{{(\lambda t)}^n}{n!}$.
- time between two arrivals has an Exponential distribution.
- disjoint intervals are independent process.
- sum of Poisson process is a Poisson process.
- $X,Y$ are independent Poisson r.v.s, then $X+Y$ has a Poisson distribution and $X|X+Y=n$ has a Binomial distribution.

### expected value of geometric distribution

$\Pr(X=i) = {(1-p)}^{i-1}p$ for $p=1,2,3\ldots$

#### approach 1

let $q=1-p$

$$
\begin{aligned}
E(X)
&=\sum_{i=1}^\infty i q^{i-1} (1-q)\\
&=\lim_{n\to\infty}\sum_{i=1}^n i q^{i-1} (1-q)\\
&=\lim_{n\to\infty}\sum_{i=1}^n i q^{i-1} - \sum_{i=1}^n i q^i\\
&=\lim_{n\to\infty}\sum_{i=0}^{n-1} (i+1) q^i - \sum_{i=1}^n i q^i\\
&=\lim_{n\to\infty} (0+1) q^0-n q^n +\sum_{i=1}^{n-1}q^i\\
&=1+\frac{q}{1-q} = \frac{1}{1-q} = \frac{1}{p}
\end{aligned}
$$

#### approach 2

$$
\begin{aligned}
E(X)
&=\sum_{i=1}^\infty i\Pr(X=i)\\
&=\lim_{n\to \infty}\sum_{i=1}^n i\Pr(X=i)\\
&=\lim_{n\to \infty}\sum_{i=1}^n \Pr(X=i)\sum_{j=1}^i 1\\
&=\lim_{n\to \infty}\sum_{j=1}^n \sum_{i=j}^n \Pr(X=i)\\
&=\lim_{n\to \infty}\sum_{j=1}^n \Pr(j\leq X\leq n)\\
(?)&=\sum_{j=1}^\infty \Pr(X\geq j)\\
\end{aligned}
$$

$$
\begin{aligned}
\Pr(X\geq i)
&={(1-p)}^{i-1}\\
E(X)
&=\sum_{i=1}^\infty {(1-p)}^{i-1}=\frac{1}{1-(1-p)}=\frac{1}{p}
\end{aligned}
$$

#### extension

Similarly, for positive continuous random variable $X$ and its PDF $f(x)$:

$$
E(X)
=\int_0^{+\infty} xf(x)\mathrm{d}x
=\int_0^{+\infty} \int_0^x 1 f(x)\mathrm{d}y\mathrm{d}x
=\int_0^{+\infty} \Pr(X\geq x)\mathrm{d}x
$$

### conditional independence in Bayesian network

see

- [Zhihu 王乐: 概率图模型之贝叶斯网络](https://zhuanlan.zhihu.com/p/30139208)
- Wikipedia: Bayesian network
- conditional probability chain rule

$$
\begin{aligned}
P(A_1A_2A_3\ldots A_n)
&=P(A_1)P(A_2\ldots A_n |A_1)\\[1em]
&=P(A_1)\ P(A_3\ldots A_n |A_1,A_2)P(A_2 |A_1)\\
&=P(A_1)P(A_2)P(A_3\ldots A_n |A_1,A_2)P(A_2 |A_1)\\[1em]
&=P(A_1)P(A_2|A_1)\ P(A_4\ldots A_n|A_1,A_2,A_3)P(A_3|A_1A_2)\\
&=P(A_1)P(A_2|A_1)P(A_3|A_1A_2)P(A_4\ldots A_n|A_1,A_2,A_3)\\[1em]
&=\ldots\\
&=\prod_{i=1}^n P(A_i|A_1\ldots A_{i-1})
\end{aligned}
$$

#### the structure and data in the network

- DAG, random variable on the vertices, conditional probability on the edges.
- suppose that $A_1,A_2\ldots A_n$ are the ancestors of $B$ in $G=(E,V)$  
  i.e. $\{A_1,A_2\ldots A_n\}=\{v\in V\mid (v,B)\in E\}$  
  then we have a conditional distribution $P(C| A_1\ldots A_n)$  
  $P(C=c_i| A_1=a_1,A_2=a_2\ldots A_n=a_n)$

#### head to head

```plaintext
A -> X
B -> X
C -> X
```

the network(graph) gives $P(X=x| A=a,B=b,C=c)$

#### tail to tail

```plaintext
X -> A
X -> B
X -> C
```

the network(graph) gives $P(A=a| X=x), P(B=b| X=x), P(C=c| X=x)$

#### head to tail

```plaintext
A -> B -> C
```

the network(graph) gives $P(B=b| A=a), P(C=c| B=b)$

### PGF example: first occurrence of a given pattern in coin flip sequence

> Given a sequence $(a_1,a_2\ldots a_n\ldots )$
> where $a_i$ are i.i.d. Bernoulli random variable with parameter $p$, let $q=1-p$.  
>
> Let $X$ be the first time that $111$ is witnessed i.e. $X=k$ iff $(a_{k-2},a_{k-1},a_{k})=(1,1,1)$ and $\forall i<k, (a_{i-2},a_{i-1},a_i)\neq (1,1,1)$.  
>
> Find the moments of $X$.

Let $r_n=P(X=n)$ for all natural number $n$. We have the initial condition $p_0=p_1=p_2=0,p_3=p^3$.  

For every $n>3$.  
Condition on the first step (condition on $a_1$), LOTP:

$$
\begin{aligned}
r_n = P(X=n)
&=P(X=n|a_1=0)P(a_1=0)+P(X=n|a_1=1)P(a_1=1)\\
&=q P(X=n|a_1=0) + pP(X=n|a_1=1)
\end{aligned}
$$

- For $P(X=n|a_1=0)$, since the Bernoulli process is memory less, this is equivalent to $P(X=n-1)=r_{n-1}$
- For $P(X=n|a_1=1)$, we have to consider $a_2$.  
  1. If $a_2=0$, this is another fresh start $P(X=n|a_1=1,a_2=0)=P(X=n-2)$
  2. If $a_2=1$, then $a_3=0$, otherwise we would have $X=3$, $P(X=n|a_1=1,a_2=1)=P(X=n-3)P(a_3=0)$

Thus, by LOTP with extra condition:

$$
\begin{aligned}
&q P(X=n|a_1=0) + p P(X=n|a_1=1)\\
=&q r_{n-1} + p
  \left[
    P(X=n|a_1=1,a_2=0)P(a_2=0|a_1=1)
   +P(X=n|a_1=1,a_2=1)P(a_2=1|a_1=1)
  \right]\\
=&q r_{n-1} + p
  \left[
    P(X=n|a_1=1,a_2=0)q
   +P(X=n|a_1=1,a_2=1)p
  \right]\\
=&q r_{n-1} + p
  \left[
    q P(X=n-2)
   +p P(X=n|a_1=a_2=1,a_3=0) P(a_3=0|a_1=a_2=1)
  \right]\\
=&q r_{n-1} + p
  \left[
    q P(X=n-2)
   +pq P(X=n-3)
  \right]\\
=& q r_{n-1}+pq r_{n-2} + p^2 q r_{n-3}
\end{aligned}
$$

Let $g(z)=\mathbb{E}(z^X)=\sum_{n=0}^\infty r_n z^n$ be the PGF of $X$,

$$
\begin{aligned}
g(z)&=\sum_{n=0}^\infty r_n z^n\\
&=r_0 z^0 + r_1 z^1 + r_2 z^2 + r_3 z^3 + \sum_{n=4}^\infty r_n z^n\\
&=p^3 z^3 + \sum_{n=4}^\infty (q r_{n-1}+pq r_{n-2} + p^2 q r_{n-3}) z^n\\
&=p^3 z^3 + q z \sum_{n=4}^\infty r_{n-1}z^{n-1} + pq z^2 \sum_{n=4}^\infty  r_{n-2} z^{n-2} + p^2q z^3 \sum_{n=4}^\infty r_{n-3}z^{n-3}\\
&=p^3 z^3 + q z \sum_{n=3}^\infty r_{n}z^{n} + pq z^2 \sum_{n=2}^\infty  r_{n} z^{n} + p^2q z^3 \sum_{n=1}^\infty r_{n}z^{n}\\
&=p^3 z^3 + q z g(z) + pq z^2 g(z) + p^2q z^3 g(z)\\
\left( 1-qz-pqz^2-p^2qz^3 \right)g(z)
&=p^3 z^3\\
g(z)
&=\frac{p^3 z^3}{1-qz-pqz^2-p^2qz^3}
\end{aligned}
$$

And $g^{(k)}(1)=\mathbb{E}\left(\prod_{i=0}^{k-1}(X-i)\right)$ use Stirling numbers to convert $x^{\underline k}$ to $x^{k}$,
or use an iterative approach
$\mathbb{E}(X)=g'(1),
\mathbb{E}(X^2)={\left[ \left(z g' \right)' \right]}_{z=1},
\mathbb{E}(X^3)={\left[ \left(z \left( zg' \right)' \right)' \right]}_{z=1},
$.

**Alternative solution:** Markov chain (KMP automata + transition probability graph)

### order statistics of i.i.d continuous random variables

Let $X_1,X_2\ldots X_n$ be $n$ i.i.d. continuous r.v.s whose CDF is $F(x)$.  
In a random experiment, the result is $S=(x_1,x_2\ldots x_n)$, let $X_{(k)}$ be the $k$-th smallest value in $S$.

#### CDF

Then the CDF of $X_{(k)}$ is

$$
F_{X_{(k)}}(x)=P(X_{(k)}\leq x)=\sum_{i=k}^n \binom{n}{i} {(F(x))}^i {(1-F(x))}^{n-i}
$$

For any $x$, consider the random variable $Y=\sum_{i=1}^n \left[ X_i\leq x \right]$,
then $Y\sim\mathrm{Bin}\left(n,F(x)\right)$.  
If $X_{k}\leq x$ then there are at least $k$ variable in $X_1\ldots X_n$ such that $X_i\leq x$,  
therefore $P(X_{k}\leq x)=P(Y\geq k)$.

#### (marginal) PDF

Then, let's find the PDF of $X_{(k)}$, let $f_k(x)$ be the PDF,  
then for a small interval $\delta$, we have$P(x-\delta<X_{(k)}<x+\delta)=2\delta f_{k}(x)$.  

$$
\begin{aligned}
2\delta f_k(x)
&=P(x-\delta<X_{(k)}<x+\delta)\\
\text{(LOTP. Which $X_i$ becomes the $k$-th)}
&=\sum_{i=1}^n P(x-\delta < X_{(k)} < x+\delta | X_{(k)}=X_i)P(X_{(k)}=X_i)\\
\text{(i.i.d. continuous random variable symmetry)}
&=n P(x-\delta < X_{(k)} < x+\delta | X_{(k)}=X_1)P(X_{(k)}=X_1)\\
\text{(i.i.d. continuous random variable symmetry)}
&=P(x-\delta < X_{(k)} < x+\delta | X_{(k)}=X_1)\\
\text{(by definition)}
&=\frac{ P(x-\delta < X_{(k)} < x+\delta ,\ X_{(k)}=X_1) }{P(X_{(k)}=X_1)} \\
\text{($\ast$)}
&=\frac{ 2\delta f_{X_1}(x)\ \binom{n-1}{k-1}{(F(x))}^{k-1}{(1-F(x))}^{n-k} }{1/n} \\
&=n\ 2\delta f(x)\ \binom{n-1}{k-1}{(F(x))}^{k-1}{(1-F(x))}^{n-k}\\
f_{X_{(k)}}(x)
&=nf(x) \binom{n-1}{k-1}{(F(x))}^{k-1}{(1-F(x))}^{n-k}\\
\end{aligned}
$$

Consider the $(\ast)$ step. $P(x-\delta < X_{(k)} < x+\delta ,\ X_{(k)}=X_1)$.
To make that happen, both of the following two properties have to be satisfied.

- Place $X_1$ in the range $(x-\delta,x+\delta)$.  
- For $X_2,X_3\ldots X_n$. Select $(k-1)$ $X_j$s that fall on to the left of $x$, while the other $(n-k)$ $X_j$s fall on to the right of $x$.

Since all $X_j$s are independent, the probability is

$$
2\delta f(x) \ \binom{n-1}{k-1}{(F(x))}^{k-1}{(1-F(x))}^{n-k}
$$

#### (joint) PDF

$$
f_{(X_{(1)},X_{(2)}\ldots, X_{(n)})}(x_1,x_2\ldots x_n)
=n! \prod_{i=1}^n f(x_i)
$$

1. For all permutation of $[n]$ $p_1,p_2\ldots p_n$,
   let $X_{(i)}=X_{p_i}$.  
2. Put $X_{p_i}$ at $(x_i-\delta,x_i+\delta)$

Since $X_1,X_2\ldots X_n$ are independent, the probability of the product event is the product of the probability of each event.

#### identity

$$
\begin{aligned}
P(X_{(k)}<x)
&=F_{X_{(k)}}(x)
=\sum_{i=k}^n \binom{n}{i} {(F(x))}^i {(1-F(x))}^{n-i}\\
&=\int_{\infty}^x f_{X_{(k)}}(t)\mathrm{d}{t}
=\int_{\infty}^x n\binom{n-1}{k-1}f(t){F(t)}^{k-1}{(1-F(t))}^{n-k}\mathrm{d}{t}
\end{aligned}
$$

#### ordered statistics of $\mathrm{Unif}(0,1)$

For $n$ i.i.d. $\mathrm{Unif}(0,1)$ r.v.s. $X_1,X_2\ldots X_n$

$$
\begin{aligned}
P(X_{(k)}<x)
&=\sum_{i=k}^n\binom{n}{i}{(F(x))}^i{(1-F(x))}^{n-i}\\
&=\sum_{i=k}^n\binom{n}{i}x^i {(1-x)}^{n-i}\\
&=\int_{0}^{x}n\binom{n-1}{k-1}f(x) {(F(x))}^{i-1} {(1-F(x))}^{n-i}\mathrm{d}t\\
&=\int_{0}^{x}n\binom{n-1}{k-1} x^{i-1} {(1-x)}^{n-i}\mathrm{d}t\\
\end{aligned}
$$

we have a few more related identities, $\sum_{i=k}^n,\sum_{i=0}^k,\int_0^x,\int_x^1$.

#### two identities

$$
\begin{aligned}
&\forall 0<p<1,\, k\in \mathbb{N}
\qquad
&\sum_{i=0}^k \binom{n}{i}p^i {(1-p)}^{n-i}
=(n-k)\binom{n}{k}\int_p^1 x^k{(1-x)}^{n-k-1}\mathrm{d}x\\
&\forall 0\leq k\leq n,\ k,n\in \mathbb{N}
\qquad
&\int_0^1 \binom{n}{k}x^k{(1-x)}^{n-k}\mathrm{d}x
=\frac{1}{n+1}
\end{aligned}
$$

1. For the first one.  
   Consider the ordered statistics of $n$ i.i.d. $\mathrm{Unif}(0,1)$ r.v.s.  
   This is the probability that $X_{(k+1)}>p$
2. For the second one  
   Consider $n+1$ i.i.d. $\mathrm{Unif}(0,1)$ r.v.s $X_1,X_2\ldots X_n,X_{n+1}$.  
   $P(X_1=X_{(k+1)}| X_1=x)$ is $\binom{n}{k}x^k{(1-x)}^{n-k}$.  
   By LOTP, LHS is $P(X_1=X_{(k+1)})=\frac{1}{n+1}$ i.i.d. continuous r.v.s symmetry property.

### note: abs and min/max

$$
\begin{aligned}
\max(x,y)+\min(x,y)
&=x+y\\
\max(x,y)-\min(x,y)
&=\begin{cases}
x-y & x\geq y\\
y-x & x<y\\
\end{cases}
=|x-y|\\
x+y + |x-y|
&=(\max(x,y)+\min(x,y))+(\max(x,y)-\min(x,y))=\max(x,y)|\\
x+y - |x-y|
&=(\max(x,y)+\min(x,y))-(\max(x,y)-\min(x,y))=\min(x,y)|\\
\end{aligned}
$$

### Beta and Gamma

#### Beta integral and Gamma integral

$$
\begin{aligned}
\beta(a,b)&=\int_0^1 x^{a-1} {(1-x)}^{b-1}\mathrm{d}x & (a,b>0)\\
\Gamma(a) &=\int_0^{+\infty} x^{a-1}e^{-x}\mathrm{d}x=\int_0^{+\infty} x^{a}e^{-x}\frac{\mathrm{d}x}{x} & (a>0)\\
\end{aligned}
$$

Useful properties

- $\beta(a,b) = \frac{\Gamma(a)\Gamma(b)}{\Gamma(a+b)}$
- $\Gamma(a+1)=a\Gamma(a)$
- $\Gamma(1)=1,\Gamma(n)=(n-1)!$

#### Beta distribution and Gamma distribution

- $X\sim \mathrm{Beta}(a,b)$ if the PDF of $X$ is $f(x)=\frac{1}{\beta(a,b)} x^{a-1}{(1-x)}^{b-1}$ for $0<x<1$
- $X\sim \mathrm{Gamma}(a,1)$ if the PDF of $X$ is $f(x)=\frac{1}{\Gamma(a)} x^{a-1}e^{-x}=\frac{1}{\Gamma(a)}x^a e^{-x} \frac{1}{x}$ for $x>0$

if $X\sim \mathrm{Beta}(a,b)$ then, $Y=1-x\sim\mathrm{Beta}(b,a)$

$$
\begin{aligned}
\mathbb{E}(X)
&=\frac{1}{\beta(a,b)}\int_0^1 x\cdot x^{a-1}{(1-x)}^{b-1}\mathrm{d}x
=\frac{1}{\beta(a,b)}\int_0^1 x^{a}{(1-x)}^{b-1}\mathrm{d}x\\
&=\frac{\beta(a+1,b)}{\beta(a,b)}
=\frac{\Gamma(a+1)\Gamma(b)}{\Gamma(a+b+1)}\frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)}
=\frac{\Gamma(a+1)}{\Gamma(a)}\frac{\Gamma(a+b)}{\Gamma(a+b+1)}\\
&=\frac{a}{a+b}\\
f_Y(y)&=f_x(x)\begin{vmatrix} \frac{\mathrm{d}x}{\mathrm{d}y} \end{vmatrix}=f_x(1-y)|-1|\\
&=\frac{1}{\beta(a,b)} {(1-y)}^{a-1} y^b
=\frac{1}{\beta(b,a)} y^b {(1-y)}^{a-1}
\end{aligned}
$$

If $X\sim\mathrm{Gamma}(a,1)$ then $Y=\frac{X}{\lambda}\sim\mathrm{Gamma}(a,\lambda)$

$$
\begin{aligned}
f_Y(y)
&=f_X(x)\frac{\mathrm{d} x}{\mathrm{d} y}
=\frac{1}{\Gamma(a)} {(\lambda y)}^{a-1}e^{-\lambda y}\cdot \lambda
=\frac{1}{\Gamma(a)} {(\lambda y)}^{a} e^{-\lambda y}\frac{1}{y}\\
\mathbb{E}(X)
&=\int_0^{+\infty}\frac{x}{\Gamma(a)}x^{a-1}e^{-x}\mathrm{d}x
=\int_0^{+\infty}\frac{1}{\Gamma(a)}x^{a}e^{-x}\mathrm{d}x
=\frac{\Gamma(a+1)}{\Gamma(a)}
=a\\
\mathbb{E}(X^2)
&=\int_0^{+\infty}\frac{1}{\Gamma(a)}x^{a+1}e^{-x}\mathrm{d}x
=\frac{\Gamma(a+2)}{\Gamma(a)}
=a(a+1)\\
\mathbb{E}(X^k)
&=\int_0^{+\infty}\frac{1}{\Gamma(a)}x^{a+1}e^{-x}\mathrm{d}x
=\frac{\Gamma(a+k)}{\Gamma(a)}
=a^{\overline k}\\
\mathrm{Var}(X)&=\mathbb{E}(X)=a
\end{aligned}
$$

#### Gamma, sum of independent Exponentials, arrival times in Poisson process

- For $n$ i.i.d. $\mathrm{Expo}(\lambda)$ r.v.s. $X_1,X_2\ldots X_n$,
the sum $Y=\sum_{i=1}^n X_i$ have a $\mathrm{Gamma}(n,\lambda)$ distribution.
- In a Poisson process with parameter $\lambda$, the $k$-th arrival time $T_k$ has $\mathrm{Gamma}(k,\lambda)$ distribution.  
  (note: $T_1<T_2\ldots T_n$, are dependent.)

#### Beta-Gamma connection

If $X\sim \mathrm{Gamma}(a,\lambda),Y\sim \mathrm{Gamma}(b,\lambda)$ are independent.  
Let $T=X+Y, W=\frac{X}{X+Y}$, then $T\sim \mathrm{Gamma}(a+b,\lambda),W\sim\mathrm{Beta}(a,b)$ are independent.

$$
\begin{aligned}
(x,y)&=(tw,t(1-w)) \quad (t,w) = (x+y,\frac{x}{x+y})\\
\begin{vmatrix}
\frac{\partial (x,y)}{\partial (t,w)}
\end{vmatrix}
&=\begin{vmatrix}
w   & t\\
1-w &  -t
\end{vmatrix}
=-wt-t(1-w)=-t
\end{aligned}
$$

$$
\begin{aligned}
f_{T,W}(t,w)
&=f_{X,Y}(x,y)
\begin{Vmatrix}
\frac{\partial (x,y)}{\partial (t,w)}
\end{Vmatrix}
=f_{X}(x)f_{Y}(y)
\begin{Vmatrix}
\frac{\partial (x,y)}{\partial (t,w)}
\end{Vmatrix}\\
&=
\frac{1}{\Gamma(a)} {(\lambda x)}^a e^{-\lambda x} \frac{1}{x}
\cdot
\frac{1}{\Gamma(b)} {(\lambda y)}^b e^{-\lambda y} \frac{1}{y}
\cdot t\\
&=
\frac{1}{\Gamma(a)} {(\lambda tw)}^a e^{-\lambda tw} \frac{1}{tw}
\cdot
\frac{1}{\Gamma(b)} {(\lambda t(1-w))}^b e^{-\lambda t(1-w)} \frac{1}{t(1-w)}
\cdot t\\
&=
\frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)} w^{a-1} {(1-w)}^{b-1}
\cdot
\frac{1}{\Gamma(a+b)} {(\lambda t)}^{a+b}e^{-\lambda t} \frac{1}{t}\\
\implies
f_{T,W}(t,w)&=f_T(t)f_W(w)
\quad
\begin{cases}
f_T(t)&=\frac{1}{\Gamma(a+b)} {(\lambda t)}^{a+b}e^{-\lambda t} \frac{1}{t}\\
f_W(w)&=\frac{1}{\beta(a,b)}w^{a-1}{(1-w)}^{b-1}\\
\end{cases}
\end{aligned}
$$

#### Story of Beta and Gamma distribution

- **Beta**: ordered statistics of uniforms  
  $\beta(a+1,b+1)=\int_0^1 x^a{(1-x)}^b\mathrm{d}x=\frac{\Gamma(a+1)\Gamma(b+1)}{\Gamma(a+b+2)}=\frac{a! b!}{(a+b+1)!}$  
  Suppose that $X_1\ldots X_a, Z, Y_1\ldots Y_b$ are i.i.d. $\mathrm{Unif}(0,1)$ r.v.s.  
  The probability that $\max(X_1\ldots X_a) < Z < \min(Y_1\ldots Y_b)$ is $x^a {(1-x)}^b$
- **Beta**: (unknown) success probability of Bernoulli trials  
  In $\mathrm{Beta}(a,b)$, the parameters $a,b$ are called pseudo counts, where $a$ is the number of successful trials and $b$ is the number of failed trails.  
  If $p\sim \mathrm{Beta}(a,b), X|p\sim \mathrm{Bin}(n,p)$ and $X=k$ is observed.  
  The distribution of success probability get updated to $\mathrm{Beta}(a+k,b+(n-k))$
- **Gamma**: waiting time until the $n$-th arrival  
  $\mathrm{Gamma}(1,\lambda)=\mathrm{Expo}(\lambda)$  
  If $X_1\ldots X_n\sim\mathrm{Expo}(\lambda)$ are i.i.d. r.v.s.
  Then $\sum_i X_i\sim\mathrm{Gamma}(n,\lambda)$.
- **Beta**: the fraction of waiting time  
  $X\sim \mathrm{Gamma}(a,\lambda), Y\sim \mathrm{Gamma}(b,\lambda)$, waiting for $a+b$ independent arrivals with rate $\lambda$  
  Then $\frac{X}{X+Y}\sim\mathrm{Beta}(a,b)$
- **Gamma**: (unknown) rate of Poisson process  
  $\lambda \sim \mathrm{Gamma}(r,b)$ is the prior distribution of the arrival rate $\lambda$  
  Then $X|\lambda \sim\mathrm{Pois}(\lambda t)$, the number of arrivals in $[0,t]$ for a Poisson process with parameter $\lambda$.  
  If $X=n$ is observed, the posterior distribution of $\lambda$ is updated to $\mathrm{Gamma}(r+n,b+t)$  
  $r$ is the number of arrivals, $b$ is the total waiting time. The average rate is $\mathbb{E}(\lambda)=\left(\frac{r}{b}\to \frac{r+n}{b+t}\right)$

### Conjugacy

reference: [Wikipedia: conjugacy prior](https://en.wikipedia.org/wiki/Conjugate_prior)

#### Beta-Binomial

If $p$ have a $\mathrm{Beta}(a,b)$ prior distribution, and $X|p=\mathrm{Bin}(n,p)$.  
If $X=k$ is observed, the posterior distribution of $p$, $p|X=k$ is $\mathrm{Beta}(a+k,b+n-k)$  
The positive real number $a,b$ are called _pseudo count_.  

The prior distribution can be history records, uniform, or arbitrarily picked things.

$$
\begin{aligned}
f_{p|X=k}(t,k)
&=\frac{P(X=k|p=t)f_p(t)}{P(X=k)}\\
&=\frac{
\binom{n}{k} t^k {(1-t)}^{n-k}
\,
\frac{1}{\beta(a,b)} t^{a-1}{(1-t)}^{b-1}
}{P(X=k)}\\
&=\frac{\binom{n}{k}}{\beta(a,b) P(X=k)} t^{a+k-1} {(1-t)}^{b+n-k-1}
\end{aligned}
$$

The conditional PDF is also a valid PDF which integrates to $1$, thus $\frac{\binom{n}{k}}{\beta(a,b) P(X=k)}=\beta(a+k,b+n-k)$.
The posterior distribution is $\mathrm{Beta}(a+k,b+n-k)$

note: if a $\mathrm{Unif}(0,1)$ prior, we can use $\mathrm{Beta}(1,1)$.

#### Dirichlet-Multinomial

An extension of the Beta-Binomial conjugacy.

- prior distribution: $\mathrm{Dirichlet}(a_1,a_2\ldots a_k)$  
  $f(p_1,p_2\ldots p_k)=\frac{\Gamma\left(\sum_i a_i\right)}{\prod_i \Gamma(a_i)}\prod_i p_i^{a_i}$
- observation: $(X_1,X_2\ldots X_k)|(p_1,p_2\ldots p_k) \sim \mathrm{Multi}(n,(p_1,p_2\ldots p_k))$  
  $P(X_1=n_1\ldots X_k=n_k)=\frac{n!}{\prod_i n_i!} p_i^{x_i}$ where $\sum_i n_i=n$
- prior distribution: $\mathrm{Dirichlet}(a_1+X_1,a_2+X_2\ldots a_k+X_k)$  
  $f(\vec p|\vec X)$

#### Gamma-Poisson

- The prior distribution of $\lambda$ is $\mathrm{Gamma}(r,b)$  
- Observation $X|\lambda\sim \mathrm{Pois}(\lambda t)$. The number of arrivals in a Poisson process with parameter $\lambda$ in $[0,t]$ time.
- The posterior distribution $\lambda|X \sim \mathrm{Gamma}(r+n,b+t)$

$$
\begin{aligned}
f_{\lambda|X}(\lambda|X=n)
&=\frac{P(X=n|\lambda)f(\lambda)}{P(X=n)}\\
&=\frac{
e^{-\lambda t}\frac{{(\lambda t)}^n}{n!}
\cdot
\frac{1}{\Gamma(r)} {(b\lambda)}^{r} e^{-b\lambda}\frac{1}{\lambda}
}{P(X=n)}\\
&=\frac{\Gamma(r+n) b^r}{\Gamma(r)n!P(X=n) {(b+t)}^{r+n}}
\cdot
\frac{1}{\Gamma(r+n)} {((b+t)\lambda)}^{r+n} e^{-(b+t)\lambda} \frac{1}{\lambda}\\
&\propto
\frac{1}{\Gamma(r+n)} {((b+t)\lambda)}^{r+n} e^{-(b+t)\lambda} \frac{1}{\lambda}
\end{aligned}
$$

Other factors are independent of $\lambda$, so they can be viewed as normalizing constants.  
Thus, the PDF is

$$
f_{\lambda|X}(\lambda|X=n)
=\frac{1}{\Gamma(r+n)} {((b+t)\lambda)}^{r+n} e^{-(b+t)\lambda} \frac{1}{\lambda}
$$

Which is $\mathrm{Gamma}(n+r,b+t)$

$$
\frac{r}{b}
\to
\frac{r+n}{b+t}
$$

### Conditioning on the first-step, memoryless

TODO: examples

### estimator comparison: MAP, MLE, and the Bayesian Mean

- MAP: Bayesian statistical inference. Maximize the posterior probability
- MLE: Classical statistical inference. Maximize the likelihood function.
- Bayesian Mean: Bayesian statistical inference. Conditional Expectation.

### The accept-reject sampling method

Suppose that we can generate random samples from PDF $g$,
we want to generate samples from PDF $f$.

Let $c\geq \sup_x \frac{f(x)}{g(x)}$.  
We generate a random sample $Y$ from $g$.
We accept $Y$ with probability $\frac{f(Y)}{c g(Y)}$,

```python
def generate(f_pdf,g_pdf,c,draw_from_g):
  while True:
    y = draw_from_g()
    if uniform_sample(0,1) <= f(y)/(c*g(y)):
      return y
```

The generated sample has a $g_{y|\mathrm{Accepted}}(y)$ distribution.

$$
\begin{aligned}
g_{Y|\mathrm{Accepted}}(y)
&=\frac{ P(\mathrm{Accepted}|Y=y)g(y) }{ P(\mathrm{Accepted}) }\\
&=\frac{\frac{f(y)}{cg(y)}\, g(y)}{\int_{t\in Y}P(\mathrm{Accepted}|Y=t)g(t)\, \mathrm{d}t}\\
&=\frac{f(y)/c}{\int_{y\in Y}\frac{f(t)}{cg(t)}g(t)\, \mathrm{d}t}=\frac{f(y)/c}{\int_{y\in Y}f(t)/c\, \mathrm{d}t}\\
&=f(y)
\end{aligned}
$$
