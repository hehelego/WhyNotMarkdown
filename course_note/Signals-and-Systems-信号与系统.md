# Note on: Signals and Systems 信号与系统

> - ShanghaiTech SIST EE150 Signals and Systems
> - MIT 6.003 Signal Processing
> - [MIT OCW 6.007 res: Signals and Systems lectures by Alan V. Oppenheim in 1987](https://ocw.mit.edu/resources/res-6-007-signals-and-systems-spring-2011/)  
> - UC Berkeley EE120: Signals and systems [EE120 Fall2019](https://inst.eecs.berkeley.edu/~ee120/fa19/)

## overview

### for a more rigorous mathematical approach

- [wikipedia: Fubini's Theorem](https://en.wikipedia.org/wiki/Fubini's_theorem) [wikipedia: Series](https://en.wikipedia.org/wiki/Series_(mathematics)) [wikipedia: Function Series](https://en.wikipedia.org/wiki/Function_series).
  The correctness of interchanging summation/integration/differentiation with summation/integration/differentiation.
- [wikipedia: Distribution](https://en.wikipedia.org/wiki/Distribution_(mathematics)).
  Also known as _generalized function_. The theory for singularity signals.
- [wikipedia: Dirichlet Kernel](https://en.wikipedia.org/wiki/Dirichlet_kernel).
  For studying the convergence property of Fourier series/transform.

mathematics textbook on Fourier Analysis, Complex Analysis, ODE, PDE

### contents

> This introductory course only deals with signals of single variable and systems with single input/output.

- basis of signals and systems
  - definitions
  - time-domain transforms: delaying, scaling, reversal.
  - signals that serves as fundamental building blocks: sinusoidal signals, complex exponentials, unit impulse, unit step.
  - basic properties of systems: invertibility, memory/memoryless, causality, linearity, time-invariance
- time-domain: decomposition of signals and analysis of LTI systems
  - unit impulse and impulse response
  - convolution: $h[n]=\sum_{k} x[k]y[n-k]\quad h(x)=\int_{-\infty}^{+\infty} f(t)g(x-t)$
  - causality and BIBO stability of a LTI system via unit impulse response
  - interconnection of LTI systems
- frequency-domain: decomposition of signals and analysis of LTI systems
  - complex exponentials and frequency response(system function)
  - convolution theorem: $\mathcal{L}\{(f\ast g)(t)\}=\mathcal{L}\{f(t)\}\cdot \mathcal{L}\{g(t)\}\quad \mathcal{Z}\{(x\ast y) [n]\}=\mathcal{Z}\{x[n]\}\cdot \mathcal{Z}\{y[n]\}$
  - Laplace Transform (for continuous time) and Z Transform (for discrete time)
  - causality and BIBO stability of a LTI system via unit impulse response via ROC(region of convergence) of system function
  - FS(Fourier Series) of continuous time periodic signals
  - FT(Fourier Transform) of continuous time aperiodic signals
  - DTFT(Discrete-Time Fourier Transform) for discrete-time signals
  - DFT(Discrete Fourier Transform) for finite discrete-time sequences
- sampling theorem
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

- $x(t)\to y(t)$ where $y(t)=\int_{-\infty}^t x(\tau)\mathrm{d}\tau$
- $x(t)\to y(t)$ where $y(t)=\frac{\mathrm{d}}{\mathrm{d} t}x(t)$
- $x[n]\to y[n]$ where $y[n]=\sum_{k\leq n} x[k]$
- $x[n]\to y[n]$ where $y[n]=x[k]-x[k-1]$

are LTI systems.

#### time domain decomposition of signals and the convolution

For a LTI system $H$, define $\delta[n]\to h[n]$ to be the impulse response.  

For every signals $x[n]$, we can decompose it into a series of scaled delayed impulses.

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

The properties of a LTI systems correspond to the properties of its impulse response.

- BIBO stability: absolutely summability of the impulse response
- causality: whether the impulse response half sided $\forall n<0 \quad h[n]=0$
- invertibility: $h*h^{-1}=\delta\iff \delta[n]=\sum_{k}$

#### properties of convolution: parallel,serial(cascade) inter-connections of LTI systems

we can find some basic algebraic properties of the convolution operation

- associativity $(f*g)*h=f*(g*h)$  
- associativity with scalar multiplication $\alpha f*g=(\alpha f)*g$
- commutativity $f*g = g*f$
- distribution over addition $f*(g+h)=f*g+f*h$

these properties corresponds to properties of LTI systems

- The serial/cascade inter-connection of two LTI systems is still a LTI system,
  where the impulse response of such system is the convolution of the impulse responses for the two systems.
- The serial/cascade inter-connection of two LTI systems is still a LTI system,
  where the impulse response of such system is the sum of the impulse responses for the two systems.
- If we combine a sequence of serial connected LTI systems together, we can re-order them arbitrarily and the result remains the same.

#### eigen-function of LTI systems: spectral decomposition

LTI systems are just linear operators.
Theories for spectrum developed in linear algebra can be applied in analysis of LTI systems.

Consider a LTI system $H$ whose unit impulse response is $h[n]$.  
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

The algebraic properties of Z transforms

Suppose that $X(z)=\mathcal{Z}\{x[n]\}, Y(z)=\mathcal{Z}\{y[n]\}$

- linearity: $ax[n]+by[n]\to aX(z)+bY(z)$
- time delay: for every integer $m$, $x[n-m]\to z^{-m}X(z)$
- time reversal: $x[-n]\to X(z^{-1})$
- scaling: for every complex number $a$, $a^n x[n]\to X(a^{-1} z)$
- conjugation: ${(re^{i\theta})}^{\ast}=re^{-i\theta}$ $x^{\ast}[n]\to X^{\ast}(z^{\ast})$
- differentiation: $nx[n]\to -z\frac{\mathrm{d}}{\mathrm{d} z}X(z)$

Another helpful property is the Parseval Theorem, which helps to evaluate the inner product $\sum_{n} x[n]y^{\ast}[n]$

#### TODO: the rest of the story

## notes, tricks, traps

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
