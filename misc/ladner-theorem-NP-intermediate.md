# Ladner's theorem and NP-intermediate problems

> reference: [lecture slides from Cornell CS6810](https://www.cs.cornell.edu/courses/cs6810/2021fa/lec4.pdf)

Recall that

- $\mathbf{P}$ is the languages of all decison problems that deterministic Turing machine can solved in polynomial time.
- $\mathbf{NP}$ is the languages of all decison problems that non-deterministic Turing machine can solved in polynomial time.
- $\mathbf{NP}$ is the languages of all decision problems $L$ that exists a deterministic Turing machine $V$, YES instances of $L$ have certificates $C$ that $V(L,C)$ runs in polynomial (of $|L|$) time.
- $\mathbf{P}\subseteq \mathbf{NP}$
- $\operatorname{\mathbf{NP}-complete}$: the decision problems $C$ such that every $\mathbf{NP}$ problem $L$ can be polynomial time reduced to $C$ ($C\in\mathbf{NP} \land \forall L . (L\in\mathbf{NP}\to L\leq C)$)

If $\mathbf{P}=\mathbf{NP}$, then every language in $\mathbf{NP}$ is also $\operatorname{\mathbf{NP}-complete}$.  
Ladner's theorem states that if $\mathbf{P}\neq\mathbf{NP}$, then there are intermediate languages that are not in $\mathbf{P}$ nor in $\operatorname{\mathbf{NP}-complete}$.  

## Padding languages

**NOTE**: we can actually use any $\mathbf{NPC}$ problem to phrase the argument.

Let $\operatorname{SAT} = \{\langle\psi\rangle \mid \text{the propositional logic formula is satisfiable}\}$.
For every function $H:\mathbb{N}\to\mathbb{N}$, we can construct the following padded language:

$$
\operatorname{SAT}_H = \{\langle\psi, 1^{n^{H(n)}}\rangle \mid \langle\psi\rangle\in\operatorname{SAT},n=|\langle\psi\rangle|\}
$$

The complexity is characterized as a function of the _input lengt/h_,
so the padding language is a relaxed version of the original language.
Finish in $n^k$ steps (original constraint) versus finish in ${(n+n^{H(n)})}^k$ steps (relaxed constraint).

Observations:

- The faster $H(n)$ grows, the easier the problem $\operatorname{SAT}_H$
- If $H(n) = \mathcal{O}(1)$ then $\operatorname{SAT}_H\in\mathbf{NPC}$
- If $H(n) = \Omega( \log n )$ then $\operatorname{SAT}_H\in\mathbf{P}$
- If $H_1(n) = \mathcal{O}( H_2(n) )$ and $\operatorname{SAT}_{H_2}\leq_p\operatorname{SAT}_{H_1}$
    - If $H_1(n) = \mathcal{O}( H_2(n) )$ and $\operatorname{SAT}_{H_2}\in\mathbf{NPC}$ then $\operatorname{SAT}_{H_1}\in\mathbf{NPC}$
    - If $H_1(n) = \mathcal{O}( H_2(n) )$ and $\operatorname{SAT}_{H_1}\in\mathbf{P}$ then $\operatorname{SAT}_{H_2}\in\mathbf{P}$

## Drawing the line between P and NPC

From now on, assume $\mathbf{P}\neq\mathbf{NP}$, which implies $\mathbf{P}\cap\mathbf{NPC}=\emptyset$.

Consider the following function $H^\ast(n)$:
The smallest $i$ where $i\leq\log\log n$ such that, exists a deterministic Turing machine $M_i$ that for every $x\in {\{0,1\}}^\ast$ and $|x|\leq \log n$, $M_i(x)$ halts in ${|x|}^i$ steps and output 1 iff $x\in\operatorname{SAT}_{H^\ast(n)}$.
If no such Turing maching $M_i$ exists, define $H^\ast(n)=\log\log n$.

$H^\ast(n)$ is defined in terms of $\operatorname{SAT}_{H^\ast(n)}\cap \{x\in {\{0,1\}}^n\mid n\leq \log n\}$, which involves only $H^\ast(m)$ for $m\leq \log n < n$. so $H^\ast(n)$ is well-defined.

Now we take a closer look on $\operatorname{SAT}_{H^\ast(n)}$.

### Condition for the padded language to be esay

$$
\operatorname{SAT}_{H^\ast}\in\mathbf{P}
\iff
H(n)=\mathcal{O}(1)
$$

If $\operatorname{SAT}_{H^\ast}\in \mathbf{P}$, then there is a deterministic Turing machine $M$ that decides the language in $n^c$ steps for some $c\in\mathbb{N}$.
Thus, for every $n$ such that $c\leq \log\log n$, $H^\ast(n)\leq c$ so $H^\ast \in \mathcal{O}(1)$.

Conversely, if $H^\ast(n)$ is bounded by $c\in\mathbb{N}$, a deterministic Turing decider for $\operatorname{SAT}_{H^\ast}$ runs in $\mathcal{O}(n^c)$ can be found.
For every $k\leq c$, let $N_k=\{n\in\mathbb{N}\mid H^\ast(n)=k\}$, then $(N_0,N_1,\ldots N_c)$ is a disjoint partition of $\mathbb{N}$.
By pigeonhole principle, there at least one of $(N_0,N_1,\ldots N_c)$ is a countable infinite set (otherwise, their union cannot be the natural number set, which is infinite). Suppose that $N_r$ is infinite, that is, $H^\ast(n)=r$ for infinitely many $n$.  
The Turing machine $M_r$ is a polynomial time decider for $\operatorname{SAT}_{H^\ast}$:
For every $x\in {\{0,1\}}^\ast$, there exists $n$ such that $\log n\geq |x|$ and $H^\ast(n)=r$.
According to the definition of $H^\ast(\cdot)$, $M_r(x)$ should halt in ${|x|}^r$ and decide whether $x\in\operatorname{SAT}_{H^\ast}$ or not.

### The padded language cannot be easy

Suppose that $\operatorname{SAT}_{H^\ast}\in\mathbf{P}$, then $H^\ast(n)=\mathcal{O}(1)$.
The padding $x\mapsto \langle x,1^{n^{H^\ast(n)}}\rangle$ where $|x|=n$ can be constructed in polynomial (of $|x|$) time,
providing a polynomial time reduction from $\operatorname{SAT}$ to $\operatorname{SAT}_{H^\ast}$.

$$
\operatorname{SAT}
\leq_p
\operatorname{SAT}_{H^\ast}
\implies
\operatorname{SAT}_{H^\ast}\in\mathbf{NPC}
$$

This cannot be true if $\mathbf{P}\neq\mathbf{NP}$.

### The padded language cannot be too hard

Suppose that $\operatorname{SAT}_{H^\ast}\in\mathbf{NPC}$.
Now $\operatorname{SAT}_{H^\ast}\notin\mathbf{P}$, $H^\ast(n)$ must be unbounded.

By definition of $\mathbf{NP}$ completeness,

$$
\operatorname{SAT}
\leq_p
\operatorname{SAT}_{H^\ast}
$$

There exists a polynomial time computable function $f$ and $c\in\mathbb{N}$, 

$$
\langle x\rangle\in\operatorname{SAT}\iff \langle y,1^{m^{H^\ast(m)}}\rangle=f(x)\in\operatorname{SAT}_{H^\ast}
$$


where $n=|x|,m=|y|$, and $m+m^{H^\ast(m)}\leq n^c$.

$H^\ast(n)$ is unbounded, so $m^{H^\ast(m)}$ grows faster than polynomial functions.
We should have $\lim_{n\to\infty} m/n=0$, otherwise LHS will grow faster than RHS.

Recall that $\langle y,1^{m^{H^\ast(m)}}\rangle\in\operatorname{SAT}_{H^\ast}\implies \langle y\rangle\in\operatorname{SAT}$.
The mapping reduction $f$ actually shrinks the formula to be tested ($x\mapsto y$).
Applying $f$ on the formula $y$ again, will reduce the formula further.

1. $m+m^{H^\ast(m)} \leq n^c$
2. $m_1+m_1^{H^\ast(m_1)} \leq m^c$
3. $m_2+m_2^{H^\ast(m_2)} \leq m_1^c$
4. And so on.

The formula size shrinks (at least) expoentially.
This gives rise to a polynomial algorithm for solving $\operatorname{SAT}$:

1. Read a formula $\langle x\rangle$.
2. Let $n = |\langle x\rangle|$
3. Use $f$ to reduce the formula $\langle x\rangle\mapsto \langle y,1^{m^{H^\ast(m)}}\rangle$ where $m=|y|$.
4. If $\frac{m}{n}<\frac{1}{2}$, let $x\gets y$ and go back to step 2.
5. After $\mathcal{O}(\log n)$ times reduction, a formula $x^\ast$ of length constant size will be found.
6. Determine satisfiability of $x^\ast$ with brute force algorithm.

(If the output of $f$ does not conform to the padded formula format, we also reject.)

$$
\operatorname{SAT}_{H^\ast}\in\mathbf{NPC}\implies\operatorname{SAT}\in\mathbf{P}
$$

This cannot be true as $\operatorname{SAT}\in\mathbf{NPC}$.

## Conclusion

We present Ladner's theorem and its constructive proof, where
a diagnolization alike construction gives a language that is not in $\mathbf{P}$ nor $\mathbf{NPC}$.
In the construction, a mysterious paradox is identified

- Reduction by removing padding: If $H_1(n) = \mathcal{O}( H_2(n) )$ and $\operatorname{SAT}_{H_2}\leq_p\operatorname{SAT}_{H_1}$. That is, the faster $H$ grows, the easier the language $\operatorname{SAT}_H$.
- Reduction by transforming the formula and add padding: If $H^\ast(n)$ is ever growing, then
