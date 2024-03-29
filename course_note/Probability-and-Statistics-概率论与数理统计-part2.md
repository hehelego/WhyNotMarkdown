# 概率论与数理统计 note. part 2

## ch7 Joint Distribution

## ch8 Transformations

### PDF transformation in variable substitution (with good smooth, bijective, differentiable properties)

For two continuous random variables $X,Y$ such that $X=g(Y)$.  
Let $F_X(x)=P(X<x),F_Y(y)=P(Y<y)$ be the CDFs of $X,Y$ respectively
and $f_X(x)=\lim_{\delta\to 0}\frac{P(|X-x|<\delta)}{2\delta}=\lim_{\delta\to 0}\frac{F_X(x+\delta)-F_X(x-\delta)}{2\delta}=F_X'(x),f_Y(y)=F_Y'(y)$ be the PDFs.

Consider the probability that $X$ falls in $I_X=(x,x+\delta_X)$ and the corresponding interval $I_Y=(y,y+\delta_Y)$,  
where $\delta_Y=g'(x)\delta_X$ or $\mathrm{d}y=g'(x)\mathrm{d}x$

$$
\begin{aligned}
P(X\in I_X) &= P(Y\in I_Y) \\
f_X(x)|\mathrm{d}x| &= f_Y(y)|\mathrm{d}y| \\
f_Y(y) &= f_X(x) \left|\frac{\mathrm{d}x}{\mathrm{d}y}\right|
\end{aligned}
$$

For multi-variate case, $\vec y = \vec{g}(\vec x)$, similarly, consider the probability that $X$ falls in some region $D_x$ it is identical to the probability that $Y$ falls in the transformed region $D_y$.  
We have $\mathrm{d}x_1\mathrm{d}x_2\ldots \mathrm{d}x_n=\left|\frac{\partial (y_1,y_2\ldots y_n)}{\partial (x_1,x_2\ldots x_n)}\right|\mathrm{d}y_1\mathrm{d}y_2\ldots \mathrm{d}y_n$

$$
\begin{aligned}
P(X\in D_X) &= P(Y\in D_Y)\\
f_X(\vec x)\sigma_X&= f_Y(\vec y)\sigma_Y\\
f_X(\vec x)\mathrm{d}x_1\mathrm{d}x_2\ldots\mathrm{d}x_n &= f_Y(\vec y)\mathrm{d}y_1\mathrm{d}y_2\ldots \mathrm{d}y_n\\
f_Y(\vec y) &= f_X(\vec x)\left|\frac{\partial (x_1,x_2\ldots x_n)}{\partial (y_1,y_2\ldots y_n)}\right|
\end{aligned}
$$

**NOTE:** make use of "chain-rules" (the Jacobian of composed function is the product of Jacobian) and "inverse transformation" (Jacobian of inverse is the inverse of the Jacobian).

### Uncorrelated can not imply independent

Let $X\sim \mathcal{N}(0,1)$ be a standard normal random variable,  
$Y=X^2$.

$$
\mathrm{Cov}(X,Y)=\mathbb{E}(XY)-\mathbb{E}(X)\mathbb{E}(Y)
=\mathbb{E}(X^3)-\mathbb{E}(X)\mathbb{E}(X^2)
=0^3-0\mathbb{E}(X^2)
=0
$$

**Special case:** For normal r.v.s, uncorrelated is equivalent to independent.

### Covariance, Correlation examples

> Let $X,Y\sim\mathrm{Expo}(1)$ be two i.i.d. r.v.s.  
> Find the correlation between $M=\max(X,Y)$ and $L=\min(X,Y)$.

Consider two independent arrivals with rate $\lambda=1$,  
the first arrival time has a $\mathrm{Expo}(1+1)$ distribution
and the next arrival, by memoryless property, has a $\mathrm{Expo}(1)$ distribution and its is independent of the first arrival.

(The Poisson clock model/story)

We have $L\sim \mathrm{Expo}(2),M-L\sim\mathrm{Expo}(1)$ and $L,M-L$ is independent.

$$
\begin{aligned}
\mathrm{Cov}(L,M)
&
=\mathrm{Cov}(L,M-L+L)
=\mathrm{Cov}(L,M-L)+\mathrm{Cov}(L,L)\\
&
=0+\mathrm{Var}(L)=\frac{1}{2^2}=\frac{1}{4}\\
\mathrm{Cov}(M,M)
&
=\mathrm{Cov}(M-L+L,M-L+L)\\
&
=\mathrm{Cov}(M-L,M-L)+\mathrm{Cov}(L,L)+2\mathrm{Cov}(M-L,L)\\
&
=\frac{1}{1^2}+\frac{1}{2^2}+0
=\frac{5}{4}
\end{aligned}
$$

Thus

$$
\mathrm{Corr}(L,M)
=\frac{\mathrm{Cov}(L,M)}
{\sqrt{\mathrm{Cov}(L,L)\mathrm{Cov}(M,M)}}
=\frac{1/4}{\sqrt{\frac{1}{4}\cdot \frac{5}{4}}}
=\frac{1}{\sqrt 5}=\frac{\sqrt 5}{5}
$$

### Hyper-Geometric distribution variance

> $X\sim\mathrm{HGeom}(w,b,n)$.  
> We have $w$ white balls and $b$ black balls in a bag,  
> draw $n$ balls from that bag, let $X$ be the number of white balls.

Let $A_i$ be the event that the $i$-th drawn ball is white, and $I_i$ be the corresponding indicator  
We have $I_i\sim \mathrm{Bern}\left(\frac{w}{w+b}\right)=\mathrm{Bern}(p)$, let $q=1-p=\frac{b}{w+b}$

$$
\begin{aligned}
\mathrm{Var}(X)
&=\mathrm{Var}\left( \sum_{i=1}^n I_i \right)
=\sum_{i=1}^n\sum_{j=1}^n \mathrm{Cov}(I_i,I_j)\\
&=\sum_{i=1}^n \mathrm{Var}(I_i)+2\sum_{i<j}\mathrm{Cov}(I_i,I_j)\\
\text{(Symmetry)}
&=n\mathrm{Var}(I_1)+2\binom{n}{2}\mathrm{Cov}(I_1,I_2)\\
\mathrm{Var}(I_i)
&=pq=\frac{w}{w+b}\frac{b}{w+b}\\
\mathrm{Cov}(I_1,I_2)
&=\mathbb{E}(I_1 I_2)-\mathbb{E}(I_1)\mathbb{E}(I_2)\\
&=\mathbb{P}(A_1\cap A_2)-\mathbb{P}(A_1)\mathbb{P}(A_2)\\
&=\frac{w}{w+b}\frac{w-1}{w+b-1}-p^2\\
\end{aligned}
$$

### multi-variate normal: MVN

A random vector $\vec X=(X_1,X_2\ldots X_n)$ is said to be a MVN,
iff $\mathrm{span}(X_1,X_2\ldots X_n)$, all the linear combination of the components, all have normal distribution (a constant value $c$ is viewed as $\mathcal{N}(c,0)$)

#### examples

- $X\sim \mathcal{N}(0,1), Y=SX, P(S=1)=P(S=-1)=\frac{1}{2}$.  
  The marginal distribution of $X$ and $Y$ are both $\mathcal{N}(0,1)$,  
  but $(X,Y)$ is not a MVN since $P(X+Y=0)=P(S=-1)=\frac{1}{2}$.
- $X,Y\sim \mathcal{N}(0,1), Z=X+Y$ then $(X,Y,Z)$ is a MVN, although $Z$ is not independent of $(X,Y)$

#### BVN generating

Generate a BVN $(U,V)$ from two independent $\mathcal{N}(0,1)$ r.v.s $X,Y$, where $U,V\sim \mathcal{N}(0,1)$ and $\mathrm{Cov}(U,V)=\rho$

Suppose that $U=aX+bY,V=cX+dY$

$$
\begin{cases}
\mathbb{E}(U)=\mathrm{E}(V)=a+b=c+d=1\\
\mathrm{Var}(U)=\mathrm{Var}(V)=a^2+b^2=c^2+d^2=1\\
\mathrm{Cov}(U,V)=\mathrm{Cov}(aX+bY,cX+dY)
=ac\mathrm{Var}(X)+bd\mathrm{Var}(Y)+0+0
=ac+bd
=\rho
\end{cases}
$$

Then a solution can be:

$$
\begin{cases}
a=1\\
b=0\\
c=\rho\\
d=\sqrt{1-\rho^2}
\end{cases}
$$

#### BVN MGF

Let $(X,Y)$ be a BVN, where the marginal distribution is
$X\sim\mathcal{N}(\mu_x,\sigma_x^2)$,$Y\sim\mathcal{N}(\mu_y,\sigma_y^2)$
and $\mathrm{Corr}(X,Y)=\rho$.  
Then $Z=t_x X + t_y Y$ is a normal random variable $Z\sim\mathcal{N}(\mu,\sigma^2)$.

$$
\begin{aligned}
\mu
&=\mathbb{E}(Z)=t_x \mathbb{E}(x)+t_y \mathbb{E}(y) = t_x\mu_x+t_y\mu_y\\
\sigma^2
&=\mathrm{Var}(Z)=\mathrm{Cov}(t_x X+ t_y Y,t_x X+ t_y Y)
=t_x^2 \sigma_x^2 +t_y^2 \sigma_y^2+2t_xt_y\mathrm{Cov}(X,Y)\\
M_{X,Y}(t_x,t_y)
&=\mathbb{E}(e^{t_x X+ t_y Y})=\mathbb{E}(e^Z)
=\exp\left(
\mu + \frac{1}{2}\sigma^2
\right)\\
&=\exp\left(
\mu_x t_x + \mu_y t_y
+\frac{1}{2}
\left(
\sigma_x^2 t_x^2 + \sigma_y^2 t_y^2
+2\sigma_x t_x \sigma_y t_y \rho
\right)
\right)\\
\end{aligned}
$$

The marginal MGF of $X,Y$ are

$$
\begin{aligned}
M_X(t_x)
&=\exp\left( \mu_x t_x  + \frac{1}{2}\sigma_x^2 t_x^2 \right)\\
M_Y(t_y)
&=\exp\left( \mu_y t_y  + \frac{1}{2}\sigma_y^2 t_y^2 \right)\\
M_X(t_x)M_Y(t_y)
&=\exp\left( \mu_x t_x+\mu_y t_y  + \frac{1}{2}(\sigma_x^2 t_x^2 + \sigma_y^2 t_y^2) \right)\\
\end{aligned}
$$

We can find out that

$$
\mathrm{Corr}(X,Y)=\rho=\frac{\mathrm{Cov}(X,Y)}{\sigma_x \sigma_y}=0
\iff
M_{X,Y}(t_x,t_y) = M_{X}(t_x) M_{Y}(t_y)
$$

**NOTE:** The joint/marginal MGF determines the joint/marginal distribution.

The product of marginal MGFs is equal to the joint MGF,  
if and only if.  
The product of marginal PDFs is equal to the joint PDF.

This is a significant result: In MVN, uncorrelated is equivalent to independent.  
(Generally speaking, uncorrelated is weaker than independent).

### Normal Samples: sample mean and sample variance are independent

$X_1,X_2\ldots X_n\sim \mathcal{N}(\mu,\sigma^2)$ are $n$ i.i.d. r.v.s.  
Therefore, $\bar{X}=\frac{1}{n}\sum_{i=1}^n X_i$ is a $\mathcal{N}\left(\mu, \frac{\sigma^2}{n}\right)$ random variable.

Consider $\vec{X}=(\bar X,X_1-\bar X,X_2-\bar X\ldots X_n-\bar X)$ is a linear combination of $(X_1,X_2\ldots X_n)$, which is a MVN.
Thus, $\vec{X}$ is a MVN.  
Consider the covariance between $\bar X$ and $X_i-\bar X$.

$$
\begin{aligned}
\mathrm{Cov}(\bar X,X_k-\bar X)
&=\mathrm{Cov}(\bar X,X_k)-\mathrm{Cov}(\bar X,\bar X)\\
&=\frac{1}{n}\mathrm{Cov}\left(\sum_{i=1}^n X_i, X_k\right) - \frac{\sigma^2}{n}\\
&=-\frac{\sigma^2}{n}+\frac{1}{n}\sum_{i=1}^n \mathrm{Cov}(X_i,X_k)\\
&=-\frac{\sigma^2}{n}+\frac{1}{n}\sum_{i=1}^n [i=k]\sigma^2\\
&=-\frac{\sigma^2}{n}+\frac{\sigma^2}{n}=0
\end{aligned}
$$

In MVN, uncorrelated components are independent.  
So $\bar X$ is independent of $X_i-\bar{X}$ for all $1\leq i\leq n$.  
(sample mean, distance from mean are independent)

Considering that $S_n=\frac{1}{n-1}\sum_{i=1}^n {(X_i-\bar X)}^2$, is a function of $(X_1-\bar X,X_2-\bar X,\ldots X_n-\bar X)$,  
which are independent of $\bar{X}$,
we can conclude that $S_n$ is independent of $\bar{X}$.

That is: for i.i.d. samples of a normal distribution, the mean and the sample variance are independent.

See also:

- Chi-Square distribution (for Normal sample variance distribution)
- Fisher's F-distribution
- William Gosset's t-distribution

### Generating normal r.v.s, the Box-Muller method

Let $U\sim \mathrm{Unif}(0,2\pi), T\sim \mathrm{Expo}(1)$ be independent r.v.s

$$
\begin{cases}
X=\sqrt{2 T}\cos U\\
Y=\sqrt{2 T}\sin U\\
\end{cases}
$$

Then $X,Y$ are i.i.d. $\mathcal{N}(0,1)$ r.v.s

$$
\begin{aligned}
\begin{vmatrix} \frac{\partial (x,y)}{\partial (u,t)} \end{vmatrix}
&=\begin{vmatrix}
-\sqrt{2t}\sin u  &  \frac{\cos u}{\sqrt{2t}} \\
 \sqrt{2t}\cos u  &  \frac{\sin u}{\sqrt{2t}} \\
\end{vmatrix}=-1\\
f_{X,Y}(x,y)
&=f_{U,T}(u,t) \begin{Vmatrix} \frac{\partial (u,t)}{\partial (x,y)} \end{Vmatrix}
=f_{U}(u)f_{T}(t) \begin{Vmatrix} \frac{\partial (u,t)}{\partial (x,y)} \end{Vmatrix}\\
&=\frac{1}{2\pi} \exp{\left(-\frac{x^2+y^2}{2}\right)}\frac{1}{|-1|}\\
&=\frac{1}{\sqrt{2\pi}} e^{-\frac{1}{2}x^2}\cdot \frac{1}{\sqrt{2\pi}} e^{-\frac{1}{2}y^2}\\
\implies f_{X,Y}(x,y)&=f_X(x)f_Y(y)
\quad
\begin{cases}
f_X(x) = \frac{1}{\sqrt{2\pi}} e^{-\frac{1}{2}x^2}\\
f_Y(y) = \frac{1}{\sqrt{2\pi}} e^{-\frac{1}{2}y^2}
\end{cases}
\end{aligned}
$$

## ch9 Conditional Expectation

### example: conditional expectation inequality (average life span)

$$
\mathbb{E}(X|X\geq t)\geq \mathbb{E}(X)
$$

$$
\begin{aligned}
\mathbb{E}(X)
&=\mathbb{E}(X|X\geq t)P(X\geq t)+\mathbb{E}(X|X<t)P(X<t)\\
&=\mathbb{E}(X|X\geq t) - \mathbb{E}(X|X\geq t)P(X<t)+\mathbb{E}(X|X<t)P(X<t)\\
&=\mathbb{E}(X|X\geq t) + \left( \mathbb{E}(X|X<t)-\mathbb{E}(X|X\geq t) \right) P(X<t)\\
&\leq \mathbb{E}(X|X\geq t) + \left( t-t \right) P(X<t)\\
&=\mathbb{E}(X|X\geq t)
\end{aligned}
$$

### Adam and Eve (iterated conditional expectation, conditional variance)

$$
\begin{aligned}
\mathbb{E}\left(
\mathbb{E}\left(X|Y\right)
\right)
&=\mathbb{E}(X)\\
\mathbb{E}\left(
\mathbb{E}(X|Y,Z)
|Z
\right)
&=\mathbb{E}(X|Z)\\
\operatorname{Var}(X)
&=\mathbb{E}\left( \operatorname{Var}(X|Y)) \right)
+\operatorname{Var}\left( \mathbb{E}(X|Y)) \right)
\end{aligned}
$$

#### proof: conditional expectation

For the iterated conditional expectation.  
This is a direct implication of the law of total expectation  
and can be interpreted as:  
**The expectation is the weighted average of the means within each group**.

$$
\begin{aligned}
\mathbb{E}\left(
\mathbb{E}(X|Y)
\right)
&=\sum_{y}\mathbb{E}(X|Y=y)P(Y=y)=\mathbb{E}(X)\\
\end{aligned}
$$

Let $\hat{\mathbb{E}}(\cdot)=\mathbb{E}(\cdot | Z)$, we have
$\mathbb{\hat E}\left(\mathbb{\hat E}\left(X|Y\right)\right)=\hat{\mathbb{E}}(X)$
which is an extended version of the iterated conditional expectation

$$
\mathbb{E}\left[
\mathbb{E} \left( X\mid Y \right)
\mid Z
\right]
=\mathbb{E}\left[ X|Z \right]
$$

#### proof: conditional variance

For the conditional variance law.  
This can be proved using the iterated conditional expectation property.

Can be interpreted as **the total variance is the sum of variance between groups and the expectation of variance within a group**

$$
\begin{aligned}
\mathbb{E}\left( \operatorname{Var}(Y|X) \right)
&=\mathbb{E}\left(
  \mathbb{E}(Y^2|X)-{\left( \mathbb{E}(Y|X) \right)}^2
\right)
=\mathbb{E}(Y^2)
-\mathbb{E}\left(
  {\left( \mathbb{E}(Y|X) \right)}^2
\right)\\
\operatorname{Var}\left(\mathbb{E}\left(X|Y\right)\right)
&=\mathbb{E}\left(
{\left( \mathbb{E}(X|Y) \right)}^2
\right)
-{\left( \mathbb{E}
\left( \mathbb{E}\left(X|Y\right) \right)
\right)}^2
=\mathbb{E}\left(
  {\left( \mathbb{E}(Y|X) \right)}^2
\right)
-{\left( \mathbb{E}(Y) \right)}^2\\
\operatorname{Var}(Y)
&=\mathbb{E}\left( \operatorname{Var}(Y|X) \right)
+\operatorname{Var} \left( \mathbb{E}(Y|X) \right)
\end{aligned}
$$

#### examples: random sum

> We have some random variables $X_1\ldots X_N$  
> When the random positive integer $N$ is given. We have $X_1,X_2\ldots X_N$ are i.i.d. with $\mathbb{E}(X_i)=\mu,\operatorname{Var}(X_i)=\sigma^2$  
> Find the mean and variance of $X=\sum_{i=1}^N X_i$

$$
\begin{aligned}
\mathbb{E}(X)
&=\mathbb{E}\left(
\mathbb{E}( X|N )
\right)
=\mathbb{E}\left(
\mathbb{E}\left( \sum_{i=1}^N X_i |N \right)
\right)
&(\text{condition on $N$})\\
&=\mathbb{E}\left(
\sum_{i=1}^N \mathbb{E}\left( X_i |N \right)
\right)
=\mathbb{E}\left( N\mu \right)=\mu \mathbb{E}\left( N\right)
&(\text{linearity})\\
\mathbb{Var}(X)
&=\mathbb{E}
\left( \operatorname{Var}(X|N) \right)
+\operatorname{Var}\left(
\mathbb{E}(X|N)
\right)
&(\text{conditional variance law})\\
&=\mathbb{E}
\left( \operatorname{Var}\left(\sum_{i=1}^N X_i|N\right) \right)
+\operatorname{Var}\left( \mu N \right)
&\text{()}\\
&=\mathbb{E}
\left( \sum_{i=1}^N \operatorname{Var}\left(X_i|N\right) \right)
+\mu^2 \operatorname{Var}(N)
&\text{(variance of sum of i.i.d. s)}\\
&=\mathbb{E}\left( N\sigma^2 \right) +\mu^2 \operatorname{Var}(N)
=\sigma^2 \mathbb{E}\left( N\right) +\mu^2 \operatorname{Var}(N)
&\text{()}\\
\end{aligned}
$$

### first-step method with examples

#### Expectation of $\mathrm{Geom}(p)$

Let $X\sim \mathrm{Geom}(p)$.
Consider a Bernoulli process, $X$ is the failures before the first success.  
Let $I$ be the indicator of the event that the first trial succeeded.

LOTE:

$$
\begin{aligned}
\mathbb{E}(X)
&=\mathbb{E}\left( \mathbb{E}(X|I) \right) & \text{(LOTE)}\\
&=\mathbb{E}(X|I=0)\Pr(I=0)+\mathbb{E}(X|I=1)\Pr(I=1)\\
&=q\mathbb{E}(X|I=0)+p\mathbb{E}(X|I=1)\\
&=q\left( 1+\mathbb{E}(X) \right) +p\cdot 0 &\text{(memoryless, fresh start)}\\
\implies \mathbb{E}(X) &= \frac{q}{p}
\end{aligned}
$$

For $Y\sim \mathrm{FS}(p)$, we have $\mathbb{E}(Y)=p\cdot 1 + q \left( 1+\mathbb{E}(Y) \right), \mathbb{E}(Y)=\frac{1}{p}$

#### Coin tosses sequence pattern matching

> We flip a coin multiple times.
>
> - What is the expected number of tosses needed until $\mathrm{HT}$
> - What is the expected number of tosses needed until $\mathrm{HH}$
> - What is the expected number of tosses needed until $\mathrm{HTT}$
> - What is the expected number of tosses needed until one of $\mathrm{HTT},\mathrm{TTTHHT},\mathrm{HHTTHH}$
> - What is the expected number of tosses needed until all of $\mathrm{HTT},\mathrm{TTTHHT},\mathrm{HHTTHH}$
>
> keywords:
>
> - DFA, KMP, Aho-Corasick
> - PGF probability generating function
> - random walk on graph
> - Markov Chain**, **Martingale

We will tackle the first three with the help of _Conditional Expectation_ and _Memoryless property of Bernoulli Process_.

For $T_{HT}$, this can be viewed as: Try until we see a $\mathrm{H}$, $T_1$ trials. Continue Trying until we see a $\mathrm{T}$, $T_2$ trials.  
Memoryless property of Bernoulli process, $T_1,T_2\sim \mathrm{FS}(1/2)$ so $\mathbb{E}(T_{HT})=\mathbb{E}(T_1)+\mathbb{E}(T_2)=2+2=4$.

Let's use first-step analysis to find the expectation.  
Let $p$ be the probability of $H$ and $q$ be the probability of $T$.

- For $\mathrm{HH}$: condition on the first toss $O_1$.
  $$
  \begin{aligned}
  \mathbb{E}(T_{HH})
  &= \mathbb{E}(T_{HH}|O_1=H)\Pr(O_1=H) + \mathbb{E}(T_{HH}|O_1=T)\Pr(O_1=T)\\
  &= p\mathbb{E}(T_{HH}|O_1=H) + q\left( 1 + \mathbb{E}(T_{HH}) \right)\\
  \mathbb{E}(T_{HH}|O_1=H)
  &=\mathbb{E}(T_{HH}|O_2=H,O_1=H)\Pr(O_2=H|O_1=H)\\
  &+\mathbb{E}(T_{HH}|O_2=T,O_1=H)\Pr(O_2=T|O_1=H)\\
  &=p\mathbb{E}(T_{HH}|O_2=H,O_1=H)+q\mathbb{E}(T_{HH}|O_2=T,O_1=H)\\
  &=p\cdot 2+q\left( 2+\mathbb{E}(T_{HH}) \right)=2+q\mathbb{E}(T_{HH})\\
  \mathbb{E}(T_{HH})
  &= p\mathbb{E}(T_{HH}|O_1=H) + q\left( 1+\mathbb{E}(T_{HH}) \right)\\
  &= p\left( 2+ q\mathbb{E}(T_{HH}) \right) +  q\left( 1+\mathbb{E}(T_{HH}) \right)\\
  \implies \mathbb{E}(T_{HH}) = \frac{1+p}{p^2}
  \end{aligned}
  $$
- For $\mathbb{E}(T_{HT})$
  $$
  \begin{aligned}
  \mathbb{E}(T_{HT})
  &= \mathbb{E}(T_{HT}|O_1=H)\Pr(O_1=H)+\mathbb{E}(T_{HT}|O_1=T)\Pr(O_1=T)\\
  &= p\mathbb{E}(T_{HT}|O_1=H)+q\left( 1+\mathbb{E}(T_{HT}) \right)\\
  \mathbb{E}(T_{HT}|O_1=H)
  &= \mathbb{E}(T_{HT}|O_2=T,O_1=H)\Pr(O_2=T|O_1=H)\\
  &+ \mathbb{E}(T_{HT}|O_2=H,O_1=H)\Pr(O_2=H|O_1=H)\\
  &= 2\cdot q+ p\left( 2+\mathbb{E}(T_{HT}|O_1=H)-1 \right)\\
  \implies \mathbb{E}(T_{HT}|O_1=H) &= 1+\frac{1}{q}\\
  \mathbb{E}(T_{HT})
  &= p\mathbb{E}(T_{HT}|O_1=H)+q\left( 1+\mathbb{E}(T_{HT}) \right)\\
  &= p\left( 1+\frac{1}{q} \right) +q\left( 1+\mathbb{E}(T_{HT}) \right)\\
  \implies \mathbb{E}(T_{HT})=\frac{1}{p} + \frac{1}{q} = \frac{1}{pq}
  \end{aligned}
  $$

### projection interpretation of conditional expectation

$Y-\mathbb{E}(Y|X)$ and $h(X)$ are uncorrelated.

$$
\begin{aligned}
\operatorname{Cov}(h(X),Y-\mathbb{E}(Y|X))
&=\mathbb{E} \left( h(X)(Y-\mathbb{E}(Y|X)) \right)
-\mathbb{E}(h(X))\mathbb{E}\left( Y-\mathbb{E}(Y|X) \right)\\
&=\mathbb{E} \left( h(X)(Y-\mathbb{E}(Y|X)) \right) -\mathbb{E}(h(X))0\\
\mathbb{E}\left[ h(X)E(Y|X) \right]&=\mathbb{E} \left( h(X)(Y-\mathbb{E}(Y|X)) \right)\\
&=\mathbb{E}\left[ h(X)Y \right] -\mathbb{E}\left[h(X)\mathbb{E}(Y|X)\right]\\
&=\mathbb{E}\left[ h(X)Y \right] -\mathbb{E}\left[\mathbb{E}(h(X)Y|X)\right]\\
&=\mathbb{E}\left[ h(X)Y \right] -\mathbb{E}(h(X)Y)\\
&=0
\end{aligned}
$$

Consider this vector space $(V,F,+,\cdot)$ where

- $V=\{ X,Y\ldots \}$, is all the random variables (and all the functions of r.v.s. which are also random variables)
- $F=\mathbb{R}$

We can define an inner product on this space.

$$
\left\langle X,Y \right\rangle=\mathbb{E}(XY)
$$

We can verify that this is a _non-negative, additive, symmetry, homogeneous_ bilinear form.

Therefore, $\mathbb{E}\left[(Y-\mathbb{E}(Y|X))\, h(X)\right]=0$ can be interpreted as:

$$
\left\langle Y-\mathbb{E}(Y|X),h(X) \right\rangle=0
\iff (Y-\mathbb{E}(Y|X)) \perp h(X)
$$

This shows that $Y-\mathbb{E}(Y|X)$ and the subspace $U=\{h(X)\mid h:\mathbb{V}\to \mathbb{V}\}$ are orthogonal.  
The projection of $Y$ on $U=\{ h(X) \}$ is $\mathbb{E}(Y|X)$

#### MMSE

$$
\begin{aligned}
{\begin{Vmatrix} Y-g(X) \end{Vmatrix}}^2
&={\begin{Vmatrix} Y-\mathbb{E}(Y|X) + \mathbb{E}(Y|X)-g(X) \end{Vmatrix}}^2\\
&={\begin{Vmatrix} Y-\mathbb{E}(Y|X) \end{Vmatrix}}^2 + {\begin{Vmatrix} \mathbb{E}(Y|X)-g(X) \end{Vmatrix}}^2
+2\left\langle Y-\mathbb{E}(Y|X), \mathbb{E}(Y|X)-g(X)\right\rangle\\
&={\begin{Vmatrix} Y-\mathbb{E}(Y|X) \end{Vmatrix}}^2 + {\begin{Vmatrix} \mathbb{E}(Y|X)-g(X) \end{Vmatrix}}^2\\
&\leqslant {\begin{Vmatrix} Y-\mathbb{E}(Y|X) \end{Vmatrix}}^2 + 0
\qquad (\text{when $g(X)=\mathbb{E}(Y|X)$})
\end{aligned}
$$

Where $\mathbb{E}(Y|X)-g(X)$, as a function of $X$ is orthogonal to $Y-\mathbb{E}(Y|X)$.

This is the Minimum Mean Square Error (MMSE) estimator of $Y$ given $X$.  
$\operatorname{MMSE}(Y|X)=\operatorname{proj}_{\{h(X)\mid h:\mathbb{V}\to \mathbb{V}\}}(Y)=\mathbb{E}(Y|X)$.

#### Uniqueness of the projection

For a function $g(X)$, $\left( \forall h,\, Y-g(X)\perp h(x) \right)\iff g(X)=\mathbb{E}(Y|X)$  
Or in language of linear algebra: $v=\operatorname{proj}_{W} u \iff v\in W\land \left(\forall x\in W,\, 0=\left\langle x,u-v \right\rangle\right)$

We will show LHS implies RHS.

Let $h(X)=g(X)-\mathbb{E}(Y|X)$ be a function of $X$,  
then $h(X)\perp \left( Y-g(X)\right)$ and $h(X)\perp \left(Y-\mathbb{E}(Y|X)\right)$

$$
\begin{aligned}
\left\langle h(X), Y-g(X) \right\rangle
&=\left\langle h(X), Y-\mathbb{E}(Y|X) \right\rangle\\
\implies 0
&=\left\langle h(X), \left( Y-g(X) \right) - \left( Y-\mathbb{E}(Y|X) \right) \right\rangle\\
&=\left\langle h(X), \mathbb{E}(Y|X)-g(X) \right\rangle\\
&=\left\langle h(X), h(X) \right\rangle\\
&={\begin{Vmatrix} h(X) \end{Vmatrix}}^2\\
\implies h(X)&=g(X)-\mathbb{E}(Y|X)=0\\
\implies g(X)&=\mathbb{E}(Y|X)\\
\end{aligned}
$$

#### LLSE

Besides the general MMSE, we also have the convenient LLSE (linear least square error estimator).  
The LLSE of $Y$ given $X$ is defined as $\operatorname{LLSE}(Y|X)=\operatorname{proj}_{\{ a+bX\mid a,b\in F \}}(Y)$.

We will introduce the method to find LLSE but skip the proof.

$$
\begin{aligned}
&\begin{cases}
\mathbb{E}(Y)
&=\mathbb{E}\left[ a+bX \right]
=a+b\mathbb{E}(X)\\
\operatorname{Cov}(X,Y)
&=\operatorname{Cov}(X,a+bX)
=b\operatorname{Var}(X)\\
\end{cases}\\
&\begin{cases}
a&=\mathbb{E}(Y) - \mathbb{E}(X)b\\
b&=\frac{\operatorname{Cov}(X,Y)}{\operatorname{Var}(X)} \\
\end{cases}
\end{aligned}
$$

#### MMSE and LLSE in BVN (Bivariate Normal Variables)

Suppose that $(X,Y)$ is a BVN i.e. any linear combination of $X,Y$ has a $\mathcal{N}(\mu,\sigma^2)$ distribution.  
Then MMSE of $Y$ given $X$ is equal to the LLSE of $Y$ given $X$. $\operatorname{MMSE}(Y|X)=\operatorname{LLSE}(Y|X)$.

Let $\mathrm{L}(Y|X)=a+bX$, where $b=\frac{\operatorname{Cov}(X,Y)}{\operatorname{Var}(X)}, a=\mathbb{E}(Y)-\mathbb{E}(X)\frac{\operatorname{Cov}(X,Y)}{\operatorname{Var}(X)}$.

$$
\begin{aligned}
\mathrm{L}(Y|X)
&=\mathbb{E}(Y)-\mathbb{E}(X)\frac{\operatorname{Cov}(X,Y)}{\operatorname{Var}(X)}
+X\frac{\operatorname{Cov}(X,Y)}{\operatorname{Var}(X)}\\
&=\mathbb{E}(Y)+(X-\mathbb{E}(X))\frac{\operatorname{Cov}(X,Y)}{\operatorname{Var}(X)}
\end{aligned}
$$

1. $Y-\mathrm{L}(Y|X)\perp X$ since $\mathrm{L}(Y|X)$ is the projection of $Y$ on $\{a+bX\mid a,b\in F\}$
2. $Z=Y-\mathrm{L}(Y|X)=Y-(a+bX)$ is a normal random variable since $(X,Y)$ is a BVN.  
   $(Z,X)$ is also a BVN as every linear combination of $Z,X$ is a linear combination of $X,Y$.
3. $Z,X$ are uncorrelated.
   $$
   \begin{aligned}
   \operatorname{Cov}(Z,X)
   &=\mathbb{E}(XZ)-\mathbb{E}(X)\mathbb{E}(Z)\\
   &=\left\langle X,Z\right\rangle -\mathbb{E}(X)\cdot 0\\
   &=0-0=0
   \end{aligned}
   $$
   In BVN, uncorrelated implies independent.
4. $Z=Y-\mathrm{L}(Y|X)$ is independent of $X$, so it is independent of any function of $X$, $h(X)$.  
   $Z,h(X)$ independent implies $\operatorname{Cov}(Z,h(X))=0$.
5. Consider the inner product of $h(X)$ and $Y-\mathrm{L}(Y|X)$, we want to show that they are orthogonal.
   $$
   \begin{aligned}
   \left\langle Y-\mathrm{L}(Y|X), h(X) \right\rangle
   &=\operatorname{Cov}(Y-\mathrm{L}(Y|X),h(X))+\mathbb{E}h(X)\mathbb{E}(Y-\mathrm{L}(Y|X))\\
   &=0+\mathbb{E}h(X)\cdot 0=0
   \end{aligned}
   $$
6. Therefore, $Y-\mathrm{L}(Y|X)$ is orthogonal to $\{h(X)\mid h:V\to V\}$.  
   $\mathrm{L}(Y|X)$ is the projection of $Y$ on $\{h(X)\mid h:V\to V\}$.  
   Hence, $\mathrm{L}(Y|X)=\mathbb{E}(Y|X)$.

- The projection on function space gives MMSE (the best approximation).
- The projection on linear function space gives LLSE (the best linear approximation).

## ch10 Inequalities and Limit Theorems

### CLT: central limit theorem

For $n$ i.i.d. r.v.s $X_1\ldots X_n$,
where $\mathbb{E}(X_i)=\mu,\operatorname{Var}(X_i)=\sigma^2$

Then as $n\to \infty$

$$
\sqrt{n}\left( \frac{\bar{X}-\mu}{\sigma} \right) \to \mathcal{N}(0,1)
$$

Proof:

0. WLOG, let $\mu=0,\sigma=1$.
1. Let $M(t)=\mathbb{E}\left( e^{tX} \right)$ be the MGF of $X_i$ (If the MGF does not converge, we turn to the Characteristic Function).
2. MGF $\sqrt{n} \bar X$ of is $\mathbb{E}\left( e^{\frac{\sum_{i=1}^n X_i}{\sqrt{n}}} \right)=M^n\left(\frac{t}{\sqrt n}\right)$.
3. Take logarithm, apply LH, use $M^{(k)}(0)=\mathbb{E}\left( X^k \right)$ to find the limit MGF.

#### Approximation

For sufficiently large $n$, we have

$$
\sum_{i=1}^n X_i \sim \mathcal{N}(n\mu,n\sigma^2)
\quad
\sum_{i=1}^n X_i-n\mu\sim\mathcal{N}(0,n\sigma^2)
$$

Continuity correction for discrete random variable

$$
P(X=k)=P(k-1/2 < X < k+1/2)
$$

Example: For $Y\sim\mathrm{Bin}(n,p)$, we can view $Y$ as sum of $n$ i.i.d. $\mathrm{Bern}(p)$  
Thus $Y$ approximately has $\mathcal{N}(np,npq)$ distribution,
and $\frac{Y-np}{\sqrt{npq}}$ has a $\mathcal{N}(0,1)$ distribution approximately.

$$
\begin{aligned}
P(Y=k)
&= P\left(k-\frac{1}{2} < Y < k+\frac{1}{2}\right)\\
&= P\left(k-np-\frac{1}{2} < Y-np < k-np+\frac{1}{2}\right)\\
&= P\left(
\frac{k-np-\frac{1}{2}}{\sqrt{n pq}}
< \frac{Y-np}{\sqrt{n pq}} <
\frac{k-np+\frac{1}{2}}{\sqrt{n pq}}\right)\\
&\approx
\Phi\left( \frac{k-np+\frac{1}{2}}{\sqrt{n pq}}\right)-\Phi\left( \frac{k-np-\frac{1}{2}}{\sqrt{n pq}}\right)
\end{aligned}
$$

### Cauchy-Schwarz

$\left\langle X,Y \right\rangle = \mathbb{E}(XY)$ is a real inner product on the space of random variables (and their functions).

- positive definitive. $\mathbb{E}(X\cdot X)\geq 0$, we have $\mathbb{E}(X^2)=0$ iff $X=0$ with probability $1$.
- symmetry. $\mathbb{E}(XY)=\mathbb{E}(YX)$
- additive. $\mathbb{E}((X+Y)Z)=\mathbb{E}(XZ)+\mathbb{E}(YZ)$
- homogeneous. $\mathbb{E}(kXY)=k\mathbb{E}(XY)$

Thus, ${\left\langle X,Y\right\rangle}^2\leq
{ \left\langle X,X \right\rangle }
{ \left\langle Y,Y \right\rangle }$ which is $\mathbb{E}(XY)\leq \sqrt{\mathbb{E}(X^2)\mathbb{E}(Y^2)}$

#### Proof

$$
0\leq
\left\langle X-tY, X-tY \right\rangle
=\left\langle X,X \right\rangle
-2t\left\langle X,Y \right\rangle
+t^2\left\langle Y,Y \right\rangle
\implies
{\left(-2\left\langle X,Y \right\rangle\right)}^2
-4\left\langle X,X \right\rangle \left\langle Y,Y \right\rangle
\leq 0
$$

#### applications

##### bound on correlation

$$
\operatorname{Cov}(X,Y)
=\mathbb{E}\left[ (X-\mathbb{E}X)(Y-\mathbb{E}Y) \right]
\leq \sqrt{\mathbb{E}{(X-\mathbb{E}X)}^2 \mathbb{E}{(Y-\mathbb{E}Y)}^2}
=\sqrt{\operatorname{Cov}(X,X)\operatorname{Cov}(Y,Y)}
$$

This implies that $\begin{vmatrix} \operatorname{Corr}(X,Y) \end{vmatrix}\leq 1$

##### convergence of joint MGF

For random variables $X,Y$, we have (no requirement for independence)

$$
\mathbb{E}(e^{t(X+Y)})
=\mathbb{E}(e^{tX} e^{tY})
\leq\sqrt{
\mathbb{E}\left({\left( e^{tX} \right)}^2 \right)
\mathbb{E}\left({\left( e^{tY} \right)}^2 \right)
}
=\sqrt{
\mathbb{E}{\left( e^{(2t)X} \right)}
\mathbb{E}{\left( e^{(2t)Y} \right)}
}
$$

This helps to determine the ROC (range of convergence) of joint MGF.

##### The Second Moment Method

Let $X$ be a non-negative r.v. then $X=X\, I(X\neq 0)$

$$
\mathbb{E}(X)=\mathbb{E}\left[ X I(X\neq 0) \right]
\leq \sqrt{\mathbb{E}(X^2) \mathbb{E}(I^2(X\neq 0))}
$$

We have $\mathbb{E}(I^2(X\neq 0))=\mathbb{E}I(X\neq 0)=P(X\neq 0)=1-P(X=0)$

$$
{(\mathbb{E}X)}^2
\leq \mathbb{E}(X^2) (1-P(X=0))
\implies
P(X=0)\leq \frac{\operatorname{Var}(X)}{\mathbb{E}(X^2)}
$$

For $n$ **uncorrelated** indicators $I_1\ldots I_n$,
let $p_i=\mathbb{E}(I_i)$.  
For $X=\sum_{i=1}^n I_i$, consider the second moment and the expectation, we have

$$
\begin{aligned}
\mathbb{E}(X)
&=\mathbb{E}\left( \sum_{i=1}^n I_i \right)
=\sum_{i=1}^n \mathbb{E}(I_i)
=\sum_{i=1}^n p_i\\
\operatorname{Var}(X)
&=\operatorname{Cov}(X,X)
=\sum_{i=1}^n\sum_{j=1}^n\operatorname{Cov}(I_i,I_j)
=\sum_{i=1}^n\operatorname{Var}(I_i)
=\sum_{i=1}^n p_i (1-p_i)\\
\mathbb{E}(X^2)
&=\operatorname{Var}(X)+{(\mathbb{E}X)}^2
=\sum_{i=1}^n p_i (1-p_i)+{\left( \sum_{i=1}^n p_i \right)}^2\\
\Pr(X=0)
&\leq \frac{\operatorname{Var}(X)}{\mathbb{E}(X^2)}
=\frac
{ \sum_{i=1}^n p_i -\sum_{i=1}^n p_i^2 }
{ \sum_{i=1}^n p_i -\sum_{i=1}^n p_i^2 +{\left( \sum_{i=1}^n p_i \right)}^2 }
\leq
\frac{1}{1+\sum_{i=1}^n p_i}
\end{aligned}
$$

### Jensen

- $g''(x)\geq 0\implies \mathbb{E}g(X)\geq g(\mathbb{E}X)$
- $g''(x)\leq 0\implies \mathbb{E}g(X)\leq g(\mathbb{E}X)$

Taylor series expanded at $\mu=\mathbb{E}(X)$

#### proof

For the first case $g''(x)\geq 0$

$$
g(x)=\sum_{n=0}^\infty \frac{g^{(n)}(\mu)}{n!}{(x-\mu)}^n
$$

Take the first order approximation (the tangent line at $(\mu,g(\mu))$):

$$
f(x)=g(\mu)+(x-\mu)g'(\mu)
$$

We will show that this is a lower bound of $g(x)$

$$
\begin{aligned}
h(x)&=f(x)-g(x)\\
h(\mu)&=0\\
h'(x)&=f'(x)-g'(x)=g'(\mu)-g'(x)\\
h'(\mu)&=0\\
h''(x)&=f''(x)-g''(x)=0-g''(x)\leq 0\\
\forall x<\mu &\quad h'(x)\geq h'(\mu)=0
\implies \forall x<\mu\ h(x)\leq h(\mu)=0 \\
\forall x>\mu &\quad h'(x)\leq h'(\mu)=0
\implies \forall x>\mu\ h(x)\leq h(\mu)=0 \\
\forall x &\quad h(x)\leq 0\quad f(x)\leq g(x)
\end{aligned}
$$

Thus, we have $f(X)\leq g(X)$
which leads to $\mathbb{E}(f(X))\leq \mathbb{E}(g(X))$,  
where $\mathbb{E}(f(X))=\mathbb{E}\left[ g(\mu)+(X-\mu)g'(\mu) \right]=g(\mathbb{E}X)$

#### examples

##### Sample standard deviation is biased

For $n$ i.i.d. r.v.s $X_1\ldots X_n$, where $\mathbb{E}(X_i)=\mu,\operatorname{Var}(X_i)=\sigma^2$.  
we have

$$
S_n^2=\frac{1}{n-1}\sum_{i=1}^n {(X-\bar X)}^2
\quad
\mathbb{E}(S_n^2)= \sigma^2
$$

However, for the sample standard deviation $S_n$, we have

$$
\mathbb{E}S_n = \mathbb{E}\sqrt{S_n^2}\leq \sqrt{\mathbb{E} S_n^2}=\sqrt{\sigma^2}=\sigma
$$

where $f(x)=\sqrt x$ is a convex function

##### maximize the information entropy of a discrete distribution

For a discrete random variable $X$. $X=p_i$ with probability $p_i$ and $\sum_{i=1}^n p_i=1$.  
The entropy is defined as

$$
H(X)=-\sum_{i=1}^n p_i\log_2 p_i=\sum_{i=1}^n p_i \log_2 \frac{1}{p_i}
$$

We construct another random variable $Y$ where $Y=\frac{1}{p_i}$ with probability $p_i$.
Then $H(X)=\mathbb{E}\left(\log_2 Y\right)$.  
The function $g(x)=\log_2 x\ (x>0)$ is convex, so we have:

$$
H(X)=\mathbb{E}\left(\log_2 Y \right)
\leq
\log_2 \mathbb{E}(Y)=\log_2 n
$$

If $p_1,p_2\ldots p_n=\frac{1}{n}$, we have $H(X)=\sum_{i=1}^n \frac{1}{n}\log_2 n=\log_2 n$

Thus, we have found the maximal entropy.

##### Kullback-Leibler divergence is always positive

For $\vec p=(p_1\ldots p_n), \vec q=(q_1\ldots q_n)$ where $p_i,q_i>0,\sum_i p_i=\sum_i q_i=1$.  
The relative entropy from $q$ to $p$ is defined as

$$
D(P || Q)=\sum_{i=1}^n p_i \log_2\frac{1}{q_i}-\sum_{i=1}^n p_i \log_2\frac{1}{p_i}
=\sum_{i=1}^n p_i \log_2 \frac{p_i}{q_i}
=-\sum_{i=1}^n p_i \log_2 \frac{q_i}{p_i}
$$

Construct a random variable $Y$ where $Y=\frac{q_i}{p_i}$ with probability $p_i$,
then $D(P || Q)=-\mathbb{E}(\log_2 Y)$.

$$
\begin{aligned}
\mathbb{E}(\log_2 Y)
&\leq \log_2\mathbb{E}(Y)=\log_2 \left(\sum_i \frac{q_i}{p_i}p_i \right)=\log_2 1=0\\
D(P||Q)
&=-\mathbb{E}(\log_2 Y) \geq 0
\end{aligned}
$$

### Markov, Chebyshev, Chernoff: bounds on tail probability

#### first step: the Markov's inequality

For any non-negative random variable $X$ and positive real number $a>0$,

$$
P(X\geq a)\leq \frac{\mathbb{E}(X)}{a}
$$

The proof is quite simple and intuitive:

$$
X\geq I(X\geq a)a
\implies
\mathbb{E}(X) \geq a P(X\geq a), P(X\geq a)\leq \frac{\mathbb{E}(X)}{a}
$$

For a random variable that could take on negative value, we have

$$
P(|Y|\geq a) \leq \frac{\mathbb{E}|Y|}{a}
$$

#### involving the second moment: Chebyshev's inequality

For any random variable $X$, where $\mathbb{E}(X)=\mu,\operatorname{Var}(X)=\sigma^2$.

$$
P(|X-\mu|\geq a) \leq \frac{\operatorname{Var}(X)}{a^2}
$$

To prove the inequality, we apply Markov's inequality on ${(X-\mu)}^2$.

$$
\begin{aligned}
P(|X-\mu|\geq a)=P({(X-\mu)}^2 \geq a^2)
\leq \frac{\mathbb{E}{(X-\mu)}^2}{a^2}=\frac{\sigma^2}{a^2}
\end{aligned}
$$

The following form is more common in practice

$$
P(|X-\mu|\geq k\sigma) \leq \frac{1}{k^2}
$$

##### the one-sided Chebyshev's inequality

Suppose that $\mathbb{E}(X)=\mu, \operatorname{Var}(X)=\sigma^2$,
consider the probability $P(X-\mu>a)$ for a positive real number $a$.  

For any positive real number $t$, we have that

$$
\begin{aligned}
P(X-\mu>a)
&= P(X-\mu+t > a+t)\\
&\leq P({|X-\mu+t|} > a+t)\\
&\leq \frac{\mathbb{E}{{(X-\mu + t)}^2}}{{(a+t)}^2}\\
&= \frac{
	\mathbb{E}\left[
		{(X-\mu)}^2 +2(X-\mu) t +t^2
	\right]
}{
	{(a+t)}^2
}\\
&= \frac{
\mathbb{E}{(X-\mu)}^2
+2t \mathbb{E}(X-\mu)
+t^2
}{{(a+t)}^2}\\
&=\frac{\sigma^2 +  t^2}{{(a+t)}^2}\\
P(X-\mu > a) &\leq \frac{\sigma^2 +  t^2}{{(a+t)}^2}\\
\end{aligned}
$$

Let $g(t) = \frac{\sigma^2+t^2}{{(a+t)}^2}$, we try to find the minimum value of $g(t)$

$$
g'(t) = \frac{
	2t\, {(a+t)}^2 - (\sigma^2+t^2)\, 2(a+t)
}{ {(a+t)}^4 }
=2 \frac{ at - \sigma^2 }{{(a+t)}^3}
=0
\implies t = \frac{\sigma^2}{a}
$$

And the minima is

$$
g( \sigma^2/a )
= \frac{\sigma^2 +  \sigma^4/a^2}{{(a+\sigma^2/a)}^2}
= \frac{\sigma^2 a^2 +  \sigma^4}{{(a^2+\sigma^2)}^2}
= \frac{\sigma^2 (a^2 +  \sigma^2)}{{(a^2+\sigma^2)}^2}
= \frac{\sigma^2}{a^2+\sigma^2}
$$

On the other hand, if we directly apply the Chebyshev's inequality,
we only get

$$
P(X-\mu > a)\leq P(|X-\mu| > a) \leq \frac{\sigma^2}{a^2}
$$

Therefore, $P(X-\mu > a) \leq \frac{\sigma^2}{\sigma^2 + a^2}$

#### introducing the MGF: Chernoff's inequality

For any random variable $X$, and a real number $a$

$$
\begin{aligned}
\forall t>0
\quad
P(X\geq a)=P(tX \geq ta)=P(e^{tX} \geq e^{ta})
\leq
\frac{\mathbb{E}\left(e^{tX}\right)}{e^{ta}}
\implies
P(X\geq a)\leq \inf_{t>0}
\frac{\mathbb{E}\left(e^{tX}\right)}{e^{ta}} \\
\forall t<0
\quad
P(X\leq a)=P(tX \geq ta)=P(e^{tX} \geq e^{ta})
\leq
\frac{\mathbb{E}\left(e^{tX}\right)}{e^{ta}}
\implies
P(X\geq a)\leq \inf_{t<0}
\frac{\mathbb{E}\left(e^{tX}\right)}{e^{ta}} \\
\end{aligned}
$$

#### Hoeffding lemma: Bound on MGF

If $a\leq X\leq b$ and $\mathbb{E}(X)=0$.
Then

$$
\mathbb{E}(e^{\lambda X})
\leq \exp{\left( \frac{1}{8}\lambda^2 {(b-a)}^2\right)}
$$

If we have $\mathbb{E}(X)=\eta$ instead of $\mathbb{E}(X)=0$.
Then

$$
\mathbb{E}(e^{\lambda X})
=\mathbb{E}\left( e^{\lambda (X-\eta)} \cdot e^{\lambda \eta} \right)
=e^{\lambda \eta} \mathbb{E}\left( e^{\lambda (X-\eta)} \right)
\leq \exp{\left(\eta \lambda+ \frac{1}{8}\lambda^2 {(b-a)}^2\right)}
$$

##### example of Hoeffding lemma

For example, consider the fair random sign $S$ where $P(S=-1)=P(S=1)=\frac{1}{2}$

$$
\begin{aligned}
\mathbb{E}\left(e^{t S}\right)
&=\frac{e^{t}+e^{-t}}{2}
=\frac{1}{2}\sum_{n=0}^\infty \frac{t^n + {(-t)}^n}{n!}\\
&=\sum_{n=0}^\infty \frac{t^{2n}}{(2n)!}
\leq \sum_{n=0}^\infty \frac{t^{2n}}{2^n n!}
=\sum_{n=0}^\infty {\left( \frac{t^2}{2} \right)}^n
=\exp\left( \frac{t^2}{2} \right)
\end{aligned}
$$

##### proof of Hoeffding lemma: a direct application of Jensen's inequality

Suppose that $\mathbb{E}(X)=0$ then $a\leq 0\leq b$.  
Consider the function $f(x)=e^{\lambda x}$, we have $f^{\prime\prime}(x)=\lambda^2 e^{\lambda x}>0$, so $f(x)$ is convex.

$$
\forall x\in [a,b]
\quad
e^{\lambda x} \leq \frac{e^{\lambda b}-e^{\lambda a}}{b-a}(x-a) + e^{\lambda a}
$$

Thus

$$
\mathbb{E}(e^{\lambda X})
\leq \frac{e^{\lambda b}-e^{\lambda a}}{b-a}(-a) + e^{\lambda a}
=e^{\lambda a} \frac{b}{b-a} + e^{\lambda b} \frac{-a}{b-a}
$$

Let $h=\lambda (b-a),p=\frac{-a}{b-a}$ and $L(h)=-hp+\ln (1-p+pe^h)$.
We have $\exp L(h)=e^{\lambda a}\frac{b}{b-a}+e^{\lambda b}\frac{-a}{b-a}$.

We found that $L(0)=L^{\prime}(0)=0$ and $L^{\prime \prime}(h)\leq \frac{1}{4}$  
Use the Taylor expansion we have $L(h)\leq \frac{1}{8}h^2$

Thus

$$
\mathbb{E}(e^{\lambda X})
\leq e^{\lambda a}\frac{b}{b-a} + e^{\lambda b}\frac{-a}{b-a}
=\exp L(h)
\leq \exp\left( \frac{1}{8}h^2  \right) =\exp\left( \frac{1}{8}\lambda^2 {(b-a)}^2  \right)
$$

#### a tighter bound: Hoeffding bound

For $n$ independent random variables $X_1\ldots X_n$ where $a\leq X_i\leq b$.  
Let $S=\sum_{i=1}^n \mathbb{E}(X_i),\mu=S/n$ be the expected sum and expected sample mean respectively.  
Then

$$
P\left( |\bar{X} -\mu| \geq \epsilon \right)
\leq 2\exp\left( - \frac{2n\epsilon^2}{{(b-a)}^2} \right)
$$

Let's try to give a proof, let $Y_i=X_i-\mathbb{E}(X_i)$

$$
\begin{aligned}
\Pr(\bar{X}-\mu \geq \epsilon)
&=\Pr\left(\sum_{i=0}^n X_i-\mathbb{E}(X_i)\geq n\epsilon\right)
=\Pr\left(\sum_{i=0}^n Y_i \geq n\epsilon\right)\\
(\text{Chernoff bound}\quad\forall t>0)
&\leq \frac{\mathbb{E}\left( \exp{\left(t\sum_{i=0}^n Y_i\right)} \right)}{e^{tn\epsilon}}
=e^{-tn\epsilon}\prod_{i=1}^n \mathbb{E}\left( \exp \left( t Y_i \right) \right)\\
&\leq e^{-tn\epsilon}\prod_{i=1}^n
\exp\left(
\frac{1}{8}t^2
{ \left(  [b_i-\mathbb{E}(X_i)]-[a_i-\mathbb{E}(X_i)]  \right) }^2
\right)\\
&= e^{-tn\epsilon}\prod_{i=1}^n
\exp\left( \frac{1}{8}t^2 {(b_i-a_i)}^2 \right)\\
&=\exp\left(
\frac{\sum_{i=1}^n {(b_i-a_i)}^2}{8}t^2-(n\epsilon) t
\right)
\end{aligned}
$$

When $t=-\frac{-n\epsilon}{2\cdot \frac{1}{8}\sum_{i=1}^n {(b_i-a_i)}^2}$, the above formula is minimized, where the minimum probability is

$$
\frac{{4\cdot 0-(n\epsilon)}^2}{4\cdot \frac{1}{8}\sum_{i=1}^n {(b_i-a_i)}^2}
=\frac{2n^2\epsilon^2}{\sum_{i=1}^n {(b_i-a_i)}^2}
$$

A commonly used special case is that
$X_1\ldots X_n$ are not only independent
but also identically distributed, i.e. $\forall i\ [a_1,b_1]=[a_i,b_i]$.  
Then

$$
\Pr(\bar{X}-\mu \geq \epsilon)
\leq \exp \frac{2 n^2 \epsilon^2}{n {(b-a)}^2}
=\exp \frac{2n \epsilon}{{(b-a)}^2}
$$

By symmetry, we have

$$
\Pr(|\bar{X}-\mu| \geq \epsilon)
\leq 2\exp \frac{2n \epsilon^2}{{(b-a)}^2}
$$

##### a typical application of Hoeffding bound

When estimating true mean from the sample mean, Hoeffding bound can be applied to find the confidence interval

$$
P(\mu \in [\bar{X}-\epsilon,\bar{X}+\epsilon])
\geq
1-2\exp\left( - \frac{2n\epsilon^2}{{(b-a)}^2} \right)
$$

For the $1-\Theta$ confidence interval, we should have

$$
\Theta = 2\exp\left( - \frac{2n\epsilon^2}{{(b-a)}^2} \right)
\implies
\epsilon = \sqrt{
\frac{ {(b-a)}^2 \ln{(\Theta/2)} }{ 2n }
}
$$

external link: UCB (upper confidence bound) algorithm

## ch11 Markov Chain

## ch12 MCMC

## ch13 Poisson Process
