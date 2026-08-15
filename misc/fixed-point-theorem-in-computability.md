# fixed point theorems in the theory of computability

## In Turing machine

Preliminaries:

- There is a computable function $w \mapsto P_w$ which is a Turing machine that writes $w$ before any input, and halts.
- $S^m_n$ theorem: Given a Turing $t(\cdot,\cdot)$ and $w \in \Sigma^\ast$, we can construct a Turing machine $t_w(\cdot) = t(w,\cdot)$.
- Universal Turing machine (UTM): It is possible to construct a Turing machines $U$ such that $U(\langle T\rangle, w) = T(w)$. That is, $U$ can simulate any Turing machine when the description/code of that Turing machine is provided as an input.

Important results:

- There is a Turing machine $\mathrm{SELF}$ such that running $\mathrm{SELF}$ on an empty tape halts with $\langle \mathrm{SELF} \rangle$, the description/encoding of the Turing machine, on the tape.
- Let $T$ be a Turing machine that computes $t : \Sigma^\ast \times \Sigma^\ast \to \Sigma^\ast$.
  There exists a Turing machine $R$ that computes $r : \Sigma^\ast \to \Sigma^\ast$ such that $r(w) = t(\langle R \rangle, w)$ for every $w \in \Sigma^\ast$.
- Let $T$ be a Turing machine that computes $t : \Sigma^\ast \to \Sigma^\ast$. There exists a Turing machine $F$ such that $t(\langle F \rangle)$ describes a Turing machine equivalent to $F$.

### A self-reproducing Turing machine

Let's start with the self-reproducing Turing machine (a Quine program).
The proof idea is fully captured by the following simple program description in English.

```plaintext
Copy the following sentence twice, the second time without the quotes.
"Copy the following sentence twice, the second time without the quotes."
```

The program is the sequential composition of two subprograms $A$ and $B$.
The first part $A = P_{\langle B\rangle}$ is a program that prints out the description of $B$.
The second part receives its own code $\langle B\rangle$, computes $\langle A \rangle = \langle P_{\langle B\rangle}\rangle$ and writes $\langle A\rangle \cdot\langle B\rangle$.

The self-reproducing Turing machine can be viewed as a fixed point construction:

Applying the recursion theorem on the computable function $t(u,v) = u$,
one obtains another computable function $r$ represented by a Turing machine $R$ such that $r(w) = t(\langle R \rangle, w) = \langle R \rangle$ for every $w \in \Sigma^\ast$.
The condition $r(w) = \langle R\rangle$ says that $R$ is self-reproducing.

Applying the fixed point theorem on the computable function $t(w) = \langle P_w\rangle$,
one obtains a Turing machine $F$ such that $t(\langle F\rangle) = \langle P_{\langle F\rangle}\rangle$ is equivalent to $F$.
The equivalence condition requires $F$ to produce its own description.

### The Turing machine recursion theorem

Let $t : \Sigma^\ast \times \Sigma^\ast \to \Sigma^\ast$ be a computable function and $T$ be a Turing machine implementing $t$.
We will construct a Turing machine $R$ for a computable function $r : \Sigma^\ast \to \Sigma^\ast$ such that $r(w) = t(\langle R\rangle, w)$.

The idea is that to construct a two-part Turing machine $R = S \cdot T$, where $S$ writes $\langle R\rangle$ before the input and halts.
The construction of $R$ follows the self-reproducing Turing machine construction.
$R = A \cdot B \cdot T$.

1. $A = P_{\langle B\cdot T\rangle}$ writes out $\langle B\cdot T\rangle$.
2. $B$ receives $\langle B\cdot T\rangle w$, computes $A = P_{\langle B\cdot T\rangle}$, and writes $\langle A\rangle$.
3. The string $\langle A\rangle\cdot\langle B\cdot T\rangle w = \langle R\rangle w$ is on the tape.
4. $T$ receives $\langle R\rangle w$.

#### Applications

Using this construction, we can show that $f(\langle A\rangle, w)$ "1 if the Turing machine $A$ accepts $w$, 0 otherwise" is not computable.
In other words, the Turing machine acceptance problem $A_{TM}$ is undecidable.

1. Construct the Turing machine $G$ for $g(A, w) = \begin{cases}1 & f(A,w) = 0 \\ 0 & f(A,w) = 1 \end{cases}$.
2. $g$ is a computable function since $f$ is computable.
3. Apply the recursion theorem on $g$ to find $r$ such that $r(w) = g(\langle R\rangle, w)$.
4. For every string $w\in \Sigma^\ast$, $g(\langle R\rangle, w)$ can only be $0$ or $1$.
   - $r(w) = 1 = g(\langle R\rangle, w)$ means that $R$ does not accept $w$, which means $r(w) = 0$.
   - $r(w) = 0 = g(\langle R\rangle, w)$ means that $R$ accept $w$, which means $r(w) = 1$.
5. We have a contradiction. $f$. The Turing machine acceptance test function, cannot be computable.

Remark: The Turing machine acceptance problem is Turing recognizable.

Another classical application is to show that $\mathrm{MIN}_{TM}$, the language consists of codes of Turing machine $M$ such that no Turing machine of a shorter description is equivalent to $M$, is not Turing-recognizable.

1. Consider the Turing machine $f(A,w)$ which runs the enumerator of $\mathrm{MIN}_{TM}$ to find a Turing machine $U$ such that $|\langle U\rangle| > |A|$ and simulate $U$ on $w$.
2. Apply the recursion theorem on $f(\cdot, \cdot)$ to obtain a Turing machine $R$ such that $r(w) = f(\langle R\rangle, w)$
3. $f(\langle R\rangle, w)$ will find and simulate a minimal Turing machine $U$.
   Therefore $r(\cdot) = f(\langle R\rangle, \cdot)$ are equivalent to Turing machines.
   However the code of $U$ is longer than that of $R$ so $U$ cannot be a minimal Turing machine.
4. We have a contradiction. $f$. There cannot be an enumerator of $\mathrm{MIN}_{TM}$.

### The fixed point theorem of computable functions

Given a Turing machine $T$ for a computable function $t : \Sigma^\ast \to \Sigma^\ast$.
Define $f(A, w) = \mathrm{Simulate}(t(A),w)$, where $\mathrm{Simulate}(T,x)$ simulates the Turing machine encoded by $T$ on input $x$.
Applying the recursion theorem on $f$, one obtains a Turing machine $R$ which encodes a function $r$ such that $r(w) = f(\langle R\rangle, w) = \mathrm{Simulate}(t(\langle R\rangle),w)$.
That is $R$ is equivalent to $t(\langle R\rangle)$.

Remark: $f$ is not a computable function. As a result, $r$ is not necessarily a computable function.

#### Recursion theorem is actually about recursion

Fixing a function $t(\cdot,\cdot)$ and its Turing machine implementation $T$,
the recursion theorem clearly gives an digitalization $r(\langle R\rangle) = t(\langle R\rangle, \langle R\rangle)$ for $t$.
Leveraging this, we can define recursive procedures.

Suppose that $t(\langle A\rangle, w) = h_2(A(h_1(w)))$ where $h_1,h_2$ are two (partial) functions and $A(\cdot)$ is the function encoded by $\langle A\rangle$.
The recursion theorem returns a Turing machine $R$ which encodes a (partial) function $r$ such that $r(w) = h_2(r(h_1(w)))$.

Remarks: The construction of $R$ from $T$ is not dependent on the condition that $T$ encodes a (total) computable function.

## In first-order logics for arithmetics

Preliminaries

- Numeral representation of natural numbers $S^n 0$.  
  Note that $n$ is a natural number in the meta language and $S^n 0$ is a term in the object language.
- Representing a $m$-part relation $R \subseteq \mathbb{N}^m$ with a formula $\phi(x_1,x_2,\ldots,x_m)$ with $m$ free variables.
  For every $\vec a \in \mathbb{N}^m$, $\vec a\in R$ if and only if $\vdash \phi(S^{a_1} 0,S^{a_2} 0,\ldots, S^{a_m} 0)$.  
  Note that the _quantification_ and the _if and only if_ connectives are stated in the metalanguage.
- A computable function $f : \mathbb{N}^k \to \mathbb{N}$ can be turned into a decidable relation $R = \{ (a_1,\ldots,a_k, b) \in \mathbb{N}^{k+1} \mid b = f(a_1,\ldots, a_k) \}$ which is representable $\vdash \phi(S^{a_1}, \ldots, S^{a_k}, x) \leftrightarrow x = S^{f(a_1,\ldots,a_k)}$ for every $\vec a \in \mathbb{N}^k$.
- Internalizing the arithmetics
  - The meta-level notation $\lceil \cdot \rceil$: the Gödel number of a term / formula.
  - The unary function $n \mapsto \lceil S^n 0\rceil$ is representable.
  - The set of the Gödel numbers of variables/terms/atomic formula/well-formed formula/proof as a unary relation is representable.
  - The relation $\operatorname{free}(\lceil \phi\rceil, \lceil x\rceil)$ "test whether $x$ occurs freely in $\phi$" is representable.
  - The relation $\operatorname{proof}(\lceil \pi\rceil, \lceil \phi \rceil)$ "test whether $\pi$ is a proof of $\phi$" is representable.
  - The substitution function $\operatorname{sub}(\lceil \phi(x)\rceil, \lceil x \rceil, \lceil t \rceil) \mapsto \lceil \phi(t)\rceil$ is representable.

### Diagonalizing any formula

For every formula $\phi(x)$ with a single free variable, we can find a closed formula $\psi$ such that $\vdash \psi \leftrightarrow \phi(S^{\lceil \psi\rceil} 0)$.

1. The binary function $F$. For every formula $\alpha(x)$ and natural number $n$, $F(\lceil\alpha(x)\rceil, n) = \lceil\alpha(S^n 0)\rceil = \operatorname{sub}(\lceil\alpha(x)\rceil, \lceil x\rceil, \lceil S^n 0\rceil)$ is computable. Let $\theta(x,y,z)$ be a formula that represents the function.
2. Define the formula $\gamma$ as $\forall y . \theta(x,x,y) \to \phi(y)$. Let $q = \lceil \gamma\rceil$ be its Gödel number.
3. Define the formula $\psi$ as $\forall y . \theta(S^q 0, S^q 0, y) \to \phi(y)$

We claim $\psi$ has the fixed point property that $\vdash \psi \leftrightarrow \phi(S^{\lceil \psi\rceil} 0)$.

Since $\theta$ represents the substitution function $F(\lceil \alpha(x)\rceil, n) = \lceil \alpha(S^n 0)\rceil$,
the relation $\theta(S^q 0, S^q 0, y)$ asserts that $y = S^{F(q,q)} 0$ and

$$
F(q,q) = \operatorname{sub}(\lceil \forall y . \theta(x,x,y) \to \phi(y)\rceil, \lceil x\rceil, \lceil S^q 0\rceil) = \lceil \forall y. \theta(S^q 0, S^q 0, y) \to \phi(y)\rceil = \lceil\psi \rceil
$$

The intuitive reading of $\forall y . \theta(S^q 0, S^q 0, y) \to \phi(y)$ is "$\phi(y)$ whenever $y$ is the numeral of the $\lceil \psi\rceil$".

### Applications

The theorem (provable closed formula) of the system cannot be defined in the system:

1. Suppose that $\phi(x)$ "$x$ is the numeral of Gödel number of a theorem". That is $\vdash \phi(x)$ if and only if $x = S^{\lceil \psi\rceil} 0$ for some closed formula $\psi$ and $\vdash \psi$.
2. Apply the fixed point theorem to the formula $\neg \phi(x)$ to obtain a formula $\psi$ such that $\vdash \psi \leftrightarrow \neg\phi(S^{\lceil \psi\rceil} 0)$.
3. By deduction theorem $\vdash \psi$ if and only if $\vdash \neg \phi(S^{\lceil \psi\rceil} 0)$.
4. If $\phi$ is a theorem, we have $\neg \phi(S^{\lceil \psi\rceil} 0)$ "$\phi$ is not a theorem". If $\phi$ is not a theorem, we have $\phi(S^{\lceil \psi\rceil} 0)$ "$\phi$ is a theorem".
5. Contradiction.

The first incompleteness theorem:

1. The relation $\operatorname{Proves}(\lceil \pi\rceil, \lceil \phi\rceil)$ "$\pi$ is a valid proof of $\phi$" is decidable and hence representable. Suppose that $\theta(x,y)$ is a formula representing the relation.
2. Consider the formula $\neg \exists x . \theta(x,y)$ "$y$ is the numeral of a Gödel number of a formula that does not have a proof".
3. Apply the fixed point theorem to obtain $\psi$ such that $\vdash \psi \leftrightarrow \neg\exists x . \theta(x , S^{\lceil \psi\rceil} 0)$.
4. By deduction theorem, $\vdash \phi$ if and only if $\neg \exists x . \theta(x, S^{\lceil \psi\rceil} 0)$. That is, "$\phi$ is provable if and only if $\phi$ is not provable".
5. Suppose that the deduction system in question is consistent, then $\not\vdash\phi$ and $\not\vdash\neg \phi$. Neither $\phi$ nor $\neg \phi$ can be proved.

## In recursive function and combinatorial calculus

Preliminaries

- Defining number theoretic functions with recursion: Primitive recursive functions. Recursive functions (all minimization must be defined). Partial recursive functions (general minimization).
- Closure property of PR, REC, and PartRec.
- All recursive function can be represented in a proper first-order arithmetic theory.
- A number theoretic function is partial recursive if and only if it is Turing computable.
- A total partial recursive function is recursive.

Key results

- enumeration of partial recursive functions $\phi^n_z(x_1,\ldots,x_n) = U(\mu y . T_n(z,x_1,\ldots,x_n,y))$
  - $n$ arity of the function
  - $z$ index / code of a Turing machine
  - $T_n(z,x_1,\ldots,x_n,y)$ the characteristic function of the relation "$y$ is the Gödel number of the computation history of the Turing machine whose code is $z$ when given $a^{x_1} \# a^{x_2} \cdots \# a^{x_n}$ as the input".
  - $U(\cdot)$ decode the output from an accepting computation history.
- $s^m_n$ theorem. Primitive recursive function $s^m_n(z,y_1,\ldots,y_m)$ for specialization / partial application such that $\phi_z^{m+n}(x_1,\ldots,x_n,y_1,\ldots,y_m) = \phi_{s^m_n(z, y_1,\ldots,y_m)}(x_1,\ldots,x_n)$.
  - specialization of partial recursive functions is a primitive recursive procedure on the code of the function.
  - $z$ the code of a function with $m+n$ parameters.
  - $s^m_n(z,y_1,\ldots,y_m)$ the code of the specialized function with $m$ fixed parameters.

### recursion theorem

Let $f : \mathbb{N}^{n+1} \to \mathbb{N}$ be a partial recursive function, there exists $e$ such that $f(x_1,\ldots, x_n, e) = \phi^n_e(x_1,\ldots,x_n)$.

Let $d$ be the index of $(x_1,\ldots,x_n,y) \mapsto f(x_1,\ldots,x_n,s^1_n(y,y))$.
That is, $f(x_1,\ldots,x_n,s^1_n(y,y)) = \phi^{n+1}_d(x_1,\ldots,x_n,y)$.

By $s^m_n$ theorem, $\phi^{n+1}_d(x_1,\ldots,x_n,y) = \phi^n_{s^1_n(d,y)}(x_1,\ldots,x_n)$.

Let $e = s^1_n(d, d)$, then $f(x_1,\ldots, x_n,e)$ is

$$
f(x_1,\ldots, x_n,s_n^1(d,d)) = \phi^{n+1}_d(x_1,\ldots,x_n,d) = \phi^n_{s^1_n(d,d)}(x_1,\ldots, x_n) = \phi^n_e(x_1,\ldots,x_n)
$$

### fixed point theorem

Let $h : \mathbb{N} \to \mathbb{N}$ be a recursive function, there exists $e$ such that $\phi^1_e = \phi^1_{h(e)}$.

The function $f(x,z) = \phi^1_{h(z)}(x)$ is recursive.
Apply the recursion theorem to get an index $e$ such that

$$
f(x,e) = \phi^1_{h(e)}(x) = \phi^1_e(x)
$$

Intuitive reading: $h$ is a program transformer. Every program transformer has a fixed point in the sense that $e$ and $h(e)$ encode the same partial recursive function.

## references

- Michael Sipser, An introduction to the theory of computation, 2nd edition. Chapter 6 Advanced Topics in Computability Theory.
- Herbert B. Enderton, A mathematical introduction to logic, 2nd edition. Chapter 3 Undecidability.
- Elliot Mendelson, Introduction to mathematical logic, 5th ed. Chapter 5 Computability.

Related topics: the provability modal logic and meta programming in dependent type theories.
