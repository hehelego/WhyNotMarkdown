# EE142 Information Theory Course Note

> - textbook: Elements of Information Theory.
> - author: Thomas M. Cover
> - course: ShanghaiTech EE142 Information Theory

[TOC]

## Introduction

Two main questions in information theory:

- source coding: limit of (lossless) data compression.  
  Answer: information entropy.
- channel coding: limit of (error-free) data transmission rate.  
  Answer: channel capacity.

Background settings of information theory:

- classical information theory: p2p (point-to-point) direct data transmission.
- network information theory: MIMO (multiple input and multiple output) broadcasting channel.

## Elements in Digital Communication System

The blocks

- source
- encoder
- channel
- decoder
- sink

Encode/Decode:

- Source coding: data compression
- Channel coding: error detection and correction

Why modulation?  
Answer: baseband transmission to passband transmission.

### Source

Either analog or discrete.

### Channel

Either memoryless or with memory.

Consider the following binary discrete memoryless channels,
whose input and output are denoted by $X$ and $Y$ respectively.

- channel 1: $P(X=\ast,Y=\ast)=\frac{1}{2}$.  
  Channel capacity is zero, no data can be transmitted.
- channel 2: $P(Y=1|X=0)=1-\epsilon=P(Y=0|X=1)$ where $\epsilon$ is a small positive real number.  
  Good channel.
- channel 3: $P(Y=0|X=0)=1-\epsilon=P(Y=1|X=1)$ where $\epsilon$ is a small positive real number.
  Equivalent to channel 2.

Channels covered in EE142 course:

- Discrete ones
  - Binary symmetric channel: $0\to 1$ and $1\to 0$ with fixed probability.
  - Binary erasure channel: $0\to \epsilon$ and $1\to \epsilon$ with fixed probability.
- Continuous ones
  - AWGN (Additive White Gaussian Channel): Output $Y(t)=X(t)+Z(t)$, where $Z(t)$ is a Gaussian process.  
    Capacity (bits per second) $C = W \log_2 \left( 1 + \frac{P}{N_0 W} \right)$,  
	where $W$ spectrum bandwidth, $P$ tx power, $N_0$ channel noise power.
  - Linear Gaussian Channel: AWGN with a LTI filter $H$.
    $Y = H\ast X + Z$.

## Basic Concepts

### Entropy

For a discrete random variable $X$ whose support is $\chi$.
Define the entropy of $X$ to be

$$
H(X)
= \sum_{x\in \chi} -p(x) \log p(x)
= \sum_{x\in \chi} p(x) \log \frac{1}{p(x)}
= \mathbb{E}\left[ \log \frac{1}{p_X(X)}\right]
$$

Mean of self information

**note** differential entropy and $2^{H(X)}$ are used to measure the uncertainty for continuous random variables.  
$H(x) = \int f(x)\log \frac{1}{f(x)} \mathrm{d} x$ 

### Bounds of Entropy

- $H(X)\geq 0$.
  $p(x)\in [0,1]\implies -\log p(x) \geq 0$.
- $H(X)\leq \log |\chi|$. Jensen's inequality. (if and only if 

Suppose that $\chi=\{1,2,3\ldots n\}$ and $\Pr(X=i)=p_i$.
(WLOG, assume that $p_1,p_2\ldots p_n$ are distinct.
Consider another random variable $Y$ where $\Pr(Y=\frac{1}{p_i}) = p_i$

Then $H(X) = \mathbb{E}[ \log_2 Y ]$,
where $\log_2(\cdot)$ is convex.

By Jensen's inequality, $H(X) = \mathbb{E}[ \log_2 Y ] \leq \log_2(\mathbb{E}\, Y) = \log_2 n$.  
Equality hold when $X=\operatorname{Unif}\{1,2,3\ldots n\}$.

An alternative proof with $\ln x \leq x+1$:

$$
\begin{aligned}
H(X) - \ln n 
&= \sum_{i} p_i \left( \ln \frac{1}{p_i} - \ln n \right)
= \sum_{i} p_i \ln \frac{1}{n p_i}\\
&\leq \sum_{i} p_i \left( \frac{1}{n p_i} - 1\right)
=\sum_{i} \frac{1}{n} - \sum_{i} p_i
=0
\end{aligned}
$$

We have the equality iff $\frac{1}{n p_i}=1$ hold true for all $i$,
that is $X$ is a discrete uniform distribution.


### Convexity of Entropy

For $X\sim \mathrm{Bern}(p)$ that is $X=\begin{cases}
1 & \text{w.p.}\ p\\
0 & \text{w.p.}\ 1-p\\
\end{cases}$.

The entropy of this binary random variable $H(X)=p\log\frac{1}{p} + (1-p)\log\frac{1}{1-p}$
is denoted as $H(p)$.
This is a concave function.

Extension: $H(\vec{p})$ where $\vec{p}=(p_1,p_2\ldots p_n)$ such that $\sum_{i} p_i=1$.
$H(\vec{p})=\sum_{i} p_i \log \frac{1}{p_i}$ is a concave function of $\vec{p}$.

$$
\forall \vec{x},\vec{y} .
\forall \lambda \in (0,1) .
\quad
H(\lambda \vec{x} + (1-\lambda) \vec{y})
\geq \lambda f(\vec{x}) + (1-\lambda) f(\vec{y})
$$

#### Proof 1: By definition

Knowing that $x \ln \frac{1}{x}$ is concave on interval $(0,1)$,
we have

$$
\forall x,y\in (0,1) .
\forall \lambda \in (0,1) .
\quad
\lambda x\ln \frac{1}{x} + (1-\lambda) y\ln \frac{1}{y}
\leq
\left[ \lambda x + (1-\lambda)y \right]
\frac{1}{\lambda x + (1-\lambda)y}
$$

Consider the entropy.

$$
\begin{aligned}
H(\lambda \vec{x} + (1-\lambda) \vec{y})
&= \sum_{i} \left[\lambda x_i + (1-\lambda) y_i\right]
   \ln \dfrac{1}{ \left[\lambda x_i + (1-\lambda) y_i\right] }\\
&\geq \sum_{i} \left(
 \lambda x_i \ln \frac{1}{x_i} +(1-\lambda) y_i \ln \frac{1}{y_i}
\right)\\
&= \lambda \sum_{i} x_i \ln \frac{1}{x_i} + (1-\lambda) \sum_{i} y_i \ln \frac{1}{y_i}\\
&=\lambda H(\vec{x}) + (1-\lambda) H(\vec{y})
\end{aligned}
$$

Q.E.D.

#### Proof 2: By Hessian matrix

Consider the Hessian matrix

$$
\begin{aligned}
H(\vec{p})
&= \sum_{i} p_i \log \frac{1}{p_i}\\
\nabla H(\vec{p})
&= \begin{bmatrix}
\frac{\partial}{\partial p_i}\left( -p_i \log p_i \right)
\end{bmatrix}_{i}
= \begin{bmatrix} - \ln p_i - 1 \end{bmatrix}_{i}\\
\mathbf{H}(H(\vec{x}))
&= \begin{bmatrix}
\frac{\partial}{\partial p_i} \left( -\ln p_j - 1 \right)
\end{bmatrix}_{i,j}
=\operatorname{diag}\left( \frac{-1}{p_1}, \frac{-1}{p_2} \ldots \frac{-1}{p_n} \right)
\end{aligned}
$$

As the Hessian matrix is a negative-definite matrix, the scalar-field $H(\vec{x})$ is concave.

### Entropy of Multiple Variables

**NOTE:** The support of $X,Y$ are not necessarily the same.

#### Joint Entropy

Given two random variables $X,Y$ whose joint PMF is $p(x,y)$.
The joint entropy is simply the entropy of the random vector $(X,Y)$.

$$
H(X,Y) = \sum_{x,y} p(x,y) \log \frac{1}{p(x,y)}
=\mathbb{E}_{p(X,Y)} \left[
\log \frac{1}{p(X,Y)}
\right]
$$

#### Conditional Entropy

Condition on a single event

$$
H(Y|X=x) = \sum_{y} p(y|x) \log \frac{1}{p(y|x)}
=\mathbb{E}_{p(Y|X=x)}\left[
\log \frac{1}{p(Y|X=x)}
\right]
$$

Condition on a variable that is condition on a distribution

$$
\begin{aligned}
H(Y|X) 
&= \sum_{x} \Pr(X=x) H(Y|X=x)\\
&= \sum_{x} \Pr(X=x) \sum_{y} p(y|x) \log \frac{1}{p(y|x)}
= \sum_{x}  \sum_{y} p(x,y) \log \frac{1}{p(y|x)}\\
&= \sum_{x,y} p(x,y) \log\frac{1}{p(y|x)}\\
&= \mathbb{E}_{p(X,Y)}\left[
\log \frac{1}{p(Y|X)}
\right]
\end{aligned}
$$

#### Mutual Information

The mutual information measures:

- How much uncertainty of $X$ is fixed when knowing $Y$.
- How much uncertainty of $Y$ is fixed when knowing $X$.
- How much uncertainty is shared by $X$ and $Y$.

$$
I(X;Y) = \sum_{x,y} p(x,y) \log \frac{p(x,y)}{p(x)p(y)}
= \mathbb{E}_{p(X,Y)} \left[
\log \frac{p(X,Y)}{p(X)p(Y)}
\right]
$$

#### Relative Entropy

Also called Kullback–Leibler divergence. It measures the difference of two distribution with identical support.

Suppose that $P$ and $Q$ are two probability distribution on the same support $S$.

$$
D(P||Q) = \sum_{x} p(x)\log \frac{p(x)}{q(x)}
= \mathbb{E}_{p(X)} \left[
\log \frac{p(X)}{q(X)}
\right]
$$

**note** KL-divergence is not a metric as $D(p||q) \neq D(q||p)$.
See [wikipedia: statistical distance](https://en.wikipedia.org/wiki/Statistical_distance) for more elaboration.

#### Cross Entropy

Similar to Kullback–Leibler divergence which measures the difference of two distribution with identical support.

Suppose that $P$ and $Q$ are two probability distribution on the same support $S$.

$$
H(P,Q) = \sum_{x} p(x) \log \frac{1}{q(x)}
=\mathbb{E}_{p(X)} \left[
\log \frac{1}{q(X)}
\right]
$$

#### Entropy Relations

![Entropy relations](Entropy_relation.png)

All the following simply properties can be proved by
patterns recognition and summation transform.

1. $H(P,P) = H(P)$
2. $D(P||Q)=H(P,Q)-H(P,P)$
3. $I(X;Y) = I(Y;X)$
4. $I(X;Y) = D\left(\ p(X,Y) || p(X)p(Y) \ \right)$
5. $I(X;Y) = H(X)-H(X|Y)$
6. $H(X,Y) = H(X)+H(Y)-I(X;Y)$

Theorem 1: Entropy of $X$ is the cross entropy between $X$ and $X$.

$$
\begin{aligned}
H(P,Q) &= \mathbb{E}_{p(X)} \left[ \log \frac{1}{q(X)} \right]\\
H(P,P) &= \mathbb{E}_{p(X)} \left[ \log \frac{1}{p(X)} \right] = H(P)\\
\end{aligned}
$$

Theorem 2: KL-divergence of $P,Q$ and cross entropy of $P,Q$ differs by entropy of $P$.

$$
\begin{aligned}
H(P,Q) - H(P,P) 
&=\mathbb{E}_{p(X)} \left[ \log \frac{1}{q(X)} \right] - \mathbb{E}_{p(X)} \left[ \log \frac{1}{p(X)} \right]\\
&=\mathbb{E}_{p(X)} \left[ \log \frac{p(X)}{q(X)} \right]\\
&=D(P||Q)
\end{aligned}
$$

Theorem 3: Mutual information is symmetric.

$$
I(X;Y) 
= \mathbb{E}_{p(X,Y)} \left[ \log \frac{p(X,Y)}{p(X)p(Y)} \right]
= \mathbb{E}_{p(Y,X)} \left[ \log \frac{p(Y,X)}{p(Y)p(X)} \right]
= I(Y;X) 
$$

Theorem 4: Mutual information is the KL-divergence of joint distribution and product distribution.

$$
I(X;Y) 
= \mathbb{E}_{p(X,Y)} \left[ \log \frac{p(X,Y)}{p(X)p(Y)} \right]
= D\left(\ p(X,Y) || p(X)p(Y) \ \right)
$$

Theorem 5: Mutual information is the shared information.

$$
I(X;Y) = H(X)-H(X|Y)
$$

$$
\begin{aligned}
I(X;Y) 
&= \sum_{x,y} p(x,y) \log \frac{p(x,y)}{p(x)p(y)}\\
&= \sum_{x,y} p(x,y) \left( \log \frac{1}{p(x)} + \log \frac{p(x,y)}{p(y)} \right)\\
&= \sum_{x,y} p(x,y) \log \frac{1}{p(x)} + \sum_{x,y} p(x,y) \log \frac{p(x,y)}{p(y)}\\
&= H(X) - H(X|Y)\\
\sum_{x,y} p(x,y) \log \frac{1}{p(x)} 
&= \sum_{x} \sum_{y} p(x,y) \log \frac{1}{p(x)}\\
&= \sum_{x} \log \frac{1}{p(X)} \sum_{y} p(x,y)\\
&= \sum_{x} p(x) \log \frac{1}{p(X)}\\
&= H(X)\\
\sum_{x,y} p(x,y) \log \frac{p(x,y)}{p(y)}
&= \sum_{x,y} p(x,y) \log \frac{1}{p(x,y)/p(y)}\\
&= \sum_{x,y} p(x,y) \log \frac{1}{p(x|y)}\\
&= H(X|Y)\\
\end{aligned}
$$


Theorem 6: Principle of inclusion and exclusion.

$$
\begin{aligned}
H(X)+H(Y)
&=\sum_{x} p(x) \log \frac{1}{p(x)} + \sum_{y} p(y) \log \frac{1}{p(y)}\\
&=\sum_{x,y} p(x,y) \log \frac{1}{p(x)} + \sum_{x,y} p(x,y) \log \frac{1}{p(y)}\\
&=\sum_{x,y} p(x,y) \log \frac{1}{p(x)p(y)}\\
&=\sum_{x,y} p(x,y) \log \frac{p(x,y)}{p(x)p(y)} - \sum_{x,y} p(x,y) \log p(x,y)\\
&=\sum_{x,y} p(x,y) \log \frac{p(x,y)}{p(x)p(y)} + \sum_{x,y} p(x,y) \log \frac{1}{p(x,y)}\\
&=I(X;Y) + H(X,Y)
\end{aligned}
$$

