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

- $|e^{j\omega t}|\equiv 1$
- $|e^{j\omega n}|\equiv 1$

Considering that $|\int f(t)e^{j\omega t}|\mathrm{d}t\leq \int |f(t)| |e^{j\omega t}|\mathrm{d}t\leq \int |f(t)|$
we find that the Fourier Series and Fourier Transform always exists for absolutely integrable functions,
which makes the problem easier.

## orthogonal and normal basis property

Let $S_{T}=\{f\in L^2[-T/2,T/2] \mid f(t)=f(t+T)\}$ be the space of square integrable signals with period $T$.  
Define an inner product on $S_{T}$:

$$
\left<f,g\right>=\frac{1}{T}\int_{-T/2}^{+T/2} f(t)g^{\ast}(t)\mathrm{d} t
$$

We can verify that this is an inner product

- $\left<f,g\right>={\left(\left<g,f\right>\right)}^{\ast}$
- $\left<f+g,h\right> = \left<f,h\right> + \left<g,h\right>$
- $\left<\alpha f,h\right> = \alpha \left<f,g\right>$
- $\left<f,f\right> \geq 0$ (we have an equal sign only when $f\equiv 0$ nearly everywhere)

Then $\{e^{j k \omega t}\mid k\in \mathbb{Z}\}$ is an orthonormal basis, where $\frac{2\pi}{\omega}=T$.

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

(which is known as the Parseval's identity)

Let $a_k,b_k$ be the FS of $f,g$ then

$$
\left< f,g \right>
=\frac{1}{4}\left(
\left<f+g,f+g\right> - \left<f-g,f-g\right>
\right)
=\sum_{k} a_k b_k^\ast
$$

### convergence issue for CTFS

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

### properties of CTFS

Suppose that $\mathrm{FS}\{x(t)\}=a_k$ and $\mathrm{FS}\{y(t)\}=b_k$,
where $x(t),y(t)$ have period $T_0$ and $\omega_0 = \frac{2\pi}{T}$.

- linearity: $\mathrm{FS}\{\alpha x(t) + \beta y(t)\} = \alpha a_k+\beta b_k$
- convolution sum theorem: $\mathrm{FS}\{x(t)y(t)\}=(a\ast b) [k]$
- periodic convolution integral theorem: $\mathrm{FS}\{(x\ast y)(t)\}=T a_k b_k$  
  where $(x\ast y)(t)=\int_{0}^{T} x(\tau)y(t-\tau)\mathrm{d}\tau$ is the periodic convolution integral.
- $\mathrm{FS}\left\{ \sum_{n} \delta(t-nT) \right\} = \frac{1}{T}$: the Dirac comb
- $\mathrm{FS}\left\{ \sum_{n} \delta(t-t_0-nT) \right\} = \frac{1}{T} e^{-jk\omega_0 t_0}$: time-shift
- $\mathrm{FS}\{x(t-t_0)\}=e^{-jk\omega_0 t_0}a_k$
- time reversal: $\mathrm{FS}\{x(-t)\}=a_{-k}$
- time scaling: $x(\alpha t)=\sum_{k} a_k e^{jk\omega_0 (\alpha t)}$
- conjugation: $\mathrm{FS}\{x^\ast(t)\}=a_{-k}^\ast$
- derivative: $\mathrm{FS}\{\frac{\mathrm{d}}{\mathrm{d} t}x(t)\}=(jk\omega_0) a_k$.
- integral: $\mathrm{FS}\{\int_{-\infty}^{t} x(\tau)\mathrm{d}\tau\}=\frac{a_k}{jk\omega_0}$
- **note:** special case for $a_0$ in differential and integration

## Fourier Series for Discrete-Time Periodic Signals: DTFS

### orthonormal basis of signals with a fixed period

Let $S_N=\{x[n]:\mathbb{Z}\to \mathbb{C}\mid \forall n\in \mathbb{Z}\ x[n+N]=x[n]\}$ be the discrete-time signals with period $N$.  
We define the inner product on $S_N$ to be

$$
\left<x[n],y[n]\right>
=\frac{1}{N}\sum_{n=0}^{N-1}x[n]y^{\ast}[n]
$$

We can verify that this operator is an inner product.

Now let us consider the set
$\{ x_k[n]=e^{j k \omega_0 n}\mid k\in \mathbb{Z} \}$
where $\omega_0 = \frac{2\pi}{N}$  
(Notice that $x_{k+N}[n]=e^{j (k+N) \omega_0 n}=e^{j k\omega_0 n} e^{j(2\pi) n}=x_{k}[n]$.
Thus, the set can be simplified to $\{ x_k[n]=e^{j k \omega_0 n}\mid k=0,1,2\ldots N-1 \}$
reminder: $[0,2\pi]$ close to $\pi$ high frequency, close to $0$ or $2\pi$ low frequency.)

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

Thus, the set of exponentials with period $N$ forms an orthonormal set.  
Furthermore, we can show that this is a complete basis.

### extracting the coefficients

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
=\left<x[n],e^{j(m\omega) n}\right>
=\frac{1}{N}\sum_{k=0}^{N-1} x[k] e^{-j(m\omega) k}
$$

### convergence issue for DTFS

The DTFS for periodic signal is guaranteed to exist
and always converges to the original signal.

### properties of DTFS

Suppose that $x[n],y[n]$ are discrete-time signals with periodic $N$, let $\omega =\frac{2\pi}{N}$.  
Let $a_k,b_k$ be the FS of $x[n],y[n]$ respectively.

- linearity
- time-shift
- convolution theorem
- Parseval: $\left<x[n],y[n]\right>=\sum_{k=0}^{N-1} a_k b_k^{\ast}$

## Fourier Transform for Continuous-Time Aperiodic Signals: CTFT

### periodic replication of an aperiodic signal: CTFS to CTFT

Given an aperiodic signal $x(t)$ and a positive real number $T$,
we can define $y(t)$ to be

$$
y(t)=
\begin{cases}
x(t)           & |t|<T/2\\
x(t\bmod T)    & |t|>T/2\\
\end{cases}
$$

- on $t\in [-T/2,T/2]$, we have $y(t)=x(t)$
- on $t\in [T/2,3T/2]$, we have $y(t)=x(t-T)$
- on $t\in [-3T/2,-T/2]$, we have $y(t)=x(t+T)$

Now consider the Fourier Series of $y(t)$, let $\omega_0=\frac{2\pi}{T}$

$$
a_k
=\frac{1}{T}\int_{-T/2}^{T/2} x(t)e^{-jk\omega_0 t}\mathrm{d}t
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

### another integrable function space and orthonormal complete basis

Let $S=\{f:\mathbb{R}\to \mathbb{C}\mid \int_{-\infty}^{+\infty} |f| < \infty\}$.  
Define an inner product on $S$ as $\left<f,g\right>=\lim_{T\to +\infty} \frac{1}{T}\int_{-T/2}^{T/2} f(t)g^\ast(t)\mathrm{d} t$.
Then $\{e^{j\omega t}\mid \omega \in \mathbb{R}\}$ is an orthonormal basis.

When $\omega_0\neq \omega_1$, we have

$$
\begin{aligned}
\left<e^{j\omega_0 t},e^{j\omega_1 t}\right>
&=\lim_{T\to +\infty} \frac{1}{T}\int_{-T/2}^{T/2} e^{j(\omega_0-\omega_1) t}\mathrm{d}t\\
&=\lim_{T\to +\infty} \frac{1}{T}\frac{e^{j\omega T/2}-e^{-j\omega T/2}}{j\omega} \quad (\text{where}\ \omega=\omega_0-\omega_1)\\
&=\lim_{T\to +\infty} \frac{1}{T}\frac{2j\, \sin(j\omega T/2)}{j\omega}=0
\end{aligned}
$$

and

$$
\left<e^{j\omega t},e^{j\omega t}\right>
=\lim_{T\to +\infty} \frac{1}{T}\int_{-T/2}^{T/2}e^{j\omega t}e^{-j\omega t} \mathrm{d}t
=\lim_{T\to +\infty} \frac{1}{T}\int_{-T/2}^{T/2}1\mathrm{d}t=1
$$

### properties of CTFT

Consider a square signal $w_T(t)=u(t+T)-u(t-T)
=\begin{cases}
1&|t| < T\\
0&\text{otherwise}\\
\end{cases}$

$$
\begin{aligned}
X(j\omega)
&=\int_{-\infty}^{+\infty} x(t) e^{-j\omega t}\mathrm{d}t
=\int_{-T}^{+T} e^{-j\omega t}\mathrm{d}t\\
&={\left.\left( \frac{e^{-j\omega t}}{-j\omega} \right)\right|}_{-T}^{+T}
=\frac{e^{-j\omega T}-e^{j\omega T}}{-j\omega}\\
&=\frac{2\sin(\omega T)}{\omega}
=2T\, \frac{\sin(\omega T)}{\omega T}
=2T\, \operatorname{sinc}(\omega T/\pi)
\end{aligned}
$$

Where $\operatorname{sinc}(x) = \frac{\sin (\pi x)}{(\pi x)}$

The theory of Fourier Transform can be also derived from these basic properties.

### duality of CTFT

$$
\begin{aligned}
X(\omega)
&=\mathcal{F}\{x(t)\}(\omega)\\
\mathcal{F}\{X(t)\}(\omega)
&=2\pi x(-\omega)
\end{aligned}
$$

Proof:

$$
\begin{aligned}
x(t)
&=\frac{1}{2\pi} \int_{-\infty}^{+\infty} X(\omega) e^{j\omega t}\mathrm{d}\omega\\
2\pi x(-t)
&=\int_{-\infty}^{+\infty} X(\omega) e^{j\omega (-t)}\mathrm{d}\omega
=\int_{-\infty}^{+\infty} X(\omega) e^{-j\omega t}\mathrm{d}\omega\\
&=\mathcal{F}\{X(\omega)\}(t)\\
2\pi x(-\omega)
&=\mathcal{F}\{X(t)\}(\omega)\\
\end{aligned}
$$

## Fourier Transform for Discrete-Time Aperiodic Signals: DTFT

**_TODO_**

## Discrete Fourier Transform: DFT

**_TODO_**

## (Continuous-Time) Fourier Transform for Periodic Signals

Notice that the inverse Fourier Transform of $2\pi \delta(\omega - \omega_0)$ is

$$
\frac{1}{2\pi}\int_{-\infty}^{+\infty} 2\pi \delta(\omega-\omega_0) e^{j\omega t} \mathrm{d}\omega
=\int_{-\infty}^{+\infty} \delta(\omega-\omega_0) e^{j\omega t} \mathrm{d}\omega
=e^{j\omega_0 t}
$$

Suppose that $x(t)$ has period $T_0$, and $x(t)=\sum_{k} a_k e^{jk\omega_0 t}$
where $\omega_0 = \frac{2\pi}{T}$.

$$
a_k = \frac{1}{T_0}\int_{<T_0>} x(t)e^{-jk\omega_0 t}\mathrm{d}t
\quad
x(t)=\sum_{k} a_k e^{j k \omega_0 t}
$$

We can define the Fourier Transform of $x(t)$ as

$$
X(\omega) = 2\pi \sum_{k} a_k\delta(\omega-k\omega_0)
$$

We can verify that

$$
\frac{1}{2\pi}\int_{-\infty}^{+\infty} X(\omega_0) e^{j\omega t}\mathrm{d}\omega
=\sum_{k} a_k \int_{-\infty}^{+\infty} \delta(\omega-k\omega_0)e^{j\omega t}\mathrm{d}\omega
=\sum_{k} a_k e^{j k\omega_0 t}
$$

### example: Fourier Transform of the Dirac comb

Consider the Dirac comb function

$$
\mathrm{Comb}_T(t)=\sum_{n=-\infty}^{+\infty}\delta(t-nT)
$$

Let $\omega_0 = \frac{2\pi}{T}$ be the fundamental angle frequency.  
The Fourier Series of $\mathrm{Comb}_T$ can be computed as

$$
\begin{aligned}
a_k
&=\frac{1}{T}\int_{-T/2}^{+T/2} \mathrm{Comb}_T(t)e^{-jk\omega_0 t}\mathrm{d}t\\
&=\frac{1}{T}\int_{-T/2}^{+T/2} \delta(t)e^{-jk\omega_0 t}\mathrm{d}t\\
&=\frac{1}{T}
\end{aligned}
$$

So the Fourier Transform of the Dirac Comb is

$$
\mathcal{F}\{ \mathrm{Comb}_T(t) \}(\omega)
=\frac{2\pi}{T} \sum_{n}\delta(\omega-k\omega_0)
=\omega_0 \mathrm{Comb}_{\omega_0}(\omega)
$$

## MISC

### Fourier Transform of the Heaviside unit step function

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
\end{cases}$ for $\sigma > 0$.  
We have $f(t)=\lim_{\sigma\to 0^{+}}f_\sigma(t)$ point-wisely,
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

$$
\mathcal{F}\{f\}(\omega) = \frac{-2j}{\omega} = \frac{2}{j\omega}
$$

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
=\mathcal{F}\{f(t)\} \cdot \mathcal{F}\{u(t)\}
=\left[\frac{1}{j\omega}+\pi \delta(\omega)\right] F(\omega)
$$

That is $\frac{F(\omega)}{j\omega} + \pi \delta(\omega)F(0)$

#### note on the Heaviside function

The Laplace transform of $u(t)$ exists for $\mathfrak{Re}(s)>0$

$$
\mathcal{L}\{u(t)\}(s)
=\int_0^{+\infty} u(t) e^{-st}\mathrm{d} t
=\int_0^{+\infty} e^{-st}\mathrm{d} t
=\frac{1}{s}
$$

The ROC means that we can not have $\mathcal{F}\{u(t)\}(\omega)=\mathcal{L}\{u(t)\}(0+j\omega)$.
