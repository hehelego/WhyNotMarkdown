# EE150 course note: Fourier Analayis

## Overview

Consider a LTI system with impulse response $h(t)$.
The response for $x(t)=e^{st}$ is

$$
y(t)=\int_{-\infty}^{+\infty} e^{s(t-\tau)}h(\tau)\mathrm{d}\tau
=e^{st}=\int_{-\infty}^{+\infty} e^{-\tau}h(\tau)\mathrm{d}\tau
$$

Let $H(s)=\mathcal{L}\{h(t)\}=\int_{-\infty}^{+\infty} e^{-\tau}h(\tau)\mathrm{d}\tau$ be a function of $s$,
then $e^{st}\stackrel{H}{\to}H(s) e^{st}$.

In the discrete-time case, let $h[n]$ be the impulse response and $x[n]=z^n$ be the input

$$
y[n]=\sum_{k=-\infty}^{+\infty}z^{n-k}h[k]
=z^{n}\sum_{k=-\infty}^{+\infty}h[k]z^{-k}
$$

Let $H(z)=\mathcal{Z}\{h[n]\}=\sum_{k=-\infty}^{+\infty}h[k]z^{-k}$
then $x[n]\stackrel{H}{\to} H(z) z^n$

Now we know that

- for continuous-time LTI systems: $x_{s}(t)=e^{st}$ is an eigen-vector and the eigen-value is $\mathcal{L}\{h(t)\}(s)$.
- for discrete-time LTI systems: $x_{z}[n]=z^n$ is an eigen-vector and the eigen-value is $\mathcal{Z}\{h[n]\}(z)$.

So we want to express signals in terms of linear combination of complex exponentials.  

In Fourier analysis, we decompose signals into linear combination of $e^{j \omega t}$ or $e^{j\omega n}$.  

## orthogonal and normal basis property

For $S_{T}=\{f\in L^2[-T/2,T/2] \mid f(t)=f(t+T)\}$ define $\left<f,g\right>=\frac{1}{T}\int_{-T/2}^{+T/2} f(t)g^{\ast}(t)\mathrm{d} t$  
then $\{e^{j k \omega t}\mid k\in \mathbb{Z}\}$ is a orthonormal basis, where $\frac{2\pi}{\omega}=T$.

$$
\left< e^{j n\omega t}, e^{j m\omega t} \right>
=\frac{1}{T} \int_{-T/2}^{+T/2}e^{j(n-m)\omega t}\mathrm{d}t
=\begin{cases}
\frac{1}{T}\int_{-T/2}^{+T/2} 1\mathrm{d}t & (n=m)\\
\frac{1}{T}
{\left. \left(
  \frac{ e^{j(n-m)\omega t} }{ j (n-m)\omega }
\right) \right|}_{-T/2}^{+T/2}
& (n\neq m)\\
\end{cases}
=\delta[n-m]
$$

## Fourier Series for Continuous-Time Periodic Signals: CTFS

Suppose that for a CT periodic signal with fundamental period $T_0$,
let $\omega_0 = \frac{2\pi}{T}$.  
If we can find a series $a_k$ such that $x(t)=\sum_{k=-\infty}^{+\infty} a_k e^{jk\omega_0 t}$.  
Then

$$
\begin{aligned}
\left< x(t), e^{jk\omega_0 t} \right>
&=\frac{1}{T_0}\int_0^{T_0} x(t) e^{-j k\omega_0}\mathrm{d}t\\
&=\sum_{n=-\infty}^{+\infty}
  \left(
    a_k \frac{1}{T_0}\int_{0}^{T_0} e^{j (n-k)\omega_0 t}\mathrm{d} t
  \right)\\
&=\sum_{n=-\infty}^{+\infty} a_k [n=k] = a_k
\end{aligned}
$$

### existence

(可积且平方可积, 则FS存在)

### completeness of the basis

Let $a_k$ be the FS of $x(t)$ and $S_n(t)=\sum_{k=-n}^{n} a_k e^{jk\omega_0 t}$

$$
\begin{aligned}
{\left| \left|
f(t)-S_n(t)
\right| \right|}^2
&=\left< f(t)-S_n(t),f(t)-S_n(t) \right>
\to 0\quad (n\to 0)
\end{aligned}
$$

This is equivalent to

$$
\begin{aligned}
\left< f(t),f(t)\right> &= \left< S(t),S(t)\right>\\
\frac{1}{T}\int_{T} {|x(t)|}^2 &= \sum_{k} {|a_k|}^2
\end{aligned}
$$

Let $a_k,b_k$ be the FS of $f,g$ then

$$
\left< f,g \right>
=\frac{1}{4}\left(
\left<f+g,f+g\right> - \left<f-g,f-g\right>
\right)
=\sum_{k} a_k b_k^\ast
$$

### convergence issue

Dirichlet conditions:

- absolutely integrable over a period.
- finite number of extrema during any single period
- finite number of discontinuities in any finite interval of time (each of these discontinuities is finite).

The FS at $x=t$ converges to $\frac{1}{2}\left( \lim_{t\to t_0^{-}}x(t) +\lim_{t\to t_0^{+}}x(t)\right)$

### properties of CTFS

Suppose that $\mathrm{FS}\{x(t)\}=a_k$ and $\mathrm{FS}\{y(t)\}=b_k$,
where $x(t),y(t)$ have period $T_0$ and $\omega_0 = \frac{2\pi}{T}$.

- linearity: $\mathrm{FS}\{\alpha x(t) + \beta y(t)\} = \alpha a_k+\beta b_k$
- convolution sum theorem: $\mathrm{FS}\{x(t)y(t)\}=(a\ast b) [k]$
- periodic convolution integral theorem: $\mathrm{FS}\{(x\ast y)(t)\}=T a_k b_k$
- $\mathrm{FS}\left\{ \sum_{n} \delta(t-nT) \right\} = \frac{1}{T}$: the dirac comb
- $\mathrm{FS}\left\{ \sum_{n} \delta(t-t_0-nT) \right\} = \frac{1}{T} e^{-jk\omega_0 t_0}$: time-shift
- $\mathrm{FS}\{x(t-t_0)\}=e^{-jk\omega_0 t_0}a_k$
- time reversal: $\mathrm{FS}\{x(-t)\}=a_{-k}$
- time scaling: $x(\alpha t)=\sum_{k} a_k e^{jk\omega_0 (\alpha t)}$
- conjugation: $\mathrm{FS}\{x^\ast(t)\}=a_{-k}^\ast$
- derivative: $\mathrm{FS}\{\frac{\mathrm{d}}{\mathrm{d} t}x(t)\}=(jk\omega_0) a_k$
- integral: $\mathrm{FS}\{\int_{-\infty}^{t} x(\tau)\mathrm{d}\tau\}=\frac{a_k}{jk\omega_0}$

## Fourier Series for Discrete-Time Periodic Signals: DTFS

## Fourier Series for Continuous-Time Aperiodic Signals: CTFT

## Fourier Series for Discrete-Time Aperiodic Signals: DTFT

## Discrete Fourier Transform: DFT
