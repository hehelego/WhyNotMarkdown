# EE150 course note: Sampling

## Introduction: Sampling Examples

### Polynomial interpolation

For a polynomial of $n$-th order $P(x)=\sum_{i=0}^{n} a_i x^i$.  
If we know the value of $P(x)$ evaluated at $(n+1)$ points 
$(x_0,P(x_0)), (x_1,P(x_1))\ldots (x_n, P(x_n))$,
then we can determine $P(x)$ uniquely.

However, given $n$ points $(x_i,y_i)\ (i=1,2,3\ldots n)$,
we have infinitely many polynomials $P(x)$ of $n$-th order
such that $P(x_i)=y_i$.  
To find one, we can arbitrarily pick another point $(x_0,y_0)$
and use Lagrange's polynomial interpolation formula to determine $P(x)$.

### Sinusoidal evaluated at integral time

For any sinusoidal signal $x(t)=A\cos(\omega t + \varphi)$,  
we can have the uniform unit sampling $x[n]=x(n)$ for $n\in\mathbb{Z}$.

Consider the following two cases

- $x_1(t)=\cos\left( \frac{1\pi}{3} t\right)$, $x_1[n]=\cos\left( \frac{1\pi}{3} n\right)$
- $x_2(t)=\cos\left( \frac{7\pi}{3} t\right)$, $x_2[n]=\cos\left( \frac{7\pi}{3} n\right)$

We know that $\exists t_0\quad x_1(t_0)\neq x_2(t_0)$,
however $\forall n\quad x_1[n]=x_2[n]$.  

That is: provided the uniform unit sampling, we can not distinguish $x_1(t),x_2(t)$.  
In other words: we can not uniquely reconstruct the sinusoidal wave $x(t)$ from $x[n]$.  

The good news is that: for $x(t)=\cos(\omega t)$ and $x[n]=x(1\cdot n)$.  
If $|\omega|<\pi$ we can reconstruct the waveform uniquely.

## Sampling with impulse-train

## The Sampling Theorem

## Sampling with zero-order hold

## Recovering signal from samples

## Sampling discrete-time signals
