# Note on Decision Diagrams

## Binary decision diagrams (BDD)

### Overview

- Reduced ordered binary decision diagrams (ROBDD) can be viewed as the if-then-else canonical form of boolean functions.
- For every boolean function $f:\mathbb{B}^n \to \mathbb{B}$. The BDD of $f$ is unique, when a variable order $x_1 < x_2 \ldots <x_n$ is provided.
- Basic construction:
    - The $\mathbf{T}$ leaf node for the constant true function
    - The $\mathbf{F}$ leaf node for the constant false function
    - An _if-then-else_ node $(x,low,high)$ for $ITE(x,g,h)$ where
        - $g$ and $h$ are the boolean functions represented by BDD nodes $high$ and $low$, respectively.
        - $ITE(x, g, h) = (x\land g)\lor (\lnot x\land h) \equiv (x\to g)\land (\lnot x\to h)$
- Representation invariant:
  For every internal node $(x,low,high)$
  - if $low$ is an internal node $(x', \ast, \ast)$ then $x < x'$
  - if $high$ is an internal node $(x', \ast, \ast)$ then $x < x'$
- Reduction:
    - Merge all $\mathbf{T}$ nodes. Merge all $\mathbf{F}$ nodes. Only two leaf nodes in a BDD.
    - Unique node: The triples $(x, low, high)$ should be unique within a BDD, i.e., each internal node is distinct.
    - No redundant branching: $ITE(x,f,f) \equiv f$.

### Expansion law

**Shannon expansion**: $f \equiv (x \land f[\mathbf{T}/x]) \lor (\lnot x \land f[\mathbf{F}/x])$, for every boolean expression $f$.

In the context of BDD, The theorem can be interpreted as follows:

- The BDD of a boolean function $f$ is $(x, low, high)$ after reduction, where
- $low$ is the BDD of $f_0 = f[\mathbf{F}/x]$ or `f0 = \y -> f(y, x=false)`
- $high$ is the BDD of $f_1 = f[\mathbf{T}/x]$ or `f1 = \y -> f(y, x=true)`

### Operations


Now consider an arbitrary binary operator `(+)` and two boolean expressions `f` and `g`.

$$
\begin{aligned}
f \oplus g
& \equiv (x\land (f\oplus g)[\mathbf{T}/x]) \lor (\lnot x\land (f\oplus g)[\mathbf{F}/x]) \\
& \equiv (x\land (f[\mathbf{T}/x]\oplus g[\mathbf{T}/x])) \lor (\lnot x\land (f[\mathbf{F}/x]\oplus g[\mathbf{F}/x])) \\
\end{aligned}
$$

This allow us to construct the BDD of `f (+) g` given the BDD of `f` and `g` via the following recursive algorithm:

1. `L1 (+) L2` where `L1` and `L2` are leaf nodes whose boolean value are `v1` and `v2`, respectively: return the leaf node for `v1 (+) v2`
2. `ITE(x, low, high) (+) L` where `L` is a leaf node:
    1. split on variable `x`
    2. construct BDD `low'` for `low (+) L`
    3. construct BDD `high'` for `high (+) L`
    4. return `reduce( ITE(x, low', high') )`.
3. `v (+) ITE(y, low, high)` where `v` is a leaf node: symmetry, similar to the previous case.
4. `ITE(x, low_x, high_x) (+) ITE(y, low_y, high_y)`: split on variable `z=min(x,y)`
    - if `z=x=y`:
        1. construct BDD `low` for `low_x (+) low_y`
        2. construct BDD `high` for `high_x (+) high_y`
        3. return `reduce( ITE(z, low, high) )`
    - if `z=x < y`:
        1. construct BDD `low` for `low_x (+) ITE(y, low_y, high_y)`
        2. construct BDD `high` for `high_x (+) ITE(y, low_y, high_y)`
        3. return `reduce( ITE(z, low', high') )`
    - if `z=y < x`:
        1. construct BDD `low` for `ITE(x, low_x, high_x) (+) low_y`
        2. construct BDD `high` for `ITE(x, low_x, high_x) (+) high_y`
        3. return `reduce( ITE(z, low', high') )`

Boolean negation operator is defined as $\lnot f \equiv f \operatorname{xor} \mathbf{T}$

We can also compute the BDD of variable substitutions:

$$
\begin{aligned}
f
& \equiv (x\land f[1/x]) \lor (\lnot x\land f[0/x]) \\
f[g/y]
& \equiv \begin{cases}
(g\land f[1/x]       ) \lor (\lnot g \land f[0/x]       ) & x =    y \\
(x\land (f[1/x])[g/y]) \lor (\lnot x \land (f[0/x])[g/y]) & x \neq y \\
\end{cases}
\end{aligned}
$$

Implemented by the following algorithm:

1. `true[g/y]=true` and `false[g/y]=false`
2. `ITE(y, low, high)[g/y]`: BDD of `(g & high) | ((~g) & low)`.
3. `ITE(x, low, high)[g/y]` where `x` is different from `y`: `(x & high[g/y]) | ((~x) & low[g/y])`.

### Satisfiability

BDD is unique under fixed variable order.
To determine whether $f\equiv g$, just compare the BDD.

- SAT: not $f \equiv \mathbf{F}$
- UNSAT: $f \equiv \mathbf{F}$

Therefore, SAT/UNSAT can be done in constant time when the BDD is presented.

Counting satisfying assignments:

- Recall the definition of the _if-then-else_ connective: $ITE(x,g,h) = (x\land g) \lor (\lnot x\land h)$
- In a satisfying assignment for $ITE(x,g,h)$:
    - either $x=\mathbf{T}$: $\{x\gets \mathbf{T}\} \cup SAT(g)$
    - or $x=\mathbf{F}$: $\{x\gets \mathbf{F}\} \cup SAT(h)$


## Zero-suppressed decision diagrams (ZDD)

### Overview

- overview: zero-suppressed decision diagram (ZDD) is a data structure of manipulating family of sets.
  Given a order $x_1 < x_2 \ldots x_n$ over $X=\{x_1,x_2,\ldots,x_n\}$, ZDDs provide compact and canonical representation of objects $F \in \mathcal{P}(\mathcal{P}(X))$, i.e., sets whose elements are subset of $X$.
- basic construction:
    - bottom: the empty family $[\bot] = \{\}$,
    - top: the unit family $[\top] = \{\emptyset\}$
    - the partition $[F] = [(x,F_0,F_1)] = [F_0] \cup \{s\cup \{x\} \mid s \in [F_1]\}$
- Representation invariant:
    For every internal node $(x,low,high)$
    - if $low$ is an internal node $(x', \ast, \ast)$ then $x < x'$
    - if $high$ is an internal node $(x', \ast, \ast)$ then $x < x'$
- reduction:
    - no duplicate nodes.
    - zero-suppressed: $(x, F, \bot) \leadsto F$.  
      high branch should not be the $\bot$,  
      justified by the equation $F \cup \{s\cup\{x\} \mid s\in \emptyset\} = F\cup \{\} = F$  
- alternative interpretation:
    - unate boolean functions. $[\bot]= \mathbf{F}, [\top]= \mathbf{T}, [(x,F_{lo},F_{hi})] = F_{lo}+x F_{hi}$
    - a boolean function $f: \mathbb{B}^n \to \mathbb{B}$ such that $f(v_1,v_2,\ldots,v_n) = \mathbf{T} \iff \{x_i \mid v_i=\mathbf{T}\}\in [F]$.
      That is: a ZDD is a BDD. A path from the root to $\top$ is a satisfying assignment, except that skipped variables are assigned false.

### Decomposition of a set family

For every set family $F \subseteq \mathcal{P}(X)$ and $x\in X$, the following identity is true:

$$
F = F_0 \cup \{s \cup \{x\} \mid s\in F_1\}
$$

- $F_0 = \{s \mid s\in F, a \notin s\}$
- $F_1 = \{s-\{a\} \mid s\in F, a \in s\}$

### Operations

#### Binary operators

As two sets:

- union $F \cup G = \{s \mid s\in F \lor s\in G\}$  
- intersection $F \cap G = \{s \mid s\in F \land s\in G\}$  
- difference $F \setminus G = \{s \mid s\in F \land s\notin G\}$
- symmetric difference (exclusive-or) $F \Delta G = (F \setminus G) \cup (G \setminus F)$

As two sets of sets:

- meet: $F \sqcup G = \{ s \cup t \mid s\in F, t\in G\}$
- join: $F \sqcap G = \{ s \cap t \mid s\in F, t\in G\}$
- quotient: $F/G = \{s \mid \forall t\in G: (s\cup t \in F \land s\cap t=\emptyset) \}$
- remainder: $F \bmod G = F \setminus (G \sqcup (F/G))$

For a binary operator $\oplus$ and two ZDDs $F$ and $G$, the ZDD for $F \oplus G$ is

$$
\begin{aligned}
F \oplus G 
& = \{s | s\in F\oplus G, x\notin s\} + \{s\mid s\in F\oplus G, x\in s\}
\end{aligned}
$$

#### Unary operators

- insertion $a \cdot F = \{a\cup S \mid S\in F\}$
- deletion $F/a = \{S-\{a\} \mid S\in F\}$
- positive filtering $[a^1] F = \{S-\{a\} \mid S\in F, a\in    S\}$
- negative filtering $[a^0] F = \{S       \mid S\in F, a\notin S\}$

#### Counting

- $|F|$ count the number of elements $[F]$
    - set familes: number of subsets of $X$ in $[F]$.
    - boolean functions: number of satisfying assignments.
    - unate boolean algebra: number of products in $[F]$.
- $|\bot| = |\{\}| = 0$
- $|\top| = |\{\emptyset\}| = 1$
- $|(a,F_0,F_1)| = |\{S\mid S\in F_0\} \cup \{S\cup \{a\}\mid S\in F_1\}| = |F_0| + |F_1|$

## references

BDDs:

- [Binary decision diagram - Wikipedia](https://en.wikipedia.org/wiki/Binary_decision_diagram)
- [An Introduction to Binary Decision Diagrams -- Henrik Reif Andersen](http://www.cmi.ac.in/~madhavan/courses/verification-2011/andersen-bdd.pdf)
- [Logic in Computer Science: Modelling and Reasoning about Systems](https://dl.acm.org/doi/10.5555/975331) chapter 6 covers binary decision diagrams.

ZDDs:

- [Zero-suppressed decision diagram - Wikipedia](https://en.wikipedia.org/wiki/Zero-suppressed_decision_diagram)
- [An introduction to zero-suppressed binary decision diagrams -- Alan Mishchenko](http://people.eecs.berkeley.edu/~alanmi/publications/2001/tech01_zdd_.pdf)
- [Zero-suppressed BDDs and their applications -- Minato Shin-ichi](https://link.springer.com/article/10.1007/s100090100038)
  [alternative link](https://eprints.lib.hokudai.ac.jp/dspace/bitstream/2115/16895/1/IJSTTT3-2.pdf)
- [TAOCP vol 4A](https://www-cs-faculty.stanford.edu/~knuth/taocp.html)

Implementation:

- [the OCaml library, combine](https://github.com/backtracking/combine)
- [My DD library for learning purpose](https://github.com/hehelego/basic-decision-diagrams)
