# EE150 course note: Fourier Analysis

## Overview

Consider an LTI system with impulse response $h(t)$.
The response for $x(t)=e^{st}$ is

$$
y(t)=\int_{-\infty}^{+\infty} e^{s(t-\tau)}h(\tau)\mathrm{d}\tau
=e^{st}=\int_{-\infty}^{+\infty} e^{-\tau}h(\tau)\mathrm{d}\tau
$$

Let $H(s)=\mathcal{L}\{h(t)\}(s)=\int_{-\infty}^{+\infty} e^{-st}h(t)\mathrm{d}t$ be a function of $s$,
then $e^{st}\stackrel{H}{\to}H(s) e^{st}$.

In the discrete-time case, let $h[n]$ be the impulse response and $x[n]=z^n$ be the input

$$
y[n]=\sum_{k=-\infty}^{+\infty}z^{n-k}h[k]
=z^{n}\sum_{k=-\infty}^{+\infty}h[k]z^{-k}
$$

Let $H(z)=\mathcal{Z}\{h[n]\}=\sum_{k=-\infty}^{+\infty}h[k]z^{-k}$
then $z[n]\stackrel{H}{\to} H(z) z^n$

Now we know that

- For continuous-time LTI systems: $x_{s}(t)=e^{st}$ is an eigenvector and the eigenvalue is $\mathcal{L}\{h(t)\}(s)$.
- For discrete-time LTI systems: $x_{z}[n]=z^n$ is an eigenvector and the eigenvalue is $\mathcal{Z}\{h[n]\}(z)$.

So we want to express signals in terms of linear combination of complex exponentials.  

In Fourier analysis, we decompose signals into linear combination of $e^{j \omega t}$ or $e^{j\omega n}$.  

- CT $|e^{j\omega t}|\equiv 1$:
  $\mathcal{F}\{x(t)\}(\omega) = \mathcal{L}\{x(t)\}(0+j\omega)$.  
  The imaginary axis of the complex plane.
- DT $|e^{j\omega n}|\equiv 1$:
  $\mathcal{F}\{x[n]\}(e^{j\omega}) = \mathcal{Z}\{x[n]\}(e^{j\omega})$  
  The unit circle on the complex plane.

Considering that

$$
\left| \int f(t)e^{j\omega t} \mathrm{d}t \right|
\leq \int \left| f(t)e^{j\omega t} \right| \mathrm{d}t 
= \int |f(t)| \left|e^{j\omega t}\right|\mathrm{d}t
= \int |f(t)| \mathrm{d}t
$$

and

$$
\left| \sum_{n}x[n] e^{-j\omega n} \right|
\leq \sum_{n}\left| x[n] e^{-j\omega n} \right|
=\sum_{n}| x[n] | \left| e^{-j\omega n} \right|
=\sum_{n}| x[n] |
$$

FS/FT always exists for absolutely integrable functions and absolutely summable series,
which makes the problem easier.

## Fourier Series for Continuous-Time Periodic Signals

> also known as `CTFS`

### The function space and the basis

> Find an orthogonal and normal basis
> for the square-integrable functions on $[-T/2,T/2]$

For every function $f(t)$ in $L^2[-T/2,T/2]$ we can
extend it into a periodic function with period $T$ defined on $\mathbb{R}$.

Consider defining an inner product the space of square integrable signals with period $T$:

$$
\left<f,g\right>=\frac{1}{T}\int_{-T/2}^{+T/2} f(t)g^{\ast}(t)\mathrm{d} t
$$

**NOTE:** the integration interval can be $[l,l+T]$ for any $l$.

We can verify that this is an inner product

- symmetry: $\left<f,g\right>={\left(\left<g,f\right>\right)}^{\ast}$
- additive: $\left<f+g,h\right> = \left<f,h\right> + \left<g,h\right>$
- homogenous: $\left<\alpha f,h\right> = \alpha \left<f,g\right>$
- semi-positive definite: $\left<f,f\right> \geq 0$ (we have an equal sign only when $f\equiv 0$ almost everywhere)

Then $\{x_k(t)=e^{j k \omega t}\mid k\in \mathbb{Z}\}$ is an orthonormal basis, where $\frac{2\pi}{\omega}=T$.

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

Thus, we have the CTFS analysis and synthesis equation

$$
x(t)=\sum_{k=-\infty}^{+\infty} a_k e^{jk\omega_0 t}
\qquad
a_k = \frac{1}{T_0}\int_{<T>}x(t) e^{-jk\omega_0 t}\mathrm{d}t
$$

**NOTE:** $a_0$ is somewhat a special case. It is the mean of the time-domain signal, known as the DC component.


### Existence

(可积且平方可积, 则FS存在)

### completeness of the basis

Let $a_k$ be the FS of $x(t)$ and $S_n(t)=\sum_{k=-n}^{n} a_k e^{jk\omega_0 t}$

Here we use the square-mean convergence

$$
\begin{aligned}
{\left| \left|
f(t)-S_n(t)
\right| \right|}^2
&=\left< f(t)-S_n(t),f(t)-S_n(t) \right>
\to 0\quad (n\to 0)
\end{aligned}
$$

If the above criterion is satisfied, then

$$
\begin{aligned}
\left< f(t),f(t)\right>
&=\left< S(t),S(t)\right>\\
\frac{1}{T}\int_{<T>} f(t) f^\ast(t)\mathrm{d}t
&=\sum_{r,s} \left< a_r e^{r\omega t}, a_s e^{s\omega t}\right>=\sum_{r,s} a_r a_s^\ast \delta[r-s]\\
\frac{1}{T}\int_{<T>} {| f(t) |}^2 \mathrm{d}t
&=\sum_k {|a_k|}^2\\
\end{aligned}
$$

This is known as the Parseval's identity.  
With the help of the Parseval's identity, we can evaluate the inner product readily.  

Let $a_k,b_k$ be the FS of $f,g$ then

$$
\left< f,g \right>
=\sum_{k} a_k b_k^\ast
$$

where:

$$
\begin{aligned}
\left< f,g \right>
&=\left< \sum_r a_r e^{j r\omega t}, \sum_s b_s e^{j s\omega t} \right>\\
&=\sum_{r,s} a_r b_s^\ast \left< e^{j r\omega t}, e^{j s\omega t}\right>\\
&=\sum_{r,s} a_r b_s^\ast \delta[r-s]\\
&=\sum_{k} a_k b_k^\ast
\end{aligned}
$$

### Convergence issue for CTFS

Dirichlet conditions:

- Absolutely integrable over a period.
- Finite number of extrema during any single period
- Finite number of discontinuities in any finite interval of time (each of these discontinuities is finite).

The FS at $x=t$ converges to

$$
\frac{
  \lim\limits_{t\to t_0^{-}}x(t) +\lim\limits_{t\to t_0^{+}}x(t)
}{2}
$$

### Properties of CTFS

Suppose that $\mathrm{FS}\{x(t)\}=a_k$ and $\mathrm{FS}\{y(t)\}=b_k$,
where $x(t),y(t)$ have period $T_0$ and $\omega_0 = \frac{2\pi}{T}$.

- linearity: $\mathrm{FS}\{\alpha x(t) + \beta y(t)\} = \alpha a_k+\beta b_k$
  $$
  \frac{1}{T}\int\limits_{<T>} \left[ \alpha x(t) + \beta y(t) \right] e^{-jk\omega t}\mathrm{d} t
  =\frac{\alpha }{T}\int\limits_{<T>} x(t) e^{-jk\omega t}\mathrm{d} t
  +\frac{\beta }{T}\int\limits_{<T>} y(t) e^{-jk\omega t}\mathrm{d} t
  =\alpha a_k + \beta b_k
  $$
- convolution sum theorem: $\mathrm{FS}\{x(t)y(t)\}=(a\ast b) [k]$
  $$
  \frac{1}{T}\int\limits_{<T>} \left(x(t)\sum_{r}b_r e^{jr\omega t}\right) e^{-jk\omega t}\mathrm{d}t
  =\sum_{r}b_r \left(
  \frac{1}{T}\int\limits_{<T>} x(t) e^{-j(k-r)\omega t}\mathrm{d}t
  \right)
  =\sum_{r} b_r a_{k-r}
  $$
- periodic convolution integral theorem: $\mathrm{FS}\{(x\ast y)(t)\}=T a_k b_k$  
  where $(x\ast y)(t)=\int\limits_{<T>} x(\tau)y(t-\tau)\mathrm{d}\tau$ is the periodic convolution integral.
  $$
  \frac{1}{T}\int\limits_{<T>} \left(
  \int\limits_{<T>}x(r) y(t-r)\mathrm{d}r
  \right)
  e^{-jk\omega t}\mathrm{d} t
  =\frac{T}{T}\int\limits_{<T>}
  x(r)e^{-jk\omega r}
  \left(
	  \frac{1}{T}\int\limits_{<T>}
	  y(t-r)e^{-jk \omega (t-r)}\mathrm{d}t
  \right)
  \mathrm{d}r
  =T a_k b_k
  $$
- $\mathrm{FS}\left\{ \sum_{n} \delta(t-nT) \right\} = \frac{1}{T}$: the Dirac comb
- $\mathrm{FS}\left\{ \sum_{n} \delta(t-t_0-nT) \right\} = \frac{1}{T} e^{-jk\omega_0 t_0}$: time-shift
- $\mathrm{FS}\{x(t-t_0)\}=e^{-jk\omega_0 t_0}a_k$
- time reversal: $\mathrm{FS}\{x(-t)\}=a_{-k}$
  $$
  \frac{1}{T}\int_{0}^{T} x(-t)e^{-jk\omega t}\mathrm{d} t
  =\frac{1}{T}\int_{0}^{-T} x(t)e^{jk\omega t}\mathrm{d}(-t)
  =\frac{1}{T}\int_{-T}^{0} x(t)e^{jk\omega t}\mathrm{d}t
  =a_{-k}
  $$
- time scaling: $x(\alpha t)=\sum_{k} a_k e^{jk\omega_0 (\alpha t)}$
  $$
  x(t)=\sum_{k} a_k e^{jk\omega t}
  \quad
  x(\alpha t) = \sum_{k} a_k e^{jk(\alpha \omega) t}
  $$
- conjugation: $\mathrm{FS}\{x^\ast(t)\}=a_{-k}^\ast$
  $$
  x^\ast(t) = {\left(
	  \sum_{k} a_k e^{jk\omega t}
  \right)}^\ast
  =\sum_{k} a_k^\ast e^{-jk\omega t}
  =\sum_{k} a_{-k}^\ast e^{jk\omega t}
  $$
- time-domain derivative: $\mathrm{FS}\{\frac{\mathrm{d}}{\mathrm{d} t}x(t)\}=(jk\omega_0) a_k$.
  $$
  \frac{\mathrm{d}}{ \mathrm{d}t }x(t)
  =\sum_{k}a_k \frac{\mathrm{d}}{\mathrm{d} t}e^{jk\omega t}
  =\sum_{k}a_k (jk\omega) e^{jk\omega t}
  $$
- time-domain integration: $\mathrm{FS}\{\int_{-\infty}^{t} x(\tau)\mathrm{d}\tau\}=\frac{a_k}{jk\omega_0}$
- **note:** special case for $a_0$ in differentiation and integration
- frequency-domain shifting: $\mathrm{FS}\{e^{jn\omega t} x(t)\} = a_{k-n}$
  $$
  e^{jn\omega t}x(t)
  = \sum_{k} a_k e^{j(k+n)\omega t}
  = \sum_{k} a_{k-n}e^{jk\omega t}
  $$

A few more things:

- Real signal: $x(t)=x^\ast(t)$ so $a_k = a_{-k}^\ast$
- Purely imaginary signal: $x(t)+x^\ast(t)=0$ so $a_k + a_{-k}^\ast=0$
- Even signal: $x(t)=x(-t)$ so $a_k = a_{-k}$
- Odd signal: $x(t)+x(-t)=0$ so $a_k+a_{-k}=0$

### Evaluating the response with CTFS

Suppose that $h(t)$ is the impulse response of an LTI system,
evaluate the system response $y(t)$ when the input is $f_T(t)$ (a signal with period $T$).

The frequency-response approach:

1. Evaluate the frequency-response $H(j\omega)=\int_{-\infty}^{+\infty} h(t) e^{-j\omega t}\mathrm{d}t$
2. Decompose the input signal with CTFS: $f(t)=\sum_{n} a_n e^{jn\omega_0 t}$ where $\omega_0 = \frac{2\pi}{T}$
3. By linearity: the output is $y(t)=\sum_{n} a_n H(jn\omega_0) e^{j\omega_0 n t}$


## Fourier Series for Discrete-Time Periodic Signals

> known as `DTFS`

### Orthonormal basis of signals with a fixed period

On vector space consists of all discrete-time signal of period $N$,
we can define an inner product in the following form:

$$
\left<x[n],y[n]\right>
=\frac{1}{N}\sum_{n=0}^{N-1}x[n]y^{\ast}[n]
$$

We can verify that this operator satisfies the inner product axioms.

Now let us consider the set
$\{ x_k[n]=e^{j k \omega_0 n}\mid k\in \mathbb{Z} \}$
where $\omega_0 = \frac{2\pi}{N}$  

**NOTE:** $x_{k+N}[n]=e^{j (k+N) \omega_0 n}=e^{jk\omega_0 n}e^{j (N\omega_0) n}=e^{j k\omega_0 n} e^{j(2\pi) n}=x_{k}[n]$.  
Thus, the set can be simplified to $\{ x_k[n]=e^{j k \omega_0 n}\mid k=0,1,2\ldots N-1 \}$  
**NOTE:** For DT signals the frequency falls in $[0,2\pi]$.
In $[0,2\pi]$, frequency that is close to $\pi$ is considered as high frequency,
while the one close to $0$ or $2\pi$ is regarded as the low frequency.


$$
\begin{aligned}
\left< x_p[n], x_q[n]\right>
&=\frac{1}{N}\sum_{k=0}^{N-1} x_p[k] x^\ast_q[k]
=\frac{1}{N}\sum_{k=0}^{N-1} e^{j p\omega_0 k}e^{-j q\omega_0 k}
=\frac{1}{N}\sum_{k=0}^{N-1} {\left( e^{j (p-q)\omega_0} \right)}^k\\
&=\begin{cases}
\frac{1}{N}\cdot N    &p =   q\\
\frac{1}{N}\frac{1-e^{j(p-q)\omega_0 N}}{1-e^{j (p-q)\omega_0}}  &p\neq q
\end{cases}
=\begin{cases}
1    &p =   q\\
\frac{1}{N}\frac{1-e^{j 2\pi(p-q)}}{1-e^{j (p-q)\omega_0}}  &p\neq q
\end{cases}\\
&=[p=q]=\delta[p-q]
\end{aligned}
$$

$
Thus, the set of complex exponentials with period $N$ forms an orthonormal set.  
Furthermore, we can show that this is a complete basis.

### Extracting the coefficients

Suppose that $x[n]$ with period $N$ can be written as $x[n]=\sum_{k=0}^{N-1} a_k e^{j k\omega n}$ where $\omega = \frac{2\pi}{N}$.  
Then

$$
\left<x[n],e^{j(m\omega)n}\right>
=\sum_{k=0}^{N-1} \left<a_k e^{jk\omega n},e^{j(m\omega) n}\right>
=a_m
$$

That is to say

$$
a_k
=\left<x[n],e^{j(k\omega) n}\right>
=\frac{1}{N}\sum_{n=0}^{N-1} x[n] e^{-j(k\omega) n}
\qquad
x[n]=\sum_{k=0}^{N-1} a_k e^{jk\omega n}
$$

### Convergence issue for DTFS

The DTFS for periodic signal is guaranteed to exist
and always converges to the original signal.

### Properties of DTFS

Suppose that $x[n],y[n]$ are discrete-time signals with periodic $N$, let $\omega =\frac{2\pi}{N}$.  
Let $a_k,b_k$ be the FS of $x[n],y[n]$ respectively.

- linearity
- conjugation
- time-reversal
- time-shift
  $$
  x[n-n_0]
  = \sum_{k=<N>} a_k e^{jk\omega (n-n_0)}
  = \sum_{k=<N>} \left( e^{-jk\omega n_0}a_k\right) e^{jk\omega n}
  $$
- Corollary: first order difference: let $z[n]=x[n]-x[n-1]$, then $\mathrm{FS}\{z[n]\}=(1-e^{-jk\omega})a_k$
- frequency-shift
  $$
  e^{jp\omega n}x[n]
  =\sum_{k=<N>} a_k e^{j(k+p)\omega n}
  =\sum_{k=<N>} a_{k-p} e^{jk\omega n}
  $$
- time-domain convolution theorem: let $z[n]=\sum\limits_{k=<N>}x[k] y[n-k]$, then $\mathrm{FS}\{z[n]\}=Na_kb_k$
  $$
  \begin{aligned}
  \frac{1}{N}\sum_{n=<N>} z[n]e^{-jk\omega n}
  &=\frac{1}{N}\sum_{n=<N>} \left(
  	\sum_{r=<N>}
		x[r]e^{-jk\omega r}
		\,
		y[n-r] e^{-jk\omega (n-r)}
  \right)\\
  &=\frac{1}{N}\left( \sum_{r=<N>}x[r]e^{-jk\omega r} \sum_{s=<N>}y[s]e^{-jk\omega s}\right)\\
  &=Na_k b_k
  \end{aligned}
  $$
- frequency-domain convolution theorem: let $z[n]=x[n]y[n]$, then $\mathrm{FS}\{z[n]\}=\sum\limits_{k=<N>} a_k b_{n-k}$
  $$
  \begin{aligned}
  z[n]
  &=x[n]y[n]=
  \left( \sum_{r=<N>}a_r e^{jr\omega n} \right)
  \left( \sum_{s=<N>}b_s e^{js\omega n} \right)\\
  &=\sum_{r,s} a_r b_s e^{j (r+s)\omega n}
  =\sum_{k=<N>}\left(
	  e^{jk\omega n}
	  \sum_{r=<N>} a_r b_{k-r}
  \right)
  \end{aligned}
  $$
- Parseval's identity:
  $$
  \begin{aligned}
  \frac{1}{N}\sum_{k=<N>} {|x[n]|}^2
  &=\frac{1}{N}\sum_{k=<N>} x[n]x^\ast[n]=\left<x[n],x[n]\right>\\
  &=\left<
  \sum_r a_r e^{jr\omega n},
  \sum_s a_s e^{js\omega n}
  \right>
  =\sum_{r,s} a_r a_s^\ast \left< e^{jr\omega n},e^{js\omega n} \right>
  =\sum_{r,s} a_r a_s^\ast \delta[r-s]\\
  &=\sum_{k=<N>} {|a_k|}^2
  \end{aligned}
  $$
- Corollary: $\left<x[n],y[n]\right>=\frac{1}{N}\sum_{k=<N>}x[k]y^\ast[n-k]=\sum_{k=<N>} a_k b_k^{\ast}$

A few more things:

- real signal: $x[n]=x^\ast[n]\implies a_k=a_{-k}^\ast$
- purely imaginary: $x[n]+x^\ast[n]=0\implies a_k + a_{-k}^\ast=0$
- odd signal: $x[n]+x[-n]=0\implies a_k+a_{-k}=0$
- even signal: $x[n]=x[-n]\implies a_k=a_{-k}$

### Finding the response with DTFS

Given an LTI system with impulse response $h[n]$ and input $x[n]$ with period $N$, find the response.

1. Evaluate the frequency-response $H(e^{j\omega})=\sum_{n} h[n] e^{-j\omega n}$
2. Decompose the input signal with CTFS: $x[n]=\sum\limits_{k=<N>} a_k e^{jk\omega_0 n}$ where $\omega_0 = \frac{2\pi}{N}$
3. By linearity: the output is $y[n]=\sum_{k} a_k H(e^{jk\omega_0}) e^{jk \omega_0 n}$


## Fourier Transform for Continuous-Time Aperiodic Signals: CTFT

### Periodic replication of an aperiodic signal: CTFS to CTFT

Given an aperiodic signal $x(t)$ and a positive real number $T$,
we can define $y(t)$ to be

$$y(t)=x(t\bmod T)$$

- for $t\in [-T,0]$, we have $y(t)=x(t+T)$
- for $t\in [0,T]$,  we have $y(t)=x(t)$
- for $t\in [T,2T]$, we have $y(t)=x(t-T)$
- for $t\in [kT,(k+1)T]$, we have $y(t)=x(t-kT)$

Now consider the Fourier Series of $y(t)$, let $\omega_0=\frac{2\pi}{T}$

$$
a_k
=\frac{1}{T}\int_{0}^{T} x(t)e^{-jk\omega_0 t}\mathrm{d}t
\qquad
x(t)
=\sum_{k=-\infty}^{+\infty} a_k e^{jk\omega_0 t}
$$

Define

$$
X(j\omega) = \int_{-T/2}^{+T/2} x(t)e^{-j\omega t}\mathrm{d}t
$$

Then

$$
a_k=\frac{1}{T} X(j k\omega_0) = \frac{\omega_0}{2\pi}X(j k\omega_0)
\qquad
x_T(t)=\frac{1}{2\pi}\sum_{k} X(jk\omega_0)e^{jk\omega_0 t} \omega_0
$$

As $T\to +\infty$, we have

$$
X(j\omega) = \int_{-\infty}^{+\infty} x(t)e^{-j\omega t}\mathrm{d}t
\qquad
x(t) = \frac{1}{2\pi} \int_{-\infty}^{+\infty} X(j\omega)e^{j\omega t} \mathrm{d}\omega
$$

which are the Fourier Transform (FT) and inverse Fourier Transform (iFT).  

The Fourier Transform can be viewed as a special case of the Laplace Transform.  
So the eigenvector property can be applied

$$
\mathcal{F}\{x(t)\}(\omega) = \mathcal{L}\{x(t)\}(j\omega)
\implies
x(t)\ast e^{j\omega t} = X(j\omega) e^{j\omega t}
$$

### Another integrable function space and orthonormal complete basis

Let $S=\{f:\mathbb{R}\to \mathbb{C}\mid \int_{-\infty}^{+\infty} {|f(t)|}\mathrm{d}t < \infty\}$.  
Define an inner product on $S$:
$\left<f,g\right>=\lim\limits_{T\to +\infty} \frac{1}{T}\int_{-T/2}^{T/2} f(t)g^\ast(t)\mathrm{d} t$.  
Then $\{e^{j\omega t}\mid \omega \in \mathbb{R}\}$ is an orthonormal basis.

When $\omega_0\neq \omega_1$, we have

$$
\begin{aligned}
\left<e^{j\omega_0 t},e^{j\omega_1 t}\right>
&=\lim_{T\to +\infty} \frac{1}{T}\int_{-T/2}^{T/2} e^{j(\omega_0-\omega_1) t}\mathrm{d}t\\
&=\lim_{T\to +\infty} \frac{1}{T}\frac{e^{j\omega T/2}-e^{-j\omega T/2}}{j\omega} \quad (\text{where}\ \omega=\omega_0-\omega_1)\\
&=\lim_{T\to +\infty} \frac{1}{T}\frac{2j\, \sin(j\omega T/2)}{j\omega}=0
{\displaystyle \lim _{a\to 0}\int _{-\infty }^{\infty }{\frac {1}{a}}\operatorname {sinc} \left({\frac {x}{a}}\right)\varphi (x)\,dx=\varphi (0)}
\end{aligned}
$$

and

$$
\left<e^{j\omega t},e^{j\omega t}\right>
=\lim_{T\to +\infty} \frac{1}{T}\int_{-T/2}^{T/2}e^{j\omega t}e^{-j\omega t} \mathrm{d}t
=\lim_{T\to +\infty} \frac{1}{T}\int_{-T/2}^{T/2}1\mathrm{d}t=1
$$

### Properties of CTFT

Suppose that $X(j\omega), Y(j\omega), H(j\omega)$
are the Fourier transform of $x(t),y(t),h(t)$ respectively.

- linearity
- time-domain shifting $\mathcal{F}\{x(t-t_0)\}=e^{-j\omega_0 t}X(j\omega)$
  $$
  x(t-t_0)
  = \frac{1}{2\pi}\int_{-\infty}^{+\infty} X(j\omega) e^{j\omega (t-t_0)}\mathrm{d}\omega
  = \frac{1}{2\pi}\int_{-\infty}^{+\infty} e^{-j\omega t_0}X(j\omega) e^{j\omega t}\mathrm{d}\omega
  $$
- frequency-domain shifting $\mathcal{F}\{e^{j\omega t} x(t)\}=X(j(\omega -\omega_0))$
  $$
  e^{j\omega_0 t}x(t)
  = \frac{1}{2\pi} \int_{-\infty}^{+\infty} X(j\omega) e^{j(\omega +\omega_0) t}\mathrm{d} \omega
  = \frac{1}{2\pi} \int_{-\infty}^{+\infty} X(j(\omega-\omega_0)) e^{j\omega t}\mathrm{d} \omega
  $$
- conjugation: $\mathcal{F}\{x^\ast(t)\}(\omega)=\mathcal{F}^\ast\{x(t)\}(-\omega)$
  $$
  \begin{aligned}
  x^\ast(t)
  &=\frac{1}{2\pi}
  {\left(
    \int_{-\infty}^{+\infty} X(j\omega) e^{j\omega t}\mathrm{d}\omega
  \right)}^\ast
  =\frac{1}{2\pi}\int_{-\infty}^{+\infty} X^\ast(j\omega) e^{-j\omega t}\mathrm{d}\omega\\
  &=\frac{1}{2\pi}\int_{+\infty}^{-\infty} X^\ast(-j\omega) e^{j\omega t}\mathrm{d}(-\omega)
  =\frac{1}{2\pi}\int_{-\infty}^{+\infty} X^\ast(-j\omega) e^{j\omega t}\mathrm{d}\omega
  \end{aligned}
  $$
- time-reversal: $\mathcal{F}\{x(-t)\}(\omega)=\mathcal{F}\{x(t)\}(-\omega)$
  $$
  x(-t)
  =\frac{1}{2\pi}\int_{-\infty}^{+\infty} X(j\omega) e^{-j\omega t}\mathrm{d} \omega
  =\frac{1}{2\pi}\int_{+\infty}^{-\infty} X(-j\omega) e^{j\omega t}\mathrm{d}(-\omega)
  =\frac{1}{2\pi}\int_{-\infty}^{+\infty} X(-j\omega) e^{j\omega t}\mathrm{d}\omega
  $$
- time-scaling is frequency-scaling:  
  For $a>0$:
  $$
  \begin{aligned}
  x(at)
  &= \frac{1}{2\pi}\int_{-\infty}^{+\infty}
  X(j\omega) e^{j\omega (at)} \mathrm{d}\omega\\
  &= \frac{1}{2\pi}\int_{-\infty}^{+\infty}
  X\left(j\frac{\omega}{a}\right)
  e^{j\omega t}
  \mathrm{d}\left(\frac{\omega}{a}\right)\\
  &= \frac{1}{2\pi}\int_{-\infty}^{+\infty}
  \frac{1}{a}X\left(j\frac{\omega}{a}\right)
  e^{j\omega t}
  \mathrm{d}\omega\\
  \mathcal{F}\{x(at)\}(\omega)
  &=\frac{1}{a}\mathcal{F}\{x(t)\}(\omega/a)
  \end{aligned}
  $$
  For $a<0$:
  $$
  \mathcal{F}\{x(at)\}(\omega)
  =\mathcal{F}\{x(-at)\}(-\omega)
  =\frac{-1}{a}\mathcal{F}\{x(t)\}(\omega/a)
  $$
  In summary:
  $$
  \mathcal{F}\{x(at)\}(\omega)
  =\frac{1}{|a|}\mathcal{F}\{x(t)\}(\frac{\omega}{a})
  $$
- time-domain derivative: $\mathcal{F}\{x(t)\}(\omega) = j\omega \mathcal{F}\{x(t)\}(\omega)=j\omega X(j\omega)$
  $$
  \frac{\mathrm{d}}{\mathrm{d}t}
  \left(
	  \frac{1}{2\pi}\int_{-\infty}^{+\infty} X(j\omega) e^{j\omega t}\mathrm{d}\omega
  \right)
  =\frac{1}{2\pi}\int_{-\infty}^{+\infty} X(j\omega) \frac{\mathrm{d}}{\mathrm{d} t}e^{j\omega t}\mathrm{d}\omega
  =\frac{1}{2\pi}\int_{-\infty}^{+\infty} j\omega X(j\omega) e^{j\omega t}\mathrm{d}\omega
  $$
- frequency-domain derivative: $\mathcal{F}\{t x(t)\}(\omega) = j\frac{\mathrm{d}}{\mathrm{d}\omega}\mathcal{F}\{x(t)\}(\omega)=j X^\prime(j\omega)$
  $$
  \begin{aligned}
  \frac{\mathrm{d}}{\mathrm{d}\omega}
  \int_{-\infty}^{+\infty} x(t)e^{-j\omega t}\mathrm{d}t
  =\int_{-\infty}^{+\infty} x(t)\frac{\mathrm{d}}{\mathrm{d}\omega}e^{-j\omega t}\mathrm{d}t
  =\int_{-\infty}^{+\infty} (-jt x(t))e^{-j\omega t}\mathrm{d}t
  \end{aligned}
  $$
- time-domain convolution: $y(t)=x(t)\ast h(t) \iff Y(j\omega)=X(j\omega) H(j\omega)$
  $$
  \begin{aligned}
  Y(j\omega)
  &= \int_{-\infty}^{+\infty} (x\ast h)(t)e^{-j\omega t}\mathrm{d} t
   = \int_{-\infty}^{+\infty}\left(
     \int_{-\infty}^{+\infty} x(\tau) h(t-\tau) \mathrm{d}\tau
   \right) e^{-j\omega t}\mathrm{d} t\\
  &= \int_{-\infty}^{+\infty} x(\tau) e^{-j\omega \tau}
  \left(
	  \int_{-\infty}^{+\infty}
	  e^{-j\omega (t-\tau)}
	  h(t-\tau)
	  \mathrm{d}t
  \right) \mathrm{d}\tau\\
  &= \int_{-\infty}^{+\infty} x(\tau) e^{-j\omega \tau}
  \left(
	  \int_{-\infty}^{+\infty}
	  e^{-j\omega t}
	  h(t)
	  \mathrm{d}t
  \right) \mathrm{d}\tau\\
  &= X(j\omega) H(j\omega)
  \end{aligned}
  $$
- frequency-domain convolution: $h(t)=x(t)y(t)\iff H(j\omega) = \frac{1}{2\pi} \left[X(j\omega)\ast Y(j\omega)\right]$
  $$
  \begin{aligned}
  h(t) &= \frac{1}{4\pi^2}
  \left(
	  \int_{-\infty}^{+\infty}
	    X(j\omega_1) e^{j\omega_1 t}
	  \mathrm{d}\omega_1
  \right)
  \left(
	  \int_{-\infty}^{+\infty}
	    Y(j\omega_2) e^{j\omega_2 t}
	  \mathrm{d}\omega_2
  \right)\\
  &= \frac{1}{4\pi^2}
	  \int_{-\infty}^{+\infty} \int_{-\infty}^{+\infty}
	    X(j\omega_1) Y(j\omega_2)
		e^{j(\omega_1+\omega_2) t}
	  \mathrm{d}\omega_1 \mathrm{d}\omega_2\\
  &= \frac{1}{2\pi}
  \int_{-\infty}^{+\infty}
  \left(
  \frac{1}{2\pi}
  \int_{-\infty}^{+\infty}
  X(j\omega_0) Y(j(\omega-\omega_0))
  \right)
  e^{j\omega t}
  \mathrm{d}\omega
  \end{aligned}
  $$
- Parseval's identity: $\int_{-\infty}^{+\infty} {|x(t)|}^2\mathrm{d}t=\frac{1}{2\pi}\int_{-\infty}^{+\infty} {|X(j\omega)|}^2\mathrm{d}\omega$  
  Consider the spectrum of ${|x(t)|}^2$:
  $${|x(t)|}^2=x(t)\cdot x^\ast(t)\iff \mathcal{F}\{{|x(t)|}^2\}=\frac{1}{2\pi}[X(j\omega)\ast X^\ast(-j\omega)]$$
  then
  $$
  \begin{aligned}
  \int_{-\infty}^{+\infty} {|x(t)|}^2\mathrm{d}t
  &=\int_{-\infty}^{+\infty} {|x(t)|}^2 e^{j0t}\mathrm{d}t
  =\mathcal{F}\{{|x(t)|}^2\}(0)\\
  &=\frac{1}{2\pi} \int_{-\infty}^{+\infty} X(j\omega) X^\ast(-j(-\omega))\mathrm{d}t
  =\frac{1}{2\pi} \int_{-\infty}^{+\infty} X(j\omega) X^\ast(j\omega)\mathrm{d}t\\
  &=\frac{1}{2\pi} \int_{-\infty}^{+\infty} {|X(j\omega)|}^2\mathrm{d}t\\
  \end{aligned}
  $$

#### Duality of CTFT

Suppose that $X(\omega)=\mathcal{L}\{x(t)\}(j\omega)$ is the Fourier Transform of $x(t)$ then:

$$
\begin{aligned}
X(\omega)
&=\mathcal{F}\{x(t)\}(\omega)\\
\mathcal{F}\{X(\omega)\}(t)
&=2\pi x(-t)
\end{aligned}
$$

Proof:

$$
\begin{aligned}
x(t)
&=\frac{1}{2\pi} \int_{-\infty}^{+\infty} X(\omega) e^{j\omega t}\mathrm{d}\omega\\
2\pi x(-t)
&=\int_{-\infty}^{+\infty} X(\omega) e^{j\omega (-t)}\mathrm{d}\omega
=\int_{-\infty}^{+\infty} X(\omega) e^{-j\omega t}\mathrm{d}\omega
=\mathcal{F}\{X(\omega)\}(t)\\
\end{aligned}
$$

That is

$$
\mathcal{F}^2\{f(t)\}(x)
=\mathcal{F}\left\{
	\mathcal{F}\{f(t)\}
\right\}(x)
=2\pi f(-x)
$$

### Fourier Transform for Periodic Signals

Notice that the inverse Fourier Transform of $2\pi \delta(\omega - \omega_0)$ is

$$
\frac{1}{2\pi}\int_{-\infty}^{+\infty} 2\pi \delta(\omega-\omega_0) e^{j\omega t} \mathrm{d}\omega
=\int_{-\infty}^{+\infty} \delta(\omega-\omega_0) e^{j\omega t} \mathrm{d}\omega
=e^{j\omega_0 t}
$$

Suppose that $x(t)$ is a periodic signal with period $T_0$, and $x(t)=\sum_{k} a_k e^{jk\omega_0 t}$
is the Fourier Series representation of $x(t)$, where $\omega_0 = \frac{2\pi}{T}$.

$$
a_k = \frac{1}{T_0}\int_{<T_0>} x(t)e^{-jk\omega_0 t}\mathrm{d}t
\qquad
x(t)=\sum_{k} a_k e^{j k \omega_0 t}
$$

We can define the Fourier Transform of $x(t)$ as
a series of impulses at $\omega = k\omega_0$ of amplitude $2\pi\, a_k$

$$
X(j\omega) = 2\pi \sum_{k} a_k\delta(\omega-k\omega_0)
$$

We can verify that

$$
\frac{1}{2\pi}\int_{-\infty}^{+\infty} X(j\omega) e^{j\omega t}\mathrm{d}\omega
=\sum_{k} a_k \int_{-\infty}^{+\infty} \delta(\omega-k\omega_0)e^{j\omega t}\mathrm{d}\omega
=\sum_{k} a_k e^{j k\omega_0 t}
$$

### Example: Fourier Transform of the Dirac comb

Consider the Dirac comb function (set of unit impulses at $nT$ for all $n\in \mathbb{Z}$)

$$
\mathrm{Comb}_T(t)=\sum_{n=-\infty}^{+\infty}\delta(t-nT)
$$

Let $\omega_0 = \frac{2\pi}{T}$ be the fundamental angle frequency.
The Fourier Series coefficients of $\mathrm{Comb}_T(t)$ can be computed as

$$
a_k
=\frac{1}{T}\int_{-T/2}^{+T/2} \mathrm{Comb}_T(t)e^{-jk\omega_0 t}\mathrm{d}t
=\frac{1}{T}\int_{-T/2}^{+T/2} \delta(t)e^{-jk\omega_0 t}\mathrm{d}t
=\frac{1}{T}
$$

So the Fourier Transform of the Dirac Comb is

$$
\mathcal{F}\{ \mathrm{Comb}_T(t) \}(\omega)
=\sum_{n} 2\pi \frac{1}{T} \delta(\omega - k\omega_0)
=\frac{2\pi}{T} \sum_{n}\delta(\omega-k\omega_0)
=\omega_0 \mathrm{Comb}_{\omega_0}(\omega)
$$

### Example: Fourier Transform of the sin/cos functions

$$
\sin(at) = \frac{e^{jat}-e^{-jat}}{2j}
\qquad
\cos(at) = \frac{e^{jat}+e^{-jat}}{2}
$$

Thus

$$
\begin{aligned}
\mathcal{F}\{\sin(at)\}(\omega)
&=2\pi\frac{1}{2j}\delta(\omega-a)+2\pi \frac{-1}{2j}\delta(\omega+a)
=\pi j\delta(\omega+a)-\pi j\delta(\omega-a)\\
\mathcal{F}\{\cos(at)\}(\omega)
&=2\pi\frac{1}{2}\delta(\omega-a)+2\pi \frac{1}{2}\delta(\omega+a)
=\pi\delta(\omega+a) +\pi\delta(\omega-a)\\
\end{aligned}
$$

### Fourier Transform of the exponentials

Consider the signal $e^{at}$ where $a=\sigma + j\omega_0$.

- $\sigma=0$, the spectrum of $e^{j\omega_0 t}$ is $2\pi \delta(\omega-\omega_0)$
- $\sigma>0$, then $\left| e^{at} \right| = e^{\sigma t}\to +\infty$ when $t\to +\infty$.
  No Fourier Transform.
- $\sigma<0$, then $\left| e^{at} \right| = e^{\sigma t}\to +\infty$ when $t\to -\infty$
  No Fourier Transform.

#### The one-sided (unilateral) exponential signal

Consider the signal $x(t)=e^{-at}u(t)$ where $\mathrm{Re}(a)=\sigma>0$

$$
X(j\omega)
=\int_{0}^{+\infty} e^{-(a+j\omega)t}\mathrm{d}t
={\left.\left(
\frac{e^{-(a+j\omega)t}}{-(a+j\omega)}
\right)\right|}_{0}^{+\infty}
=\frac{1}{a+j\omega}
$$

#### The two-sided (bilateral) exponential signal

For $a\in \mathbb{C}$ such that $\mathrm{Re}(a)>0$

- Even two-sided exponential: $x_e(t)=e^{-a|t|}$
- Odd two-sided exponential: $x_o(t)=e^{-a|t|} \operatorname{sgn}(t)=\begin{cases} e^{-at} & t>0\\ -e^{at}&t<0\end{cases}$

$$
\begin{aligned}
X_1(j\omega)
&=\int_{0}^{+\infty} e^{-(a+j\omega)t}\mathrm{d}t
+\int_{-\infty}^{0} e^{(a-j\omega)t}\mathrm{d}t\\
&=\frac{1}{a+j\omega} + \frac{1}{a-j\omega} = \frac{2a}{a^2+\omega^2}\\
X_2(j\omega)
&=\int_{0}^{+\infty} e^{-(a+j\omega)t}\mathrm{d}t
-\int_{-\infty}^{0} e^{(a-j\omega)t}\mathrm{d}t\\
&=\frac{1}{a+j\omega} - \frac{1}{a-j\omega} = \frac{-2j\omega}{a^2+\omega^2}\\
\end{aligned}
$$

#### Fourier Transform of the Heaviside unit step function

- see [Fourier transform of the unit step function](https://bathmash.github.io/HELM/24_3_special_fourier_trnsform_pairs-web/24_3_special_fourier_trnsform_pairs-webse5.html)

$u(t)=\mathbb{1}[t>0]=\begin{cases}
1 & t>0\\
0 & t<0\\
\end{cases}$
and the value for $u(0)$ can be selected as $0,1$ or $\frac{1}{2}$.

The Fourier integral does not converge for $u(t)$,
the Cauchy principal value of $u(t)$ diverges too.  
We have to derive the CTFT for $u(t)$ through other ways.

Let $f(t) = 2u(t)-1=\begin{cases}
1  & t>0\\
-1 & t<0\\
\end{cases}$
and $u(t)=\frac{1}{2}\left[ f(t)+1 \right]$
i.e. the Odd-Even components of $u(t)$.

This time, the P.V. of $f(t)$ is zero, which is finite
but the Fourier integral still does not converge.

Consider $f_\sigma(t) = \begin{cases}
e^{-\sigma t}   & t>0\\
-e^{\sigma t} & t<0\\
\end{cases}$ for $\sigma > 0$, the two-sided odd exponential signal.  
We have $f(t)=\lim\limits_{\sigma\to 0^{+}}f_\sigma(t)$ point-wisely,
we hope that $\mathcal{F}\{f_\sigma\} \to \mathcal{F}\{f\}$.  
(**Recall:**
that is the way we derive Laplace Transform from the Fourier Transform,
multiply the time-domain function by a real decaying exponential $e^{-\sigma t}$ for $\sigma>0$)

$$
\begin{aligned}
\mathcal{F}\{f_\sigma(t)\}(\omega)
&= \int_0^{+\infty} e^{-(\sigma+j\omega)t}\mathrm{d}t
  -\int_{-\infty}^0 e^{-(-\sigma+j\omega)t}\mathrm{d}t\\
&=\frac{1}{\sigma+j\omega} + \frac{1}{\sigma-j\omega}\\
&=\frac{-2j\omega}{\sigma^2+\omega^2}
\end{aligned}
$$

Let's define $\mathcal{F}\{f\}=\mathcal{F}\{f_\sigma\}$ as $\sigma\to 0^{+}$.
Thus, $\mathcal{F}\{f\}(\omega) = \frac{2}{j\omega}$

Thus

$$
\mathcal{F}\{u(t)\}
=\mathcal{F}\left\{ \frac{1}{2}(f(t)+1) \right\}
=\frac{1}{2}\cdot \frac{2}{j\omega} + \frac{1}{2}\cdot 2\pi\delta(\omega)
=\frac{1}{j\omega} + \pi \delta(\omega)
$$

Application: Suppose that the Fourier transform of $f(t)$ is $F(\omega)$ then

$$
\mathcal{F}\left\{
	\int_{-\infty}^t f(t)\mathrm{d}t
\right\}
=\mathcal{F}\left\{ f(t) \ast u(t) \right\}
=F(\omega) \left[\frac{1}{j\omega}+\pi \delta(\omega)\right]
=\frac{1}{j\omega} F(\omega) + \pi F(0)\delta(\omega)
$$

**Caveat:** The (unilateral) Laplace transform of $u(t)$ exists.

$$
\mathcal{L}\{u(t)\}(s)
=\int_0^{+\infty} u(t) e^{-st}\mathrm{d} t
=\int_0^{+\infty} e^{-st}\mathrm{d} t
=\frac{1}{s}
$$

For $\mathrm{Re}(s)>0$  
The ROC means that we can not have $\mathcal{F}\{u(t)\}(\omega)=\mathcal{L}\{u(t)\}(0+j\omega)$.  

### The `window` function and the `sinc` function

The `Sa` and `sinc` are used in sampling and reconstruction,
they are defined as follows:

- (normalized) `sinc`: $\operatorname{sinc}(x) = \frac{\sin \pi x}{\pi x}$
- sampling function `Sa`: $S_a(x) = \frac{\sin x}{x}$

Consider a time-domain window
$[|t|<T]=\begin{cases}
1&|t| < T\\
0&\text{otherwise}\\
\end{cases}$.  
The spectrum of this signal is:

$$
\begin{aligned}
X(j\omega)
&=\int_{-T}^{+T} e^{-j\omega t}\mathrm{d}t
={\left.\left( \frac{e^{-j\omega t}}{-j\omega} \right)\right|}_{-T}^{+T}
=\frac{e^{-j\omega T}-e^{j\omega T}}{-j\omega}\\
&=\frac{2\sin(\omega T)}{\omega}
=2T S_a(\omega T)
=2T \operatorname{sinc}\left( \frac{\omega T}{\pi} \right)\\
\end{aligned}
$$

Conversely, consider a frequency-domain window $[|\omega|<W]$,
the corresponding time-domain signal is

$$
\begin{aligned}
x(t)
&= \frac{1}{2\pi} \int_{-W}^{+W} e^{j\omega t}\mathrm{d}\omega
= \frac{1}{2\pi} {\left.\left( \frac{e^{j\omega t}}{jt} \right)\right|}_{-W}^{+W}
= \frac{1}{2\pi} \frac{e^{jWt}-e^{-jWt}}{jt}\\
&= \frac{\sin (Wt)}{\pi t}
= \frac{W}{\pi}S_a(Wt)
= \frac{W}{\pi}\operatorname{sinc}\left(\frac{Wt}{\pi}\right)
\end{aligned}
$$

This can be used to construct ideal LPF (low pass filter).  
Let $x(t) = \frac{\sin (Wt)}{\pi t}$, if we convolve $x(t)$ with a signal $f(t)$,
the spectrum of $f(t)\ast x(t)$ is $[|\omega| < W] F(\omega)$
i.e. the low frequency part of $f(t)$.

Summary:

- For a time-domain unit window $x(t)=[|t|<T]$.  
  The spectrum is a frequency-domain `sinc` $\frac{2\sin(\omega T)}{\omega}$
- For a frequency-domain unit window $X(\omega)=[|\omega|<W]$.  
  The wave form is a time-domain `sinc` $\frac{\sin(Wt)}{\pi t}$

### Application: modulation and filtering

Refer to textbook/slides.

## Fourier Transform for Discrete-Time Aperiodic Signals

> also known as `DTFT`

For arbitrary discrete-time signal $x[n]$,
given a positive integer $N$, we can construct a period signal of period $N$:

$$y[n]=x[n \bmod N]$$

- For $n\in [-N,-1]$,   we have $y[n]=x[n+N]$
- For $n\in [0,N-1]$,   we have $y[n]=x[n]$
- For $n\in [N,2N-1]$,  we have $y[n]=x[n-N]$
- For $n\in [2N,3N-1]$, we have $y[n]=x[n-2N]$

We can find the discrete-time Fourier Series representation of $y[n]$.
Let $\omega_0 = \frac{2\pi}{N}$, then:

$$
y[n]=\sum_{k=<N>}a_k e^{j k\omega_0 n}
\qquad
a_k =\frac{1}{N}\sum_{n=<N>}x[n]e^{-j k\omega_0 n}
$$

We can define

$$
X(e^{j\omega})
=\sum_{n=<N>} x[n]{\left( e^{-j\omega} \right)}^n
=\sum_{n=<N>} x[n]e^{-j\omega n}
$$

Then

$$
y[n]
=\sum_{k=<N>}\frac{1}{N}X(e^{j k\omega_0}) e^{j k\omega_0 n}
=\sum_{k=<N>}\frac{\omega_0}{2\pi}X(e^{j k\omega_0}) e^{j k\omega_0 n}
=\frac{1}{2\pi}\sum_{k=<N>}X(e^{j k\omega_0}) e^{j k\omega_0 n} \omega_0
$$

As $N\to \infty$, we find that $y[n]\to x[n]$ and we have:

$$
x[n] = \frac{1}{2\pi} \int\limits_{<2\pi>} X(e^{j\omega}) e^{j\omega n}\mathrm{d}\omega
\qquad
X(e^{j\omega}) = \sum_{n=-\infty}^{+\infty} x[n] e^{-j\omega n}
$$

This is a discrete-time Fourier Transform
analysis and synthesis equations.

### Periodicity of DTFT

$$
X(e^{j (\omega + 2\pi)})
=\sum_{n=-\infty}^{+\infty} x[n]e^{j(\omega + 2\pi) n}
=\sum_{n=-\infty}^{+\infty} x[n]e^{j\omega n + (2\pi n) j}
=\sum_{n=-\infty}^{+\infty} x[n]e^{j\omega n}
=X(e^{j\omega})
$$

### DTFT for periodic signals

Consider the inverse DTFT of
$X(e^{j\omega}) = \sum_{n} 2 \pi\delta(\omega -\omega_0 - 2\pi n)$.  
**NOTE:** the $2\pi n$ terms are added to make $X(e^{j\omega})$ a periodic function.

$$
x[n]
=\frac{1}{2\pi} \int\limits_{<2\pi>} X(e^{j\omega}) e^{j\omega n}\mathrm{d}\omega
=\frac{2\pi}{2\pi}\int\limits_{<2\pi>} \delta(\omega-\omega_0) e^{j\omega n}\mathrm{d}\omega
=e^{j \omega_0 n}
$$

For a periodic signal $x[n]$ of period $N$ where $a_k$ is the FS coefficients,
we can define the DTFT of $x[n]$ to be

$$
X(e^{j\omega}) = 2\pi \sum_{k=-\infty}^{+\infty} a_k\delta(\omega - k\omega_0)
$$

$$
\frac{1}{2\pi}\int\limits_{<2\pi>}
\left(
	\sum_{k=-\infty}^{+\infty} 2\pi a_k \delta(\omega - k\omega_0)
\right)
\mathrm{d}\omega
=\sum_{k=<N>} a_k e^{j k\omega_0 n}
=x[n]
$$

where $\omega_0 = \frac{2\pi}{N}$ is the fundamental angular frequency.

### Convergence issue

If $\sum_n |x[n]| < \infty$ or $\sum_n {|x[n]|}^2 < \infty$, then the DTFT exists.  
The signal is absolutely summable or of finite energy.

### Properties of DTFT

### Duality of DTFT

### Discrete Fourier Transform: DFT

**_TODO_**


## MISC
