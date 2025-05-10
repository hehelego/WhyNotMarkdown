# Quick Notes on Knaster-Tarski Lemma

References:

- [Knaster-Tarski Lemma - ProofWiki](https://proofwiki.org/wiki/Knaster-Tarski_Lemma)
- [Coinduction | Paul He](https://paulhe.com/2019/04/17/coinduction.html)
- _Pierce, Benjamin C. Types and programming languages. MIT press, 2002._ Part 4 Recursive Types, Chapter 21 Metatheory of Recursive Types, Section 1 Induction and Coinduction.
- _Harper, Robert. Practical foundations for programming languages. Cambridge University Press, 2016._ Part XVIII Equational Reasoning.


## ordered set

An ordered set is a set $A$ equipped with a partial order $\leq\ \subseteq A \times A$, denoted as $(A, \leq)$.

Recall: a partial order is a binary relation that satisfies

1. reflexivity: $\forall (x\in A) . (x \leq x)$
2. transitivity: $\forall (x,y,z\in A) . ((x\leq y) \to (y\leq z) \to (x\leq z))$
3. anti-symmetry: $\forall (x,y\in A) . ((x\leq y)\to (y\leq x) \to (x = y))$

## semi-lattice

Basic terminologies in lattice theory and their intuition:

- $\lor$ join: maximum, disjunction, union, upper bound.
- $\land$ meet: minimum, conjunction, union, lower bound.

A join semi-lattice is an ordered set equipped with a binary join operator, denoted as $(L, \leq, \lor)$ such that

1. $\forall (x,y\in A). (x\lor y \in A)$ closure
2. $\forall (x,y\in A) . (x \leq x \lor y)$ upper bound left operand
3. $\forall (x,y\in A) . (y \leq x \lor y)$ upper bound right operand

The duality of a join semi-lattice is called a meet semi-lattice, which 
is an ordered set equipped with a binary meet operator, denoted as $(L, \leq, \land)$ such that

1. $\forall (x,y\in A). (x\land y \in A)$ closure
2. $\forall (x,y\in A) . (x \land y \leq x)$ least bound left operand
3. $\forall (x,y\in A) . (x \land y \leq y)$ least bound right operand

An ordered on which both join and meet are defined is called a lattice.

## completeness of a semi-lattice

The intuition of a complete lattice:

- complete join semi-lattice: least upper bound of a subset always exists in the semi-lattice.
- complete meet semi-lattice: greatest lower bound of a subset always exists in the semi-lattice.

One may find this similar to the least upper bound property of real numbers, which is one of many equivalent characterizations of the completeness of real numbers.


A complete join semi-lattice is a ordered set equipped with a subset least upper bound operator, denoted as $(L, \leq, \bigcup)$ such that

1. $\forall (A\subseteq L) . (\bigcup A \in L)$ closure
2. $\forall (A\subseteq L) (x \in A) . (x \leq \bigcup A)$ upper bound
3. $\forall (A\subseteq L) (x \in A) (y\in A). ((\forall (x \in A) . (x\leq y)) \to (\bigcup A \leq y))$ least upper bound

A (non-empty) complete join semi-lattice always has a greatest element $\top \equiv \bigcup L$.



Dually, a complete meet semi-lattice is a ordered set equipped with a subset greatest lower bound operator, denoted as $(L, \leq, \bigcap)$ such that

1. $\forall (A\subseteq L) . (\bigcap A \in L)$ closure
2. $\forall (A\subseteq L) (x \in A) . (\bigcap A \leq x)$ lower bound
3. $\forall (A\subseteq L) (x \in A) (y\in A). ((\forall (x \in A) . (y\leq x)) \to (y \leq \bigcap A))$ greatest lower bound

A (non-empty) complete meet semi-lattice always has a least element $\bot \equiv \bigcap L$.



A tuple $(A, \leq, \bigcup, \bigcap)$ is a complete lattice if $(A, \leq, \bigcup)$ is a complete join semi-lattice and $(A, \leq, \bigcap)$ is a complete meet semi-lattice.

## monotone increasing mapping

Given two ordered sets $(S, \leq_s)$ and $(T, \leq_t)$, a monotone increasing mapping from $S$ to $T$ is a function $f$ such that

1. $\forall (x\in S) . \exists (y \in T) . (f(x) = y \in T)$
2. $\forall (x, x'\in S) . ((x\leq_s x') \to f(x) \leq_t f(x'))$ ordering preservation 

## Knaster-Tarski lemma

For every complete join semi-lattice $(L, \leq, \bigcup)$, a monotone increasing mapping $f : L \to L$ has a greatest fixed point.

Let $A = \{x \in L \mid x \leq f(x)\}$, one can show that $A$ is closed under $f$:

1. Let $x\in A$ be an arbitrary element in $A$.
2. By definition of $A$: $x \leq f(x)$.
3. By monotonicity of $f$: $f(x) \leq f(f(x))$.
4. By definition of $A$: $f(x)\in A$.

Let $a = \bigcup A$ be the least upper bound of $A$, one can show that $f(a)$ is also an upper bound of $A$:

1. Let $x\in A$ be an arbitrary element in $A$.
2. By definition of $A$: one concludes that $x \leq f(x)$.
3. $a$ is an upper bound of $A$: $x \leq a$.
4. By monotonicity of $f$: $f(x) \leq f(a)$.
5. By transitivity of $\leq$: $x\leq f(x) \leq f(a)$.

Lastly, one can show that $a = f(a)$

1. $a$ is the least upper bound of $A$, while $f(x)$ is another upper bound of $A$: $a \leq f(a)$.
2. By definition of $A$: $a \in A$.
3. $A$ is closed under $f$: $f(a) \in A$.
4. $a$ is an upper bound of $A$ and $f(a)$ is an element of $A$: $f(a) \leq a$.
5. By anti-symmetry of $\leq$: $a = f(a)$.

The above argument demonstrate that $\bigcup \{x \in L \mid x \leq f(x)\}$ is a fixed point of $f$.
Notice that $\{x\in L\mid x=f(x)\} \subseteq \{x \in L \mid x \leq f(x)\}$ by the reflexivity of $\leq$.
Therefore, $\bigcup \{x \in L \mid x \leq f(x)\}$ is the greatest fixed point.


The duality of the result is:
for every complete meet semi-lattice $(L, \leq, \bigcap)$, a monotone increasing mapping $f : L \to L$ has a least fixed point.
The least fixed point is $\bigcap \{x \in L \mid f(x) \leq x\}$.

## inductively defined sets and induction principles

Let $U$ be a (non-empty) set, then $(\mathcal{P} (U), \subseteq, \bigcup, \bigcap)$ is a complete join semi-lattice, where

- $\mathcal{P}(U) = \{T \mid T \subseteq U\}$ is the power set of $U$
- $\subseteq$ is the subset relation
- $\bigcap$ is the (countable) intersection operator

Suppose that $F : \mathcal{P}(U)\to \mathcal{P}(U)$ is a monotone increasing mapping.
$F$ has a least fixed point $Z$ where

$$
Z = \bigcap \{X \in \mathcal{P}(U) \mid F(X) \subseteq X\}
$$

The induction principle over $Z$ is

- For every predicate over $Q(\cdot)$,
- to show that $\forall (x\in Z) . Q(x)$,
- let $R = \{x \mid x \in U \land Q(x) \}$,
- it is sufficient to show that $F(R) \subseteq R$.

That is, by showing that the predicate $Q(\cdot)$ is preserved under transformation of $F$,
one can conclude that $Q(\cdot)$ is hold for every element in the least fixed point of $F$.

### example: natural numbers and mathematical induction

As an example, let $\Sigma = \{s, 0,(,)\}$ and $U = \mathcal{L}(\Sigma^\ast)$ be the strings consists of characters in $\Sigma$.
Define a monotone increasing mapping over $\mathcal{P}(U)$:

$$
F(X) = \{0\} \cup \{s(x) \mid x\in X\}
$$

The least fixed point $N = \bigcap \{X \in \mathcal{P}(U) \mid F(X)\subseteq X\}$ corresponds to a set generated by:

1. add $0$ in the set $N$.
2. if $n \in N$, add $s(n)$ into the set $N$.

This is exactly the inductive definition of natural numbers. The induction principle over $N$ is

$$
\forall (Q\in\mathcal{P}(U)) . (F(Q) \subseteq Q \to (\forall (n\in N) . n \in Q))
$$

Unfold the definition of $F(\cdot)$, we get the familiar mathematical induction.

$$
\forall (Q\in\mathcal{P}(U)) . ((0 \in Q) \land (\forall (n\in U) . (n\in Q \to s(n)\in Q)) \to (\forall (n\in N) . n\in Q))
$$

It can be interpreted as the following proof rule:

For every predicate $P(\cdot)$, to show that $P(n)$ is hold for every $n\in N$, it is sufficient to show that

- $P(0)$ holds, and
- For every $m$ such that $P(m)$ holds, $P(s(m))$ also holds.

## coinductively defined set and coinduction principle

Let $U$ be a (non-empty) set, then $(\mathcal{P} (U), \subseteq, \bigcup, \bigcap)$ is a complete meet semi-lattice, where

- $\mathcal{P}(U) = \{T \mid T \subseteq U\}$ is the power set of $U$
- $\subseteq$ is the subset relation
- $\bigcup$ is the (countable) union operator

Suppose that $F : \mathcal{P}(U)\to \mathcal{P}(U)$ is a monotone increasing mapping.
$F$ has a greatest fixed point $Z$ where

$$
Z = \bigcap \{X \in \mathcal{P}(U) \mid X \subseteq F(X) \}
$$

The coinduction principle over $Z$ is

- For every $x \in U$,
- to show that $x\in Z$,
- it is sufficient to find $R \in \mathcal{P}(U)$ such that
- $x\in R$, and
- $R \subseteq F(R)$,

That is, one can show $x\in U$ by providing a witness $R$ such that $x\in R$ and $R \subseteq F(R)$.

### example: bisimilarity and bisimulation

In a labeled state transition system $(S,A,T)$ where

- $S$ is the set of states
- $A$ is the set of actions
- $T \subseteq S \times A \times S$ is the transition relation

Notation: $p \stackrel{a}{\to} q$ for $(p,a,q) \in T$.

A binary relation over the states, $R \subseteq S\times S$ is called a bi-simulation
if for all $(p,q) \in R$ and $a \in A$

- $\forall (p' \in S) . (p \stackrel{a}{\to} p' \to (\exists (q' \in S) . (q \stackrel{a}{\to} q') \land ((p', q') \in R)))$
- $\forall (q' \in S) . (q \stackrel{a}{\to} q' \to (\exists (p' \in S) . (p \stackrel{a}{\to} p') \land ((p', q') \in R)))$

Or informally:

- Given $p R q$ and $p \stackrel{a}{\to} p'$, one can find $q'$ such that $p' R q'$ and $q \stackrel{a}{\to} q'$.
- Given $p R q$ and $p \stackrel{a}{\to} p'$, one can find $q'$ such that $p' R q'$ and $q \stackrel{a}{\to} q'$.

Bisimulation is closed under union. The coarsest bisimulation relation is called the bisimilarity.
Bisimilar states are observationally equal, meaning that they exhibit the same behavior in any trace of the transition system, thus are indistinguishable.

To show that two states $p$ ans $q$ are bisimilar, one can give a bisimulation relation $R$ such that $pRq$
This proof rule is an example of coinduction principle.

To interpret bisimulation and bisimilarity in lattice theory, consider a function $F:U\to U$ where $U=\mathcal{P}(S\times S)$ defined as

$$
F(R) = \{ (p,q) \in S\times S \mid Q(p, q, R) \land Q(q, p, R) \}
$$

where

$$
Q(p,q,R) = \forall (a\in A) (p' \in S) . (p \stackrel{a}{\to} p' \to (\exists (q' \in S) . ((p',q') \in R \land q \stackrel{a}{\to} q')))
$$

That is: state $p$ and $q$ are related by $F(R)$ if the next state is always related by $R$.

One can verify that $F$ is monotone increasing and $U = \mathcal{P}(S\times S)$ is a complete meet semi-lattice.
Therefore, $F$ has a greatest fixed point.

$$
\sim = \bigcup \{ R \in S\times S \mid R \subseteq F(R) \}
$$

Interpretation:

- Relation $R$ such that $R\subseteq F(R)$ are bisimulations.
- The coarsest bisimulation, which is the union of all bisimulations, is the bisimilarity relation.
- To show that $p \sim q$, one can find a bisimulation $R$ in which $p$ and $q$ are related.
