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

## TM recognizability

### complement of TM membership is undecidable

### mapping reduction

## time complexity

## space complexity

## MISC
