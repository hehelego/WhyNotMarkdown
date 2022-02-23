# 概率论与数理统计 note. part 1

> textbook: Introduction to Probability
> author: Joseph K. Blitzstein, Jessica Hwang
> course: Harvard STAT110 Introduction to Probability
>
> textbook: Introduction to Probability
> author: Dimitri P. Bertsekas, John N. Tsitsiklis
> course: MIT 6-041: Probabilistic Systems Analysis & Applied Probability

[TOC]

## ch0 Introduction

## ch1 Probability and Counting

### birthday problem

$$
\begin{aligned}
p_{k,n}
&=\prod_{i=0}^{k-1}\frac{n-i}{n}
=\prod_{i=0}^{k-1}\left(1 - \frac{i}{n} \right)\\
e^x &\approx x+1\quad (|x|\to 0)\\
p_{n,k}
&\approx \prod_{i=0}^{k-1} e^{-\frac{i}{n}}
=\prod_{i=0}^{k-1} \exp\left( {-\frac{i}{n}} \right)
=\exp\left( {-\frac{k(k-1)}{n}} \right)
\end{aligned}
$$

Find the relation between n and k when $p_{n,k}\leq \frac{1}{2}$, using the approximation.  

$$
\begin{aligned}
&p_{n,k}
\approx \exp\left( -\frac{k(k-1)}{n} \right)
\approx \exp\left( -\frac{k^2}{n} \right)
\leq \frac{1}{2}\\
&-\frac{k^2}{n} \leq -\ln 2\quad k\geq \sqrt{n\ln 2}
\end{aligned}
$$

### probability axioms

$(P,S)$ probability space: probability function and probability sample space.

- $\forall A\subseteq S\quad 0\leq P(A)\leq 1$
- $P(\varnothing)=0,\ P(S)=1$
- $A_1,A_2\ldots A_n\ldots$ are disjoint subsets of $S$  
  $P\left(\bigcup_{i=1}^\infty A_i\right)=\sum_{i=1}^\infty P(A_i)$

#### deriving properties of probability from the axioms

complement rule:  
$A\cap A^c = \varnothing, A\cup A^c = S$, so $P(A\cup A^c)=P(A)+P(A^c)=P(S)=1$,  
thus $P(A)=1-P(A^c)$

inclusive-exclusive principle:  
$A\setminus (A\cap B), B$ is a partition of $A\cup B$. $P(A\cup B)=P(A\setminus (A\cap B))+P(B)$  
$A\setminus (A\cap B), A\cap B$ is a partition of $A$. $P(A)=P(A\setminus (A\cap B))+P(A\cap B)$  
$P(A\cup B)=P(A)+P(B)-P(A\cap B)$

subset monotonous:  
$A\subseteq B$.  
$B\setminus A,A$ is a partition of $B$, so $P(B)=P(A)+P(B\setminus A)\geq P(A)+0=P(A)$

Boole inequality: $P(\bigcup_{i=1}^\infty A_i)\leq \sum_{i=1}^\infty A_i$  
Let $B_1=A_1,B_2=A_2\cap \overline{A_1},B_3=A_3\cap \overline{A_1\cap A_2}\ldots B_n=A_n\cap \overline{\bigcap_{i=1}^{n-1} A_i}\ldots$  
The sets $B_i$ are disjoint and $\forall n \bigcup_{i=1}^n A_i=\bigcup_{i=1}^n B_i$  
$$
P\left(\bigcup_{i=1}^\infty A_i\right)
= P\left(\bigcup_{i=1}^\infty B_i\right)
= \sum_{i=1}^n P(B_i)
\leq \sum_{i=1}^n P(A_i)
$$

## ch2 Conditional Probability

LOTP, LOTE (law of total probability/expectation): let $(A_1,A_2\ldots A_n)$ be a partition of $S$  
partition: $\bigcup A_i=S$, $i\neq j\rightarrow A_i\cap A_j=\varnothing$

$$
\begin{aligned}
P(B) &= \sum_{i=1}^n P(B | A_i) P(A_i)\\
E(B) &= \sum_{i=1}^n E(B | A_i) P(A_i)
\end{aligned}
$$

Bayes's rule:

$$
P(A|B)
=\frac{P(B|A)P(A)}{P(B)}
=\frac{P(B|A)P(A)}{P(B|A)P(A)+P(B| A^c)P(A^c)}
$$

### conditional probability as a probability function

In a probability space $(S,P)$ and an event $C\subseteq S$.  
Define the function $\hat P(A)=P(A\mid C)$,
then $(S,\hat P)$ consists a probability space.

- Bayes' rule: $\hat P(A|B)=\frac{\hat P(B|A)P(A)}{P(B)}$  
  which is $P(A\mid B,C)=\frac{P(B | A,C)P(A | C)}{P(B|C)}$
- complement: $\hat P(A^c)=1-\hat P(A)$
- inclusive-exclusive: $\hat P(A\cup B)=\hat P(A)+\hat P(B)-\hat P(A\cap B)$

### independence

Definition: two events $A,B$ are said to be independent if "prior probability equals to posterior probability"

$$
P(A\cap B)=P(A)P(B)
\quad
P(A\mid B)=\frac{P(AB)}{P(B)}=P(A)
$$

the following statements are equivalent

- $A$ and $B$ are independent
- $A^c$ and $B$ are independent
- $A$ and $B^c$ are independent
- $A^c$ and $B^c$ are independent

#### comparison: pairwise independence and independence

PID doesn't imply ID, on the contrary ID implies PID.

e.g. Consider tossing two independent fair coin.

- A: the first coin lands on head.
- B: the second coin lands on head.
- C: the two coin give the same result.

A, B, C are pairwise independent but not independent.  
($A\cap B$ implies $C$)

$$
P(A,B,C)=\frac{1}{4}\neq P(A)P(B)P(C)=\frac{1}{8}
$$

### conditional independence

A, B are said to be conditional independent given $E$ if.
$$
P(A,B | E) = P(A|E)P(B|E)
$$

#### comparison: conditional independence and independence

##### CID can't imply ID

Given a fair coin and a biased coin (land on head at 1/2, 3/4 probability respectively)  
We choose a coin randomly and flip it twice.

- F: the fair coin is chosen
- A: the first tosses landing heads
- B: the second tosses landing heads

$A, B$ are conditional independent given $F$.  

$$
P(A,B | F)=\frac{1}{2}\frac{1}{2} = P(A|F)P(B|F)
$$

But $A,B$ are not independent.

$$
\begin{aligned}
P(A) &= P(A | F)P(F) + P(A | F^c)P(F^c) = \frac{1}{2}\frac{1}{2} + \frac{3}{4}\frac{1}{2} = \frac{5}{8}\\
P(B) &= P(A | F)P(F) + P(A | F^c)P(F^c) = \frac{1}{2}\frac{1}{2} + \frac{3}{4}\frac{1}{2} = \frac{5}{8}\\
P(AB)
&= P(AB | F)P(F) + P(AB | F^c)P(F^c)
=\frac{1}{2} {\left( \frac{1}{2} \right)}^2
+\frac{1}{2} {\left( \frac{3}{4} \right)}^2
=\frac{13}{32}\\
P(A)P(B) &= \frac{25}{64}
\end{aligned}
$$

##### ID can't imply CID

Given two independent events $A, B$ where $0<P(A)=p,P(B)=q<1$, let $C=A\bar{B}+\bar{A}B$.  
$A, \bar{B}$ are not are conditional independent given $C$.

$$
\begin{aligned}
P(A|C) &= \frac{P(A\cap C)}{P(C)}=\frac{P(A\bar{B})}{P(A\bar{B}+\bar{A}B)}=\frac{p(1-q)}{p(1-q)+q(1-p)}>0\\
P(B|C) &= \frac{P(B\cap C)}{P(C)}=\frac{q(1-p)}{p(1-q)+q(1-p)}>0\\
P(A\cap B|C) &= 0\\
P(A|C)P(B|C) &> 0
\end{aligned}
$$

##### CID given E v.s. CID given complement of E

e.g. The courses in university are either graded base on effort or graded base on random number generator.

- G: a course grades students according to academical performance.
- W: work hard.
- A: receive A plus grade.

$A, W$ are conditional independent given $G^c$, but are related(not independent) given $G$.

### example: distribution of the sum of independent identical dice roll

> source:
>
> - Introduction to probability
> - Joseph K. Blitzstein, Jessica Hwang
> - second edition
> - chapter2, exercise 48
>
> [see also](https://www.zhihu.com/question/336062847) `从0点出发,每次向正方向随机走1~k步,求踩到x的概率. 为什么x趋于无穷大时,概率为2/(k+1)`

#### problem statement

A fair die is rolled repeatedly, and a running total is kept (which is, at each time, the total of all the rolls up until that time). Let $p_n$ be the probability that the running total is ever exactly $n$ (assume the die will always be rolled enough time so that the running total will eventually exceed $n$, but it may or may not ever equal $n$).

- write down a recursive relation for $p_n$.
- find $\lim_{n\to \infty}p_n$

#### solution

the RR

$$
p_n=
\begin{cases}
0& n<0\\
1& n=1\\
\frac{1}{6}\left(\sum_{i=1}^6 p_{n-i}\right) & n>1\\
\end{cases}
$$

Every time we roll a die, the sum increase by $\frac{\sum_{i=1}^6 i}{6}=\frac{7}{2}$ on average.
It can be viewed/interpreted in this way "in every 7 consecutive numbers the sum lands on 2 of the 7 numbers", so the probability converges to $\frac{2}{7}$.

A somewhat more convincing proof

$$
\begin{aligned}
 &p_{n+1}+2p_{n+2}+3p_{n+3}+4p_{n+4}+5p_{n+5}+6p_{n+6}\\
=&p_{n+1}+2p_{n+2}+3p_{n+3}+4p_{n+4}+5p_{n+5}+(p_n+p_{n+1}+2p_{n+2}+3p_{n+3}+4p_{n+4}+5p_{n+5})\\
=&p_n+2p_{n+1}+3p_{n+2}+4p_{n+3}+5p_{n+4}+6p_{n+5}\\
=&\cdots\\
=&p_{-5}+2p_{-4}+3p_{-3}+4p_{-2}+5p_{-1}+6p_{0}\\
=&6
\end{aligned}
$$

taking limit when $n\to \infty$ on both side, $6=\sum_{i=1}^6 i\lim_{n\to\infty}p_n$, so $p\to \frac{2}{7}$

## ch3 Random Variables

## ch4 Expectation

### more on indicators

For $n$ (arbitary, independence is not required)events $A_1,A_2\ldots A_n$ and their indicators $I_1,I_2\ldots I_n$.  
Let $X=\sum_{i=1}^n I_i$, consider $\binom{X}{k}$

- $k=0$, $\binom{X}{0}=1$ and $E\left(\binom{X}{0}\right)=1$
- $k=1$, $\binom{X}{1}=X$ and $E\left(\binom{X}{1}\right)=X$
- $k=2$, $\binom{X}{2}=\frac{X(X-1)}{2}=\sum_{i<j}I_iI_j$ and $E\left(\binom{X}{2}\right)=\sum_{i<j}P(A_i\cap A_j)$  
  $
  \begin{aligned}
  X(X-1)
  &=X^2-X\\
  &=\left(2\sum_{i<j}I_iI_j+\sum_i I_i^2\right)-\sum_i I_i\\
  &=\left(2\sum_{i<j}I_iI_j+\sum_i I_i\right)-\sum_i I_i\\
  &=2\sum_{i<j}I_iI_j
  \end{aligned}
  $
- $k=3$, $\binom{X}{3}=\frac{X(X-1)(X-2)}{6}=\sum_{i<j<k}I_iI_jI_k$ and $E\left(\binom{X}{3}\right)=\sum_{i<j<k}P(A_i\cap A_j\cap A_k)$  
  $
  \begin{aligned}
  X(X-1)(X-2)
  &=\left(2\sum_{i<j}I_iI_j\right)\left(\sum_i I_k - 2\right)\\
  &=2\left(\sum_{i<j\land k=i}I_iI_jI_k+\sum_{i<j\land k\neq i\land k\neq j}I_iI_jI_k+\sum_{i<j\land k=j}I_iI_jI_k-2\sum_{i<j}I_iI_j\right)\\
  &=2\left(\sum_{i<j\land k\neq i\land k\neq j}I_iI_jI_k\right)\\
  &=2\left(\sum_{p<q<r}I_pI_qI_r\sum_{i<j\land k\neq i\land k\neq j}[(p,q,r)\in \{(i,j,k),(i,k,j),(k,i,j)\}]\right)\\
  &=2\left(3\sum_{i<j<k}I_iI_jI_k\right)=6\sum_{i<j<k}I_iI_jI_k
  \end{aligned}
  $
- $k=m$, $\binom{X}{m}=\sum_{i_1<i_2\ldots i_m}\prod_{j=1}^m I_j$ and $E\left(\binom{X}{m}\right)=\sum_{i_1<i_2\ldots i_m}P(\prod_{j=1}^m A_{i_j})$

#### evaluate moments of binomial distribution

Given that $X\sim \mathrm{Bin}(n,p)$.  
Let $A_j$ be the event that the $j$th Bernoulli trial success and $I_j$ be the corresponding indicator.  

$
\begin{aligned}
\binom{X}{k}
&=\sum_{p_1<p_2\ldots p_k}\sum_{i=1}^k I_{p_i}\\
\mathbb{E}\binom{X}{k}
&=\sum_{p_1<p_2\ldots p_k}P\left(\prod_{i=1}^k A_{p_i}\right)
=\sum_{p_1<p_2\ldots p_k}p^k=\binom{n}{k}p^k\\
X^m
&=\sum_{i=1}^m \binom{X}{i}i!\begin{Bmatrix}m\\ i\end{Bmatrix}\\
\mathbb{E}(X^m)
&=\sum_{i=1}^m \binom{n}{i}p^i i!\begin{Bmatrix}m\\ i\end{Bmatrix}
=\sum_{i=1}^m n^{\underline i}p^i\begin{Bmatrix}m\\ i\end{Bmatrix}\\
\end{aligned}
$

## ch5 Continuous Random Variable

### normals

If $
X\sim \mathcal{N}(\mu_1,\sigma_1^2),
Y\sim \mathcal{N}(\mu_2,\sigma_2^2)
$ are independent,
then $X+Y\sim \mathcal{N}(\mu_1+\mu_2,\sigma_1^2+\sigma_2^2)$.

Consider the MGF of standard normal $Z\sim \mathcal{N}(0,1)$

$$
\begin{aligned}
M_Z(t)
&
=\mathbb{E}(e^{tZ})
=\int_{-\infty}^{+\infty} e^{tz}\, \frac{1}{\sqrt{2\pi}}e^{-z^2/2}\mathrm{d}z\\
&
=\int_{-\infty}^{+\infty}\frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}(z^2-2tz)}\mathrm{d}z
=\int_{-\infty}^{+\infty}\frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}{(z-t)}^2+\frac{1}{2}t^2}\mathrm{d}z\\
&
=e^{\frac{1}{2}t^2}\int_{-\infty}^{+\infty}\frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}{(z-t)}^2}\mathrm{d}z\\
&
=e^{\frac{1}{2}t^2}\int_{-\infty}^{+\infty}\frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}z^2}\mathrm{d}z
=e^{\frac{1}{2}t^2}\\
&
=\sum_{n=0}^\infty \frac{{(t^2/2)}^n}{n!}
=\sum_{n=0}^\infty \frac{1}{2^n n!}t^{2n}
=\sum_{n=0}^\infty \frac{(2n)!}{2^n\, n!} \frac{t^{2n}}{(2n)!}
=\sum_{n=0}^\infty \left(\prod_{j=1}^{n}(2j-1)\right)\frac{t^{2n}}{(2n)!}
\end{aligned}
$$

Then $M_X(t)=\mathbb{E}(e^{(\sigma Z+\mu)t})=e^{\mu t}\mathbb{E}(e^{(\sigma t)Z})=e^{\mu t}M_{Z}(\sigma t)=e^{\mu t+\frac{\sigma^2}{2}t^2}$  
For $M_{X+Y}(t)=\mathbb{E}(e^{(X+Y)t})=\mathbb{E}(e^Xe^Y)$,
since the two r.v.s are independent, the expectation of product if the product of expectation,
$M_{X+Y}(t)=e^{\mu_1 t+\frac{\sigma_1^2}{2}t^2}e^{\mu_2 t+\frac{\sigma_2^2}{2} t^2}=e^{(\mu_1+\mu_2)t + \frac{\sigma_1^2+\sigma_2^2}{2}t}$.  
This is the MGF of $\mathcal{N}(\mu_1+\mu_2,\sigma_1^2+\sigma_2^2)$, which shows that $X+Y\sim \mathcal{N}(\mu_1+\mu_2,\sigma_1^2+\sigma_2^2)$

### distance between two independent identical normals

$X,Y\sim\mathcal{N}(\mu,\sigma^2)$ are independent, evaluate $\mathbb{E}|X-Y|$.  
Consider $X'=X-\mu,Y'=\mu -Y$, then $X',Y'$ are independent $\mathcal{N}(0,\sigma^2)$ r.v.s.  
Then $X-Y=X'+Y'$ has a $\mathcal{N}(0,2\sigma^2)$ distribution,  
which is same to the distribution of $(\sqrt 2 \sigma)Z$ where $Z\sim\mathcal{N}(0,1)$

$$
\begin{aligned}
\mathbb{E}|X-Y|
=\sqrt 2\sigma\ \mathbb{E}(Z)
&=\sqrt 2\sigma\ \int_{-\infty}^{+\infty}|z|\frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}z^2}\mathrm{d}z
&=\frac{2\sigma}{\sqrt \pi}\ \int_{0}^{+\infty}ze^{-\frac{1}{2}z^2}\mathrm{d}z\\
&=\frac{2\sigma}{\sqrt \pi}\ \int_{+\infty}^{0} \mathrm{d}\left( e^{-\frac{1}{2}z^2} \right)\\
&=\frac{2\sigma}{\sqrt \pi}
\end{aligned}
$$

### exponentials

$X\sim \mathrm{Expo}(\lambda)$ for $\lambda>0$

$$
\begin{aligned}
f(x)
&=\lambda e^{-\lambda x}
\quad (x>0)\\
F(x)
&=P(X\leq x)
=1-e^{-\lambda x}
\quad (x>0)\\
G(x)
&=P(X>x)
=e^{-\lambda x}
\quad (x>0)
\end{aligned}
$$

Consider $Y=\lambda X$ or $X=\frac{Y}{\lambda}$, we have $Y\sim \mathrm{Expo}(1)$

$$
\begin{aligned}
G_Y(y)=P(Y> y)
&=P(X> \frac{y}{\lambda})
=e^{-\lambda \frac{y}{\lambda}}
=e^{-y}
\quad(y>0)
\end{aligned}
$$

The MGF of $Y$ is

$$
M_Y(t)
=\mathbb{E}(e^{tY})
=\int_0^{+\infty} e^{ty} e^{-y}\mathrm{d}x
=\int_0^{+\infty} e^{(t-1)y}\mathrm{d}x
=\frac{1}{1-t}
\quad (t>0)
$$

The momnets are $\mathbb{E}(Y^n)=n!$ and $\mathbb{E}(X^n)=\mathbb{E}\left( {\left(\frac{Y}{\lambda}\right)}^n \right)=\frac{n!}{\lambda^n}$

### min,max of independent exponentials

Given three independent exponentials random variable.

$
X_1\sim \mathrm{Expo}(\lambda_1),
X_2\sim \mathrm{Expo}(\lambda_2),
X_3\sim \mathrm{Expo}(\lambda_3)
$

$$
\begin{aligned}
P(\min(X_1,X_2,X_3)>t)
&
=P(X_1>t,X_2>t,X_3>t)
=P(X_1>t)P(X_2>t)P(X_3>t)\\
&
=e^{-\lambda_1 t}e^{-\lambda_2 t}e^{-\lambda_3 t}
=e^{-(\lambda_1+\lambda_2+\lambda_3) t}\\
P(\max(X_1,X_2,X_3)<t)
&
=P(X_1<t,X_2<t,X_3<t)
=P(X_1<t)P(X_2<t)P(X_3<t)\\
&
=(1-e^{-\lambda_1 t})(1-e^{-\lambda_2 t})(1-e^{-\lambda_3 t})
\end{aligned}
$$

Thus, $\min(X_1,X_2,X_3)\sim \mathrm{Expo}(\lambda_1+\lambda_2+\lambda_3)$, but $\max(X_1,X_2,X_3)$ is not an exponentials r.v.  

### expectation of max of i.i.d. exponentials via memoryless property

Let $X_1,X_2\ldots X_n\sim\mathrm{Expo}(\lambda)$ be $n$ i.i.d. r.v.s. Find $\mathbb{E}(\max(X_1,X_2\ldots X_n))$  
Let $T_1=\mathrm{kth}(1,\{X_i\}), T_2=\mathrm{kth}(2,\{X_i\})\ldots , T_n=\mathrm{kth}(n,\{X_i\})$ then $\max(\{X_i\})=\sum_i T_i$  

- For $T_1$ can be seen as the first arival time in a Poisson process with parameter $n\lambda$.  
  (merged $n$ Poisson process with parameter $\lambda$)
- For $T_2$, by memoryless property, can be viewed as the first arival time in a Poisson process with parameter $(n-1)\lambda$.  
  (merged $n-1$ Poisson process with parameter $\lambda$)
- For $T_n$, by memoryless property, can be viewed as the first arival time in a Poisson process with parameter $1\lambda$.  
  (a Poisson process with parameter $\lambda$)

Then $\mathbb{E}(\max X_i)=\sum_{i=1}^n \frac{1}{i\lambda}$

## ch6 Moments

### sample variance is an unbiased estimation of the variance

Given $n$ independent identical distributed random variables (the samples) $X_1,X_2\ldots X_n$, where $\mathrm{E}(X_i)=\mu,\operatorname{Var}(X_i)=\sigma^2$
We have the nice relation that $\mathrm{E}\left(\frac{1}{n}\sum_{i=1}^n X_i^k\right)=\frac{1}{n}\sum_{i=1}^n \mathrm{E}(X_i^k)=\frac{1}{n}n\mathrm{E}(X_1^k)=\mathrm{E}(X^n)$ for all $k\in \mathbb{Z}$.  
That is, the expectation of sample moments are equal to the corresponding moments or sample moment is unbiased estimator of moment.

Thus
$$
\begin{aligned}
\mathrm{E}(\bar{X})
&=\mathrm{E}(\frac{1}{n}\sum_{i=1}^n X_i)
=\frac{1}{n}\sum_{i=1}^n \mathrm{E}(X_i)
=\mathrm{E}(X)=\mu\\
\operatorname{Var}(\bar{X})
&=\operatorname{Var}\left(\frac{1}{n}\sum_{i=1}^n X_i\right)
=\frac{1}{n^2}\sum_{i=1}^n \operatorname{Var}(X_i)
=\frac{n\sigma^2}{n^2}
=\frac{\sigma^2}{n}
\end{aligned}
$$

However, we can not find the expectation if the distribution is unknown,
(the only thing that we can get to known is the value of samples in a random experiment)
we have to use other estimator.

We define the **sample variance** and the **sample standard deviation** as follows:
$$
S_n^2=\frac{1}{n-1}\sum_{i=1}^n{\left(X_i-\bar{X}\right)}^2
\quad
S_n=\sqrt{S_n^2}
$$

It turns out that $\mathrm{E}(S_n^2)=\sigma^2$

$$
\begin{aligned}
\mathbb{E}\left( \sum_{i=1}^n {\left( X_i-\bar{X}\right)}^2  \right)
&=\mathbb{E}\left(
\sum_{i=1}^n X_i^2 -2\bar{X}\sum_{i=1}^n X_i +n{\bar{X}}^2
\right)\\
&=\mathbb{E}\left(
\sum_{i=1}^n X_i^2 -\frac{2}{n}{\left(\sum_{i=1}^n X_i\right)}^2 +\frac{n}{n^2}{\left( \sum_{i=1}^n X_i \right)}^2
\right)\\
&=\mathbb{E}\left(
\sum_{i=1}^n X_i^2 -\frac{1}{n}{\left(\sum_{i=1}^n X_i\right)}^2
\right)\\
&=\mathbb{E}\left(
\sum_{i=1}^n X_i^2 -\frac{1}{n}{\left(\sum_{i=1}^n X_i^2 + \sum_{i\neq j}X_i X_j \right)}
\right)\\
&=\mathbb{E}\left(
\frac{n-1}{n}\sum_{i=1}^n X_i^2 -\frac{1}{n}\sum_{i\neq j}X_i X_j
\right)\\
&=\frac{n-1}{n}\sum_{i=1}^n \mathbb{E}( X_i^2 ) -\frac{1}{n}\sum_{i\neq j}\mathbb{E}(X_i X_j)\\
&=(n-1)\mathbb{E}( X^2 ) -(n-1){\left( \mathbb{E} X \right)}^2\\
&=(n-1)\operatorname{Var}(X)
\end{aligned}
$$
