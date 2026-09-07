# A short note on preliminaries of domain theory

## overview

- Basic objects: pre-orders/quais-orders, partial orders, and pointed partial orders.
- Lower sets and upper sets.
- Monotone functions and strict functions.
- Chains and directed sets. Two notion of completeness.
- The way-below relation for approximation.
- Scott continuity and Scott topology.
- Continuous domain and algebraic domain.
- Product (pair up and projection), sum (inclusion and case-matching), and function space (currying and evaluation) on domains.
- Fixed point theorems.
- Embedding-projection pair. Solving recursive domain equations.

Helpful literatures:

- [Introductory course on domain theory and denotational semantics at the Midlands Graduate School (MGS) 2023 by Tom de Jong](https://github.com/tomdjong/MGS-domain-theory)  
  A very accessible lecture notes to get started.
- [Domain Theory in Constructive and Predicative Univalent Foundations. PhD thesis of Tom de Jong. University of Birmingham, 2022](https://arxiv.org/abs/2301.12405)  
  A formalization of domain theory in a univalent and predicative dependent type theory.
  For technical details and mechanized proofs in Agda.
- [Domain theory. A chapter in volume 3 of the handbook of logic in computer science. Samson Abramsky and Achim Jung](https://achimjungbham.github.io/pub/papers/handy1.pdf)  
  A classical reference of domain theory. It covers many advanced topics and provides a good description of the history and the landscape of research on domain theory.
- [Non-Hausdorff Topology and Domain Theory - Selected Topics in Point-Set Topology. A book by Jean Goubault-Larrecq](https://www.cambridge.org/core/books/nonhausdorff-topology-and-domain-theory/47A93B1951D60717E2E71030CB0A4441)  
  A newer book. It discusses domain theory from a topological perspective.
- The formal semantics of programming languages: an introduction. Glynn Winskel. MIT Press, 1993.  
  A rather old book with good introduction to denotational semantics and the supporting mathematical machinery.

Related topics:

- programming languages semantics, topology, and computability
  - operational domain theory and topology of sequential programming languages. Martín Hötzel Escardó and Weng Kin Ho.
  - exhaustible sets in higher-type computation. Martín Hötzel Escardó.
  - infinite sets that admit fast exhaustive search. Martín Hötzel Escardó.
- denotational semantics with metric spaces and ultra-metric spaces
- synthetic domain theory (SDT)
- step-indexing techniques, synthetic guarded domain theory (SGDT) and guarded type theory
- higher-order computability. A comprehensive textbook is available. [Higher-Order Computability. John Longley and Dag Normann. In the Theory and Applications of Computability series](https://link.springer.com/book/10.1007/978-3-662-47992-6)

## chains and directed sets

Let $(X, \leq)$ be a pre-order (reflexive and transitive).

A _non-empty_ subset $D \subseteq X$ is called **directed** if $D$ is closed under binary upper bound.
That is, for every $x,y \in D$, there exists $z \in D$ such that $x\leq z$ and $y\leq z$.

The least upper bound of a directed set, if exists, is called a directed join, denoted by $\bigcup\uparrow D$

**Remark** directed set can be defined on pre-orders that are not partial-orders.
On a metric space $(X,d : X \times X \to \mathbb{R}^{+})$ with a known point $x_0 \in X$, a pre-order can be defined $\leq = \{(x,y) \in X \times X \mid d(x_0,x) \geq d(x_0,y)\}$ "$x\leq y$ if $y$ is closer to $x_0$". This is a directed set, but not a partial order.

**Remark** directed set is a generalization of a set being a chain (linear/total order).

Terminologies for special partially ordered sets:

- pointed: has a bottom, i.e. a least element who is below all element.
- directed complete: has all directed join.
- $\omega$-chain complete: every $\omega$-chains has a limit.

**exercise** Directed completeness implies $\omega$-chain complete. $\omega$-chain complete not necessarily implies directed completeness.

Every $\omega$ chain, $x : \mathbb{N} \to X$ where $x_n \leq x_{n+1}$ for every $n\in\mathbb{N}$, can be viewed as a directed set $D = \{x_n \mid n \in \mathbb{N}\}$.
For every $i,j\in\mathbb{N}$, $x_i \leq x_{\max(i,j)}$ and $x_j \leq x_{\max(i,j)}$.  
However, the converse might not hold. This is because a directed set can be too large to be covered by countably many $\omega$-chains.
Consider the family of all countable subsets of $\mathbb{R}$ ordered by inclusion, denoted by $X$.

1. $X$ is directed since the union of two countable sets is always countable.
2. $X$ is $\omega$-chain complete since the union of countably many countable sets is countable.
3. $X$ is not directed complete since the directed join of $X$ is the join of $X$ which is the entirety of $\mathbb{R}$, which is uncountable.

See more discussion on chain-completeness and directed-completeness in _George Markowsky. Chain-complete posets and directed sets with applications. Algebra Universalis 6, 1976, pages 53-68._
The upshot is that for every ordinal number $\alpha$, $\alpha$-chain completeness implies directed completeness in pre-orders with cardinality

## Switch lemma

Suppose that $a : \mathbb{N} \times \mathbb{N} \to P$ is monotone with respect to both the first and the second index.
That is $a_{i,j} \leq a_{i+1,j}$ and $a_{i,j} \leq a_{i,j+1}$ for every $i,j \in \mathbb{N}$.

The lemma states that the following three directed joins coincide if they exist.

$$
L_1 = \bigsqcup_{i} \left(\bigsqcup_{j} a_{i,j}\right)
\quad
L_2 = \bigsqcup_{j} \left(\bigsqcup_{i} a_{i,j}\right)
\quad
L_d = \bigsqcup_{k} a_{k,k}
$$

For every $k\in \mathbb{N}$,

$$
a_{k,k} \leq \bigsqcup_{j} a_{k,j}
\quad
a_{k,k} \leq \bigsqcup_{i} a_{i,k}
$$

Therefore $L_d \leq L_1$ and $L_d \leq L_2$.

For every fixed $i$,

$$
\bigsqcup_{j} a_{i,j} = \bigsqcup_{j\geq i} a_{i,j} \leq \bigsqcup_{k\geq i} a_{k,k}
$$

Therefore, $L_1 \leq L_d$. Similarly, $L_2 \leq L_d$ can be proved.
Thus, all the three joins must agree.

## pointedness, binary join, and directed completeness implies completeness

Let $(X, \leq, \bot, \sqcup)$ be a pointed directed partial order that admits all binary joins.
Every subset $Y\subseteq X$ has a join (least upper bound) in $X$.

The case for $Y = \emptyset$ is trivial. We now consider the case for $Y \neq \emptyset$.

Let $F = \{S \subseteq Y \mid S\ \text{is finite}\}$ be the collection of all finite subsets of $Y$.
For every $S \in F$, according to the premise, $\bigsqcup S$ exists in $X$.
Let $D = \left\{ \bigsqcup S \mid S\in F \right\}$ be the set of join of all finite subsets of $Y$.
$D$ is directed since the join of two finite subsets is the join of the union of the two finite subsets, which is a finite join again.
That is $S_1, S_2 \in D$ implies $S_1 \cup S_2 \in D$ and $\left(\bigsqcup S_1\right) \sqcup \left(\bigsqcup S_2\right) = \bigsqcup (S_1 \cup S_2)$.

The directed join of $D$ is exactly the join of $Y$:

$$
\bigsqcup Y
= \bigsqcup_{S \in F} \left( \bigsqcup S \right)
= \bigsqcup D
= \bigsqcup\nolimits^\uparrow D
$$

As a corollary, a join semi-lattice with a bottom that has all directed join has all join.

## topological compactness in terms of directed join

Let $(X,\tau)$ be a topological space.
"For every directed collection (ordered by subset inclusion) of open subsets $D \subseteq \tau$, $X = \bigcup D$ implies $X \in D$"
is a necessary and sufficient condition for $X$ to be compact.

(direction: necessary) Suppose that $(X,\tau)$ is compact and a directed collection $D$ covers $X$.
By compactness, there exists a finite collection of open subsets $d_1,d_2,\ldots d_n \in D$ such that $X = \bigcup_{i=1}^{n} d_i = \bigsqcup_{i=1}^{n} d_i$.
Since $D$ is a directed set, every two elements has an upper bound in $D$, therefore $\{d_1,d_2,\ldots,d_n\}$, as a finite set, has an upper bound in $D$.
Since $\bigcup_{i=1}^{n} d_i = X$, the upper bound of $\{d_i\}_{i=1}^{n}$ must be $X$ itself.

(direction: sufficient) Let $A : I \to \tau$ be a family of $I$-indexed open subsets such that $X = \bigcup_{i \in I} A(i)$.
Let $F = \left\{ S\subseteq I \mid S\ \text{is non-empty and finite} \right\}$ be all non-empty finite subsets of the index set.
Let $G = \left\{ \bigcup_{i\in S} A(i) \mid S \in F \right\}$ be a collection of open subsets.
For every two non-empty finite subsets $S_1, S_2 \in F$, clearly $S_1 \cup S_2 \in F$
and $\left( \bigcup_{i \in S_1} A(i)\right)\cup\left( \bigcup_{i \in S_2} A(i)\right) = \bigcup_{i \in S_1 \cup S_2} A(i)$.
Therefore $G$ is directed.
Further $G$ is a cover of $X$ since $X = \bigcup A = \bigcup B = \bigcup\nolimits^\uparrow B$.
By the directed cover premise, there exists $T \in F$, which is a non-empty finite subset of $I$, such that $\bigcup_{i\in T} A(i) = X$.
That is, $A$ contains a finite sub-cover of $X$.
Therefore, $X$ is a compact topological space.

## The way below relation

Let $(P,\leq)$ be a partially ordered set with all directed joins.

For every $a,b \in P$, "$a$ is way below $b$", denoted by $a \ll b$ is defined as:
whenever a directed set $Q \subseteq P$ such that $b\leq \bigcup\nolimits^\uparrow Q$, there exists $q \in Q$ such that $a \leq q$.

Intuition: Every directed join above $b$ must be immediately above $a$.

The way below relation can be viewed as a generalized version of compactness/finiteness.

**Exercise** $a \ll b$ implies $a \leq b$. $\{b\}$ is a directed family above $b$, therefore $a \leq b$.

**Exercise** $x' \leq x \ll y \leq y'$ implies $x' \ll y'$. A directed join above $y'$ is automatically above $y$, hence it includes an element above $x$ which will be above $x'$.

**exercise** Let $Y$ be a set and $X = \mathcal{P}(Y)$ be the powerset of $Y$.
In the partially ordered set $(X,\subseteq)$, $A \ll B$ iff $A$ is a finite subset of $B$.

Let $D$ be the collection of all finite subsets of $B$. The $D$ is directed and $B =  \bigcup\nolimits^\uparrow D$. (Since every element of $B$ appears in RHS).
Thus $B\subseteq \bigcup\nolimits^\uparrow D$.
According to the definition of $A \ll B$, there exists $d \in D$, a finite subset of $B$, such that $A\subseteq d \subseteq B$.
All subsets of a finite set is finite, hence $A$ is finite.

This example hints that $x \ll x$ is a generalizing notion of $x$ being finite.

**Exercise** way below relation in $\mathbb N_\omega= \{0,1,2,\ldots,\infty\}$.

- $0,1,2,\ldots \infty$ is a linear order. A directed set merely a subset.
- Case $y = n$ for some $n \in \mathbb{N}$. Then $x \ll n$ iff $x \leq n$.  
  The first exercise shows that $x \ll n$ implies $x\leq n$.
  Suppose that $n \leq \bigsqcup\nolimits^\uparrow D$ for some $D\subseteq \mathbb N_\omega$. There exists $d \in D$ such that $n \leq d$. By transitivity $x \leq d$. Therefore $x \ll n$.
- Case $y = \infty$. $x\ll \infty$ iff $x \in \mathbb{N}$.  
  A directed join above $y$ either already contains $\infty$ or has a infinite subset of natural numbers. In the second case, $x$ cannot be $\infty$.

Notations. For every $x \in P$ and $A \subseteq P$:

- $\downarrow\!x = \{y \in P \mid y \leq x\}$ and $\downarrow\!A = \bigcup_{x\in A} \downarrow\!x = \{y \in P \mid \exists x \in A . y\leq x\}$. Lower set.
- $\Downarrow\!x = \{y \in P \mid y \ll x\}$ and $\Downarrow\!=\bigcup_{x\in A} \Downarrow\!x =\{y \in P \mid \exists x \in A . y \ll x\}$ (usually a two head down arrow in the literatures)
- Upper sets, the dual notion of lower sets.
- Way-upper sets, the dual notion of way-below sets.

## Scott continuity

A function $f: (P,\leq_P) \to (Q, \leq_Q)$ between two partially ordered set is said to be Scott-continuous if $f$ preserves all directed join. ($f$ commutes with $\bigsqcup\nolimits^\uparrow$)

$$
\forall D \subseteq P . \mathrm{Directed}(D) \to f\left(\bigsqcup\nolimits^\uparrow D\right) = \bigsqcup\nolimits^\uparrow f(D)
$$

**Remark** Directed sets are non-empty. If $P$ and $Q$ are pointed, i.e. has a bottom (a least element), Scott continuity does not imply strictness, i.e., the preservation of bottom $f(\bot_P) = \bot_Q$.

**Lemma** Scott continuous functions are monotone.

Let $x \leq_P y$ be two elements in $P$. Then $\{x,y\}$ is a directed set (check that $(x,x)$, $(x,y)$ and $(y,y)$ have an upper bound in $\{x,y\}$).
By continuity, $f(y) = f(\bigsqcup\nolimits^\uparrow \{x,y\}) = \bigsqcup\nolimits^\uparrow \{f(x),f(y)\}$.
Therefore $f(x) \leq_Q f(y)$.

**Exercise** a monotone but non-continuous function.

Consider the chain $\mathbb{N}_{\omega} = 0\leq 1 \leq 2 \leq \cdot \leq \infty$.
Define a function $f : N_{\omega} \to \{\bot, \top\}$ where $f(n) = \bot$ if $n\in\mathbb{N}$ and $f(\infty) = \top$.
The directed join of all finite elements is $\bigsqcup\nolimits^\uparrow \mathbb{N} = \infty$.
However, $\bigsqcup\nolimits^\uparrow f(\mathbb{N}) = \bigsqcup \{\bot\} = \bot \neq \top = f(\infty)$.

**Exercise** Strict Scott continuous functions may not preserve arbitrary joins.

On the complete lattice $(\mathcal{P}(\{0,1\}), \subseteq)$, one can define the endo-function $f(x) = \bot$ if $x \neq \top$ and $f(\top) = \top$.
The function $f$ is strict and Scott continuous.
The function does not preserve all joins $f(\{0\}\cup \{1\}) = f(\{0,1\}) = \top$ but $f(\{0\}) \sqcup f(\{1\}) = \bot$.

**Exercise** If a Scott continuous function preserves all finite non-empty joins (preservation of binary joins is sufficient), then it preserves all non-empty joins.

For every non-empty subset $X \subseteq P$, the join $\bigsqcup X$ can be decompose into $\bigsqcup\nolimits^\uparrow \left\{ \bigsqcup \{ Y \subseteq X \mid Y\ \text{is non-empty and is finite} \} \right\}$.
The set of all joins of finite subsets is directed since finite subsets are closed under set union and $\bigsqcup (Y_1 \cup Y_2) = \bigsqcup Y_1 \sqcup \bigsqcup Y_2$.

## Scott topology

The concept of Scott continuity enables one to define the following notion of Scott openness and Scott topology.

Let $\Omega = (\{\bot,\top\},\{\bot \leq \top\})$ be the Sierpiński space.
A subset $A \subseteq P$ is said to be Scott open if its characteristic function $\delta_A : P \to \Omega$ is Scott continuous.

Consider the open subsets of $\Omega$:

$$
\delta_{\{\}}(x) = \bot
\quad
\delta_{\{\bot,\top\}}(x) = \top
\quad
\delta_{\{\top\}}(x) = x
\quad
\delta_{\{\bot\}}(x) = \begin{cases}
\top & x = \bot \\
\bot & x = \top \\
\end{cases}
$$

- The two constant functions are continuous.
- The identity function are continuous.
- The flip function is not even monotone so it is cannot be continuous.

The Scott topology over $\Omega$ has $\mathcal{O}(\Omega) = \{\emptyset, \{\top\}, \Omega\}$.  
This is exactly the usual definition of Sierpiński space in general point-set topology.

A set $A$ is Scott open. $\delta_A$ preserves directed join. For every directed set $\emptyset\subsetneq D\subseteq P$ whose join exists:

- case $\delta_A(\bigsqcup\nolimits^\uparrow D) = \bigsqcup\nolimits^\uparrow \delta_A(D) = 0$ that is $\forall d \in D . d \notin A$ iff $\bigsqcup\nolimits^\uparrow D \notin A$.  
  That is, for a directed join to land in $A$, it must already intersects with $A$ (inaccessible by directed joins).
  Or equivalently, $P \setminus A = \{x \in P \mid x \notin A\}$ is closed under directed join.
- case $\delta_A(\bigsqcup\nolimits^\uparrow D) = \bigsqcup\nolimits^\uparrow \delta_A(D) = 1$ that is $\exists d \in D . d \in A$ iff $\bigsqcup\nolimits^\uparrow D \in A$.  
  Fixing $d \in D \cap  A$, the directed join $\bigsqcup\nolimits^\uparrow D$ can be any element above $d$. This is effectively requiring $A$ to be an upper set.  
  The continuity of $\delta_A$ implies that $\delta_A$ is monotone, which is also equivalent to $A$ being an upper set.

The Scott topology on a partially ordered set $(P,\leq)$:

- open: upper sets that are inaccessible by directed join.
- closed: lower sets that are closed under directed join.

We can verify that the Scott topology on a partially ordered set is actually a topology.

- $\emptyset$ and $P$ are open by definition.
- Open subsets are closed under union: Suppose that $\{A_i\}_{i\in I}$ are all open.  
  - Show that $\bigcup_{i\in I} A_i$ is upwards closed.
    For every $x \leq y$ such that $x \in \bigcup_{i \in I} A_i$. There exists $i\in I$ such that $x \in A_i$.
    Since $A_i$ is upwards closed, $y \in A_i$. Therefore $y \in \bigcup_{i\in I} A_i$.  
  - Show that $\bigcup_{i\in I} A_i$ is inaccessible by direct join.
    For every directed set $D \subseteq P$ such that $d = \bigsqcup\nolimits^\uparrow D$ exists, where $d$ is in the union.
    There exists $i\in I$ such that $d \in A_i$. Since $A_i$ is inaccessible by directed join, $D \cap A_i$ must be non-empty.
    Therefore $D \cap \left( \bigcup_{i\in I} A_i \right)$ is also non-empty.
- Open subsets are closed under finite intersection: Suppose that $A,B\subseteq P$ are open.  
  - Show that $A\cap B$ is upwards closed.
    For every $x \leq y$ such that $x \in A \cap B$.
    Upwards closure of $A$ and $B$ gives $y\in A$ and $y\in B$, respectively.
    Therefore $y\in A\cap B$.
  - Show that $A\cap B$ is inaccessible by directed join.
    For every directed subset $D \subseteq P$ such that $d = \bigsqcup\nolimits^\uparrow D$ exists, where $d$ is in the intersection.
    Since $A$ is inaccessible by directed join, $A \cap D$ must be non-empty. Similarly, $B\cap D$ is also non-empty.
    Let $a \in A \cap D$ and $b\in B\cap D$ be two elements.
    Direction of $D$ gives an element $c\in D$ such that $a,b\leq c$.
    Since $A$ and $B$ are upwards closed, $c \in A$ and $c \in B$.
    Therefore $D \cap (A \cap B)$ is non-empty.

**Remark** In a classical (the law of excluded middle is available) setting, the complement of an upper set is necessarily a lower set.  
Suppose that $A\subseteq P$ is an upper set. Let $x\leq y$ such that $y\notin A$. It is impossible to have $x\in A$ since it implies $y \in A$. Therefore $x \notin A$.

**Example** $P = ([0,1], \leq)$ the real interval between $0$ and $1$ ordered by less or equal to. Let Scott-opens of $P$ are $\{ (a,1] \mid 0\leq a\leq 1 \}$.

An open subset is upwards closed. So it must have the form $[a,1]$ or $(a,1]$.
Consider the sequence $x_n = a - \frac{1}{n}$ for $n \in \mathbb{N}$ such that $an \geq 1$.
The monotone sequence is trivially a directed set whose directed join is the limit of the sequence $\lim_{n\to\infty} \left( a - \frac{1}{n} \right) = a$.
Scott opens are inaccessible by directed join, so an open subset can only have the form $(a,1]$.
One can easily verify that all sub-interval of this form are indeed Scott open.

**Lemma** For every partial order $(P, \leq_P)$, the set $\downarrow x$ is Scott closed and its complement $P\setminus \downarrow x$ is Scott open.

- $\downarrow x$ is downwards closed.  
  For every $a \leq_P b$ where $b \in \downarrow x$, show that $a \in \downarrow x$.
  $b\in \downarrow$ means $b\leq_P x$ by definition.
  By transitivity, $a \leq_P b \leq_P x$.
  Therefore $a \in \downarrow x$.
- $\downarrow x$ is closed under directed join.  
  For every directed set $D \subseteq P$ such that $D \subseteq \downarrow x$,
  show that $\bigsqcup\nolimits^\uparrow D \in \downarrow x$ should it exists.
  $x$ is an upper bound for $D$ and the directed join is the least upper bound,
  therefore $x$ should be above the directed join,
  which is to say the directed join lands in the set $\downarrow x$.

**Exercise** In a partial order $(P, \leq_P)$, the subset $\uparrow x$ is not necessarily Scott open and its complement $P \setminus \uparrow x$ is not necessarily Scott closed.

Consider the partial order $\mathbb{N}_{\omega} = 0\leq 1 \leq 2 \leq \cdots \leq \infty$.
The set $\mathbb{N}_{\omega}\setminus \uparrow\infty = \mathbb{N}$ is not Scott closed.
The subset of all finite elements $\mathbb{N}$ is a directed set but its least upper bound is $\infty$.

**Remark** Scott continuous functions are exactly the continuous functions with respect to the Scott topology.

**Direction** $\Rightarrow$: Let $f : (P,\leq_P) \to (Q,\leq_Q)$ be a Scott-continuous function. Show that $f$ is continuous with respect to the Scott topology.
Show that $f^{-1}(\cdot) : \mathcal{P}(Q) \to \mathcal{P}(P)$ where $f^{-1}(Y) = \{x \in P \mid f(x) \in Y\}$ maps Scott opens to Scott opens.
For every Scott open subset $B\subseteq Q$, verify that the pre-image $A = \{x \in P \mid f(x) \in B\}$ is also open.

- $A$ is be upwards closed.  
  For every $x,y\in P$ such that $x \leq_P y$ and $x \in A$, check that $y\in A$.
  By definition, $x\in A$ iff $f(x) \in B$ and $y\in A$ iff $f(y) \in B$.
  Scott continuity implies monotonicity. $x\leq_P y$, therefore $f(x) \leq_Q f(y)$.
  $B$ is upwards closed. $f(x) \in B$ and $f(x) \leq_Q f(y)$, thus $f(y) \in B$, which means $y \in A$.
- $A$ is inaccessible by directed join.  
  For every directed subset $D\subseteq P$ whose directed join $d = \bigsqcup\nolimits^\uparrow D$ exists and lands in $A$, verify that there exists some $a \in D \cap A$, i.e., $a \in D$ such that $f(a) \in B$.
  Scott continuity implies monotonicity. Therefore $f(D) = \{f(x) \mid x\in D\}$ is a directed subset of $Q$.
  Further, $f(d) = \bigsqcup\nolimits^\uparrow f(D)$, which lands in $f(A)\subseteq B$, since Scott continuous function preserves directed join.
  Due to the fact that $B$ is inaccessible by directed join, there exists some $b \in B \cap f(D)$.
  $b\in f(D)$ implies the existence of $a\in D$ such that $b = f(a)$.
  This element $a$ satisfy the condition $a \in D$ and $f(a) \in B$.

**Direction** $\Leftarrow$: Let $g : (P,\leq_P) \to (Q,\leq_Q)$ be a continuous function with respect to the Scott topology. Show that $g$ is Scott-continuous.
For every directed subset $D\subseteq P$ such that $d = \bigsqcup\nolimits^\uparrow D$ exists in $P$,
verify that $f(d) = f\left( \bigsqcup\nolimits^\uparrow D \right) = \bigsqcup\nolimits^\uparrow f(D)$.

- $f$ is monotone.  
  For every $x \leq_P y$, validate that $f(x) \leq_Q f(y)$ or $f(x) \in \downarrow f(y)$.
  Proof by contradiction. Try to invalidate that $f(x) \in Q \setminus \downarrow f(y)$.
  Note that $Q \setminus \downarrow f(y)$ is an open subset of $Q$.
  Since $f$ is continuous in the Scott topology, the pre-image $f^{-1}(Q \setminus \downarrow f(y)) = P\setminus f^{-1}(\downarrow f(y))$ is open and the complement $f^{-1}(\downarrow f(y))$ is closed.
  Given $f(x) \in Q\setminus \downarrow f(y)$, one can infer $x \in P\setminus f^{-1}(\downarrow f(y))$, which is equivalent to $x \notin f^{-1}(\downarrow f(y))$.
  However, this cannot be the case since $f^{-1}(\downarrow f(y))$ is downwards closed, $y \in f^{-1}(\downarrow f(y))$, and $x \leq_P y$ implies $x \in f^{-1}(\downarrow f(y))$.
- Since $f$ is monotone and $D$ is directed, the direct image $f(D)\subseteq Q$ is also a directed set.  
  Suppose that $z\in D$ is an upper bound of $x,y\in D$, then $f(z) \in f(D)$ will still be an upper bound of $f(x),f(y) \in f(D)$.
- $d$ is the least upper bound of $D$, therefore $f(d)$ is an upper bound of $f(D)$.  
  For every $x\in D$, $x \leq_P d$ implies $f(x) \leq_Q f(d)$.
  Therefore $\bigsqcup\nolimits^\uparrow f(D) \leq_Q f(d)$.
- $f(d) \leq_Q \bigsqcup\nolimits^\uparrow f(D)$ can be derived.  
  Proof by contradiction. Suppose that $r \in Q$ is an upper bound of $f(D)$ such that $f(d) \not\leq_Q r$, which is equivalent to $f(d) \in Q\setminus \downarrow r$.
  Take the pre-image, $d \in f^{-1}(Q\setminus \downarrow r) = P\setminus f^{-1}(\downarrow r)$.
  The pre-image is an open subset, since $f$ is continuous and $Q\setminus \downarrow r$ is open.
  Therefore $P\setminus f^{-1}(\downarrow r)$ is upwards closed and inaccessible by directed join.
  There exists $e \in D$ such that $e \in P\setminus f^{-1}(\downarrow r)$ because $d = \bigsqcup\nolimits^\uparrow D \in P \setminus f^{-1}(\downarrow r)$.
  However, this is impossible since $e\in P\setminus f^{-1}(\downarrow r) \iff e\notin f^{-1}(\downarrow r) \iff f(e) \not\leq_Q r$,
  which contradicts the assumption that $r$ is an upper bound of $f(D)$.
- By anti-symmetry $f(d) = \bigsqcup\nolimits^\uparrow f(D)$.

## continuous domain and algebraic domain

**TODO:** continuous and algebraic

Algebraic: every element is the join of its compact approximations.

Algebraic DCPO closure properties.

Scott domain. A directed complete partial order that is

- pointed: with a bottom element below everything
- algebraic
- consistently complete: every non-empty subset with an upper bound has a least upper bound

## constructions on the category of pointed directed complete partial orders

### Lifting

Adding a new bottom element.

### Product

The projections are continuous.

**TODO:** verify that the DCPO product is a categorical product.

### Exponential

$$
\{f : D_1 \to D_2 \mid f\ \text{is Scott-continuous}\}
$$

- product and exponential adjunction.
- curry and apply functionals.

### Sum

$$
\{1\} \times D_1 \cup \{2\} \times D_2 \cup \{\bot\}
$$

**TODO:** check whether the sum construction is a categorical sum.

### Strict constructions

- strict product
- strict sum
- strict function space

### Kleene fixed point theorem

Let $(D, \leq)$ be a pointed directed complete partial order, and $f : P \to P$ be a Scott-continuous function.

- $\mu(f) = \bigsqcup_{n\in\mathbb{N}}\nolimits^\uparrow f^n(\bot)$ is the least fixed point of $f$
- The functional $\mu(\cdot) : D^D \to D$ is continuous.

The sequence $\bot \leq f(\bot) \leq f^2(\bot) \leq \cdots f^n(\bot) \leq \cdots$ is an $\omega$-chain (which is automatically a directed set).

$$
f\left( \bigsqcup_{n\geq 0}\nolimits^\uparrow f^n(\bot) \right)
= \bigsqcup_{n\geq 0}\nolimits^\uparrow f(f^n(\bot))
= \bigsqcup_{n\geq 1}\nolimits^\uparrow f^n(\bot)
= \bigsqcup_{n\geq 0}\nolimits^\uparrow f^n(\bot)
$$

That is, $f(\mu(f)) = \mu(f)$, meaning that $\mu(f)$ is indeed a fixed point of $f$.

To show that $\mu(f)$ is the least fixed point, one can show that every fixed point of $d$ is above $\mu(f)$.
Let $d \in D$ be a fixed point of $f$. Clearly $\bot \leq d$.
Using the monotonicity of $f$, one can derive that $f^n(\bot) \leq f^n(d) = d$ for every $n\in\mathbb{N}$ by induction.
Therefore $d$ is an upper bound of the $\omega$-chain.
One can conclude that $\mu(f) = \bigsqcup_{n\geq 0}\nolimits^\uparrow f^n(\bot) \leq d$ since $\mu(f)$ is the least upper bound of the $\omega$-chain.

**TODO:** show the continuity of $\mu(\cdot)$.

### Bilimits

**TODO:** Embedding-projection pair
