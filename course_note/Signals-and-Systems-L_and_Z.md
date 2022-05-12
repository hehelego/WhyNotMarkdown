# EE150 course note: Laplace transform and Z transform

### Laplace transform

### Z transform

## MISC

### Partial fraction decomposition

> See [Wikipedia: partial fraction decomposition](https://en.wikipedia.org/wiki/Partial_fraction_decomposition).
> The following note mainly come from the sections which covers residue method and Heaviside cover-up method.

Suppose that $F(x) = C\frac{P(x)}{Q(x)}$ is a rational function,
where $P(x)=\prod_{i=1}^m {(b_i-x)}^{p_i}, Q(x)=\prod_{i=1}^n {(a_i-x)}^{q_i}$ and $n<m$.

We want to factor $F(x)$ into the following form

$$
\sum_{i=1}^{n}\left(
  \sum_{j=1}^{p_i}
    \frac{A_{ij}}{{(a_i-x)}^j}
\right)
$$

### linear transforms of the partial fraction form

Considering that (power series, ordinary generating function, unilateral Z transform):

$$
{(a-x)}^{-k}
= a^{-k} {\left( 1-\frac{x}{a} \right)}^{-k}
= a^{-k} \sum_{n=0}^{\infty} \binom{-k}{n} {\left(-\frac{x}{a}\right)}^n
= a^{-k} \sum_{n=0}^{\infty} \binom{k+n-1}{n}a^{-n} x^n
$$

And (unilateral Laplace transform)

$$
\begin{aligned}
\mathcal{L}\{e^{-a t} u(t)\}     &= \frac{1}{s+a}\\
\mathcal{L}\{t^n e^{-a t} u(t)\} &= \frac{n!}{{(s+a)}^{n+1}}\\
\end{aligned}
$$

### finding the coefficients

Solve linear equations to get the coefficients.

**Trick 1:** Use $(a_i-x)$ factor to rule out terms:

$$
\lim_{x\to a_i} {(a_i-x)}^{p_i}F(x)=A_{i,p_i}
$$

This is helpful when the roots of $Q(x)$ is unique
i.e. $F(x) = \frac{P(x)}{\prod_{i=1}^{n} (a_i -x)}$

$$
F(x) = \sum_{i=1}^n \frac{A_i}{a_i - x}
\qquad
\lim_{x\to a_k} (a_k - x) F(x)
= \frac{P(a_k)}{\prod_{i\neq k} (a_i - a_k)}
= A_k
$$

**Trick 2:** substitution with proper value for $x$. ($x=a_k-1$ then $a_k-x=1$; $x=a_k+1$ then $a_k-x=-1$)

