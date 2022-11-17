# Note: Introduction to the Theory of Computation

> Note on CS244@ShanghaiTech Fall 2022  
> resources:
> - textbook: Michael Sipser _Introduction to the Theory of Computation_
> - textbook: 

## regular language and finite automata

### the equivalence RL=NFA

- construct a NFA for every regular language
- convert a NFA to regular language: GNFA, state reduction

### regular language closure property

- union
- intersection
- complement
- concatenation
- Kleen closure

### pumping lemma

### Myhill-Nerode theorem

### DFA minimization

## context free language and pushdown automata

### Chomsky normal form of CFG

### CFL closure property

### non-deterministic PDA and CFG equivalence

### deterministic CFL and deterministic PDA

#### DCFG, DK test

#### DPDA computability

- DCFL is a proper subset of inherently unambiguous CFL
- regular language is a proper subset of DCFL

#### DCFG closure property

- closed under complement

## recursive enumerable language, Turing machine

### TM enumerator and TM recognizer equivalence

### LBA (linear bounded automata) and context sensitive language equivalence

## TM decidability

### TM membership undecidable

### Turing reduction

### computation history method

#### universality of CFL is undecidable

#### the PCP problem

### Rice theorem

For a property $P$

- Definition of a property: A subset over all Turing machine.
- Non-trivial: $P$ is the non-empty and non-universal $P,\overline{P}\neq \varnothing$.
- Fair: For every pair of TM $M_1,M_2$ if $L(M_1)=L(M_2)$ then $M_1\in P \iff M_2\in P$.

If $P$ is a non-trivial and fair property of Turing machines,
then the language $P$ (determine whether a Turing machine has property $P$) is undecidable.

#### Idea:

Reduce from TM membership problem.  
For TM $M$ and string $w$, construct another TM $N$
such that $N \in P \iff \langle M,w\rangle \in \mathrm{A}_{TM}$.

```python
def TM_membership(M,w):
  if has_property_p(N(M,w)):
    return true
  else:
    return false
```

#### First attampt

Find two TMs $U,V$ such that $U\in P,V\not\in P$.

```python
def N(M,w):
  # Turing machine N on input x
  def constructed_tm(x):
    if M(w):
      return U(x)
    else:
      return V(x)
  return constructed_tm
```

The problem is that $M$ on $w$ may not terminate:
When $M$ on $w$ loops, $V(x)$ shall also reject.  
Fix: $V$ rejects every input $x$, $L(V)=\varnothing$.

#### Another issue

It is possible that by setting $L(V)=\varnothing$, we makes $V\in P$.

The work around is simple:

- If $V\not\in P$, use the construction in previous section.
- If $V\in P$, use $Q=\overline{P}$ so that $V\not\in Q$. Find $U\in Q$.  
  Reduce the previous case.

## TM recursion theorem

### A TM that print it self

An implementation in python-3.10

```python
def A(): global w; w='def B(): r=f"def A(): global w; w={chr(39)}{w}{chr(39)}"; print(r); print(w); print("A()"); print("B()")'
def B(): r=f"def A(): global w; w={chr(39)}{w}{chr(39)}"; print(r); print(w); print("A()"); print("B()")
A()
B()
```

- Part $A$: Clear the input tape. Print the description of $B$.
- Part $B$:
  1. Read the input tape $w$ and compose the description of $A$.
  2. Print the description of a Turing machine that
     runs $A$ and print $w$.
- SELF: Run $A$ then run $B$.

### the recursion theorem

For every computable function $t:\Sigma^*\times \Sigma^*\to \Sigma^*$
which can be computed by Turing machine $T$,
exists a computable function $r:\Sigma^*\to \Sigma^*$ such that
$\forall w\in \Sigma^*\ r(w)=t(\langle R \rangle, w)$

That is: a Turing machine can obtain its description and carry out computation with it.

$R$ can be constructed with an approach similar to the one for **SELF**.

### fixed point theorem

For every computable function $t:\Sigma^*\times \Sigma^*\to \Sigma^*$,
eixsts a Turing machine $M$ such that
the Turing machine $M'=t(\langle M\rangle)$ is equivalent to $M$
that is: $L(M')=L(M)$

Simple construction: $M$ on input $w$

1. Obtain the description $\langle M \rangle$.
2. Compute $N=f(M)$.
3. Simulate $N$ on the input $w$.

## TM recognizability

### complement of TM membership is undecidable

### mapping reduction

## time complexity

## space complexity

## MISC
