# Note: Signals and Systems 信号与系统

> - ShanghaiTech SIST EE150 Signals and Systems
> - MIT 6.003 Signal Processing
> - [MIT OCW 6.007 res: Signals and Systems lectures by Alan V. Oppenheim in 1987](https://ocw.mit.edu/resources/res-6-007-signals-and-systems-spring-2011/)  
> - UC Berkeley EE120: Signals and systems [EE120 Fall2019](https://inst.eecs.berkeley.edu/~ee120/fa19/)

## overview

### for a more rigorous mathematical approach

- [wikipedia: Hilbert Space](https://en.wikipedia.org/wiki/Hilbert_space).
  For functional inner product spaces.
- [wikipedia: Harmonic analysis](https://en.wikipedia.org/wiki/Harmonic_analysis).
  For generalized Fourier analysis.
- [wikipedia: Distribution](https://en.wikipedia.org/wiki/Distribution_(mathematics)).
  Also known as _generalized function_. The theory for singularity signals.
- [wikipedia: Fubini's Theorem](https://en.wikipedia.org/wiki/Fubini's_theorem) [wikipedia: Series](https://en.wikipedia.org/wiki/Series_(mathematics)) [wikipedia: Function Series](https://en.wikipedia.org/wiki/Function_series).
  The correctness of interchanging summation/integration/differentiation with summation/integration/differentiation.
- [wikipedia: Dirichlet Kernel](https://en.wikipedia.org/wiki/Dirichlet_kernel).
  For studying the convergence property of Fourier series/transform.
- Other mathematics textbook on Fourier Analysis, Complex Analysis, ODE and PDE.

### contents

> This introductory course only deals with signals of single variable and systems with single input/output.

- basis of signals and systems
  - definitions
  - time-domain transforms: delaying, scaling, reversal.
  - signals that serve as fundamental building blocks: sinusoidal signals, complex exponentials, unit impulse, unit step.
  - basic properties of systems: invertibility, memory/memoryless, causality, linearity, time-invariance
- time-domain: decomposition of signals and analysis of LTI systems
  - unit impulse and impulse response
  - convolution: $h[n]=\sum_{k} x[k]y[n-k]\quad h(x)=\int_{-\infty}^{+\infty} f(t)g(x-t)$
  - causality and BIBO stability of an LTI system via unit impulse response
  - interconnection of LTI systems
- frequency-domain: decomposition of signals and analysis of LTI systems
  - complex exponentials and frequency response(system function)
  - convolution theorem: $\mathcal{L}\{(f\ast g)(t)\}=\mathcal{L}\{f(t)\}\cdot \mathcal{L}\{g(t)\}\quad \mathcal{Z}\{(x\ast y) [n]\}=\mathcal{Z}\{x[n]\}\cdot \mathcal{Z}\{y[n]\}$
  - Laplace Transform (for continuous time) and Z Transform (for discrete time)
  - causality and BIBO stability of an LTI system via unit impulse response via ROC(region of convergence) of system function
  - FS(Fourier Series) of continuous time periodic signals
  - FT(Fourier Transform) of continuous time aperiodic signals
  - DTFS(Discrete-Time Fourier Series) for periodic discrete-time signals
  - DTFT(Discrete-Time Fourier Transform) for aperiodic discrete-time signals
  - DFT(Discrete Fourier Transform) for finite discrete-time sequences
- sampling theorem
  - Dirac comb function: frequency-domain comb and time-domain comb
  - amplitude modulation, convolution theorem for Fourier transform and its inverse
  - reconstructing band-limited signals from samples using $\mathrm{sinc} x=\frac{\sin x}{x}$ function
  - aliasing
- applications
  - solving linear differential/difference equation with Laplace/Z Transform.
  - filter designing
  - discrete-time filter for continuous-time signal processing
  - stabilizing a system with feedback

### skeleton/outline

#### the linear time-invariant systems

(Discrete time) LTI system $H:x[n] \to y[n]$ ($x$ is called input and $y$ is the response)

- linearity: response for linear combination of signals equals to the same linear combination of responses.  
  Suppose that $x_1[n]\to y_1[n],x_2[n]\to y_2[n]$ then $\forall a,b\quad a x_1[n]+b x_2[n]\to a y_1[n]+b y_2[n]$.  
- time-invariant: response for delayed signal is the delayed response.  
  Suppose that $x[n]\to y[n]$ then $\forall m\quad x[n-m]\to y[n-m]$

We can observe and verify that

- $x(t)\to y(t)$ where $y(t)=x(t-t_0)$
- $x(t)\to y(t)$ where $y(t)=\alpha x(t)$
- $x(t)\to y(t)$ where $y(t)=\int_{-\infty}^t x(\tau)\mathrm{d}\tau$
- $x(t)\to y(t)$ where $y(t)=\frac{\mathrm{d}}{\mathrm{d} t}x(t)$
- $x[n]\to y[n]$ where $y[n]=x[n-n_0]$
- $x[n]\to y[n]$ where $y[n]=\alpha x[n]$
- $x[n]\to y[n]$ where $y[n]=\sum_{k\leq n} x[k]$
- $x[n]\to y[n]$ where $y[n]=x[k]-x[k-1]$

are LTI systems.

#### time domain decomposition of signals and the convolution

For an LTI system $H$, define $\delta[n]\to h[n]$ to be the impulse response.  

For every signal $x[n]$, we can decompose it into a series of scaled delayed impulses.

$$
\begin{aligned}
x[k]\delta[n-k]
&=\begin{cases}
x[k] &(n = k)\\
0    &(n \neq k)\\
\end{cases}\\
x[n]
&=\sum_{k=-\infty}^{+\infty} x[k]\delta[n-k]
\end{aligned}
$$

Now let us consider the response for $x[n]$.  
Every component $x[k]\delta[n-k]$ is a scaled and delayed unit impulse.
By LTI property, the corresponding response is a scaled delayed impulse response $x[k]h[n-k]$.  
Thus, combining them together

$$
y[n]
=\sum_{k=-\infty}^{+\infty}x[k]h[n-k]
=\sum_{k=-\infty}^{+\infty}h[k]x[n-k]
$$

This is called the convolution sum $h*x=x*h$.

The properties of an LTI systems correspond to the properties of its impulse response.

- BIBO stability: absolutely summability of the impulse response
- causality: whether the impulse response half sided $\forall n<0 \quad h[n]=0$
- invertibility: $h*h^{-1}=\delta$

#### properties of convolution: parallel and serial(cascade) inter-connections of LTI systems

we can find some basic algebraic properties of the convolution operation

- associativity $(f*g)*h=f*(g*h)$  
- associativity with scalar multiplication $\alpha f*g=(\alpha f)*g$
- commutativity $f*g = g*f$
- distribution over addition $f*(g+h)=f*g+f*h$

these properties correspond to properties of LTI systems

- The serial/cascade inter-connection of two LTI systems is still an LTI system,
  where the impulse response of such system is the convolution of the impulse responses for the two systems.
- The serial/cascade inter-connection of two LTI systems is still an LTI system,
  where the impulse response of such system is the sum of the impulse responses for the two systems.
- If we combine a sequence of serial connected LTI systems together, we can re-order them arbitrarily and the result remains the same.

#### eigen-function of LTI systems: spectral decomposition

LTI systems are just linear operators.
Theories for spectrum developed in linear algebra can be applied in analysis of LTI systems.

Consider an LTI system $H$ whose unit impulse response is $h[n]$.  
The response of $x[n]=z^n$ is $y[n]$ where

$$
y[n]
=\sum_{k} h[k] z^{n-k}
=z^n \sum_{k} h[k] z^{-k}
$$

Define $H(z)=\mathcal{Z}\{h[n]\}=\sum_{k=-\infty}^{+\infty}h[k] z^{-k}$ to be the Z transform of $h[n]$,
we have $z^n\to H(z)z^n$.

Another key property of the Z transform is known as the convolution theorem:

$$
\mathcal{Z}\{ (h*x) [n] \} =\mathcal{Z}\{h[n]\}\mathcal{Z}\{x[n]\}
$$

Let $X(z),Y(z),H(z)$ be the Z transforms of $x[n],y[n],h[n]$ respectively,  
we can prove the convolution theorem in the following steps

$$
\begin{aligned}
Y(z)
&=\sum_{n} y[n] z^{-n}\\
&=\sum_{n} z^{-n}\sum_{k} x[k]y[n-k]\\
&=\sum_{n} \sum_{k} \left( x[k]z^{-k} \right) \left( y[n-k] z^{k-n} \right)\\
&=\left( \sum_{k} x[k]z^{-k} \right) \left( \sum_{i} y[i]z^{-i} \right)\\
&=H(z)X(z)
\end{aligned}
$$

The convolution theorem enables us to express LTI causality and BIBO stability in terms of the system function

- causality
- BIBO stability

The algebraic properties of Z transforms

Suppose that $X(z)=\mathcal{Z}\{x[n]\}, Y(z)=\mathcal{Z}\{y[n]\}$

- linearity: $ax[n]+by[n]\to aX(z)+bY(z)$
- time delay: for every integer $m$, $x[n-m]\to z^{-m}X(z)$
- time reversal: $x[-n]\to X(z^{-1})$
- scaling: for every complex number $a$, $a^n x[n]\to X(a^{-1} z)$
- conjugation: ${(re^{i\theta})}^{\ast}=re^{-i\theta}$ $x^{\ast}[n]\to X^{\ast}(z^{\ast})$
- differentiation: $nx[n]\to -z\frac{\mathrm{d}}{\mathrm{d} z}X(z)$

These properties allow us the analysis the interconnection of LTI systems using their system function.

Another helpful property is the Parseval Theorem, which helps to evaluate the inner product $\sum_{n} x[n]y^{\ast}[n]$

### continuous-time LTI system

For a continuous LTI system $H$ if
$\delta(t)\stackrel{H}{\to}h(t)$ then $x(t)\stackrel{H}{\to} h(t)\ast x(t)$.  
We can explore the properties of LTI system $H$ by studying its impulse reponse $h(t)$.  

The complex exponentials $x_s(t)=e^{st}$ for $s\in\mathbb{C}$ are the eigen-function of continuous-time LTI systems:

$$
e^{st}\to \int_{-\infty}^{+\infty} h(\tau)e^{s(t-\tau)} \mathrm{d}\tau
=e^{st}\int_{-\infty}^{+\infty}h(\tau) e^{-s\tau}\mathrm{d}\tau
$$

The function $H(s)=\int_{-\infty}^{+\infty} h(\tau) e^{-s\tau}\mathrm{d}\tau$ is called the system function or the transfer function
of LTI system $H$. $H(s)$ is the bilateral Laplace Transform of $h(t)$.

Here we also have the convolution theorem for continuous-time LTI system:

Suppose that $y=h\ast x$ and $X=\mathcal{L}\{h(t)\}, Y=\mathcal{L}\{y(t)\}, H=\mathcal{L}\{h(t)\}$

$$
\begin{aligned}
Y(s)
&=\int_{-\infty}^{+\infty} y(t) e^{-st}\mathrm{d}t\\
&=\int_{-\infty}^{+\infty} \left(
  \int_{-\infty}^{+\infty} h(\tau)x(t-\tau)\mathrm{d}\tau
\right) e^{-st}\mathrm{d}t\\
&=\int_{-\infty}^{+\infty} \left(
  \int_{-\infty}^{+\infty}
  h(\tau)   e^{-s\tau}
  \cdot
  x(t-\tau) e^{-s(t-\tau)}
  \mathrm{d}\tau
\right)
\mathrm{d}t\\
&=\int_{-\infty}^{+\infty}
h(\tau)e^{-s\tau}
\left(
  \int_{-\infty}^{+\infty}
  x(t-\tau)e^{-s(t-\tau)}\mathrm{d}t
\right)
\mathrm{d}\tau\\
&=\int_{-\infty}^{+\infty}
h(\tau)e^{-s\tau}
\left(
  \int_{-\infty}^{+\infty}
  x(t)e^{-st}\mathrm{d}t
\right)
\mathrm{d}\tau\\
&=\left(
  \int_{-\infty}^{+\infty}
  h(\tau)e^{-s\tau} \mathrm{d}\tau
\right) \left(
  \int_{-\infty}^{+\infty}
  x(t)e^{-st}\mathrm{d}t
\right)\\
&=H(s) X(s)
\end{aligned}
$$

#### the rest of the story

- power and energy signals
- differential equation and difference equation
- Fourier analysis for DT/CT periodic/aperiodic signals
- exploiting Laplace transform and Z transform
- Bilateral/Unilateral Laplace transform
- applications: sampling, feedback system

## notes, tricks, traps

### serial/cascade interconnection

Function composition is not commutative in general.  

$$
H_1: y(t)=2x(t)
\quad
H_2: y(t)=x^2(t)
$$

Then for $x(t)\to H_1\to H_2 \to y(t)$ we have $y(t)=4x^2(t)$
and for $x(t)\to H_2\to H_1 \to y(t)$ we have $y(t)=2x^2(t)$.

However, for LTI systems, serial connection is commutative since convolution is commutative.

### connection between discrete-time signal and continuous-time impulses train

For every discrete-time signal $x[n]$, we can create a continuous-time signal consists of scaled delayed impulses:

$$
x(t)=\sum_{n}x[n]\delta(t-nT)
$$

or $x[n]=x(nT)$

The Laplace transform of this continuous-time signal, as we expected, is the Z transform of original discrete-time signal.

$$
\begin{aligned}
\mathcal{L}\{x(t)\}(s)
&=\int_{-\infty}^{+\infty} x(t) e^{-s t}\mathrm{d} t
=\int_{-\infty}^{+\infty} e^{-s t}\sum_{n}x[n]\delta(t-nT) \mathrm{d} t\\
&=\sum_{n}x[n] \int_{-\infty}^{+\infty} e^{-st} \delta(t-nT) \mathrm{d} t
=\sum_{n} x[n] e^{-snT}\\
&=\mathcal{Z}\{x[n]\}(z) \mid_{z=e^{sT}}
\end{aligned}
$$

### osciilation of discrete complex exponentials

![ee150-complex-exponential-frequency](../static/EE150-note-discrete-exponential-frequency.png)

$x[n]=e^{j \omega n}=\cos(\omega n)+i\sin(\omega n)$ (note that $e^{j\omega n}=e^{j(\omega + 2\pi) n}$)

### Dirac comb and uniform sampling

> see [DSP stack exchange: sampling theorem and Dirac comb](https://dsp.stackexchange.com/questions/1409/sampling-theorem-and-dirac-comb#1444)

$$
\operatorname{comb}_T(t)=\sum_{n=-\infty}^{+\infty}\delta(t-nT)
$$

This is called the Dirac comb function which is used to study uniform sampling.

$$
x(t)\operatorname{comb}_T(t)
=\sum_{n=-\infty}^{+\infty}x(t)\delta(t-nT)
=\sum_{n=-\infty}^{+\infty}x(nT)\delta(t-nT)
$$

The Fourier transform of time-domain comb turns out to be a frequency-domain comb.

$$
\mathcal{F} \left\{ \sum_{n}\delta(t-nT) \right\}
=\frac{1}{T}\sum_{n}\delta(f-\frac{k}{T})
$$

Then we can apply convolution theorem to find the spectrum of the samples.

**TODO:** finish this section

### convolution and singularity signals

Properties of convolution

- commutative: $x\ast y = y\ast x$
- associative: $f\ast g\ast h =(f\ast g)\ast h = f\ast (g\ast h)$
- linearity: $(\alpha f)\ast g = \alpha (f\ast g)$ and $(f+g)\ast h=f\ast h+f\ast h$

We can verify that the following systems are LTI systems

- identity: $I:y(t)=x(t)$.  
  Impulse responses $h(t)=\delta(t)$
- differentiator: $D:y(t)=\frac{\mathrm{d}}{\mathrm{d} t}x(t)$.  
  Impulse responses $h(t)=\frac{\mathrm{d}}{\mathrm{d} t} \delta(t)$
- integrator: $D^{-1}:y(t)=\int_{-\infty}^{t}x(\tau)\mathrm{d}\tau$.  
  Impulse responses $h(t)=u(t)=[t\geq 0]$
- time-shifting operator: $S_T:y(t)=x(t-T)$.  
  Impulse responses $h(t)=\delta(t-T)$

Let $\delta,d,u,s_T$ be their impulse responses respectively.

- convolution, integration, differentiation, shifting can be re-arranged arbitrarily.
- $\frac{\mathrm{d}^k t}{\mathrm{d} t^k}(x\ast y)=d^k\ast (x\ast y)=(d^i \ast x)\ast (d^{k-i}\ast y)$
- $f\ast g = (d\ast f)\ast (i\ast g)$
- $s_A\ast s_B = s_{A+B}$
- $\delta \ast \delta =\delta$

### derivate of the Dirac delta function

$$
\begin{aligned}
\int_{-\infty}^{+\infty} f(x)\left( \frac{\mathrm{d}}{\mathrm{d} x}\delta(x) \right)\mathrm{d}x
&=\int_{-\infty}^{+\infty} f(x) \mathrm{d} \delta(x)\\
&=f(x)\delta(x)\mid_{-\infty}^{+\infty}-\int_{-\infty}^{+\infty} f'(x) \delta(x) \mathrm{d} x\\
&= -f'(0)\delta(x)
\end{aligned}
$$

integrate by parts
