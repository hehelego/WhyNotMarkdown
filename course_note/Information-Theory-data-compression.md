# EE142 Information Theory Course Note part 2: source coding and channel coding

## Source Coding and Data Compression


### Discrete Memoryless Source (DMS)

### Terminologies

- source: a discrete-time integer-valued stochastic process $X_1,X_2\ldots$
- discrete memoryless source (DMS): $X_1,X_2\ldots\stackrel{iid}{\sim} p(X)$
- symbol: let $\mathcal{X}$ be the support of $X_i$, every $x\in\mathcal{X}$ is called a symbol.
- alphabet: a finite set $D$, most of the time we choose $D=\{0,1\}$ for binary encoding.
- code: $C:\mathcal{X} \to D^*$, maps a symbol to a codeword.
- extension: $C^*:\mathcal{X}^* \to D^*$ where $x_1x_2\cdots x_n \mapsto C(x_1)C(x_2)\cdots C(X_n)$.
- code hierarchy: (strict subset relation)

  1. singular: $\exists x_0,x_1\in\mathcal{X} . x_0\neq x_1 \land C(x_0)=C(x_1)$,
     the code mapping is not injective
  2. non-singular: $\forall x_0,x_1\in\mathcal{X} . x_0\neq x_1\to C(x_0)\neq C(x_1)$,
     the code mapping is injective.
  3. uniquely decodable: $\forall s_0,s_1\in \mathcal{X}^* . s_0\neq s_1 \to C^*(s_0)\neq C^*(s_1)$,
     the extension mapping is injective.
  4. prefix-free: $\forall x_0,x_1\in\mathcal{X} . x_0\neq x_1 \to \lnot \operatorname{prefix}(C(X_0),C(X_1))$
     where $\operatorname{prefix}(x,y)$ determines if $x$ is a prefix of $y$.

- Simply algorithm to determine uniquely decodable codes:

  1. Enumerate pairs $a,b\in\mathcal{X}$ that $a\neq b$.
  2. Construct two regular expression
     $$
     r_a = C(a) \circ {\left( \bigcup_{x\in\mathcal{X}} C(x)\right)}^*
     \quad
     r_b = C(b) \circ {\left( \bigcup_{x\in\mathcal{X}} C(x)\right)}^*
     $$
  3. Reject if $r_a\cap r_b \neq \varnothing$
  4. Accept the code $C(x)$

- Efficient algorithm for determine uniquely decodability [Sardinas–Patterson algorithm - Wikipedia](https://en.wikipedia.org/wiki/Sardinas–Patterson_algorithm)
- code length: $l:\mathcal{X}\to\mathbb{N}$ where $l(x)=|c(x)|$.
- expected length: $L(C)=\mathbb{E}\left[l(X)\right]=\sum_x p(x)l(x)$.

The task of source coding is:

1. Given a DMS that generates symbols from PMF $p(X)$.
2. Design a code $C(X)$ that is prefix-free or uniquely decodable.
3. Find $C(X)$ that minimizes $L(C)$.

### Fixed-length Code

Use $L$ bits to encode every symbol.

$$
D^L \geq |\mathcal{X}|
\implies
L=\lceil \log_D |\mathcal{X}|\rceil < \log_D |\mathcal{X}| + 1
$$

Block coding: Every $n$ symbols forms a group. Use $L$ bits to encode groups.

$$
D^L \geq |\mathcal{X}^n|
\implies
L=\lceil n\log_D |\mathcal{X}|\rceil < n\log_D |\mathcal{X}| + 1
$$

The average code length $L(C)=L/n$

$$
\log_D \mathcal{X} \leq \frac{L}{n} < \log_D |\mathcal{X}| + \frac{1}{n}
\implies
\lim_{n\to\infty} L(C) = \log_D |\mathcal{X}|
$$

### Variable-length Code

Preliminary

- WLOG, let $D=\{0,1,2,\ldots,|D|-1\}$.
- [Trie - Wikipedia](https://en.wikipedia.org/wiki/Trie)

Every code $C:\mathcal{X} \to D^*$,
can be represented by a $|D|$-ary trie structure the codewords $\{C(x) \mid x\in \mathcal{X}\}$.

The prefix tree of prefix-free codes:  

- For every symbol $x\in\mathcal{X}$,
  the path from the root node to $C(x)$ contains no other codewords.
- For every symbol $x\in\mathcal{X}$,
  the sub tree of $C(x)$ contains no other codewords.

A quantitative description of the prefix-free property give rise to the Kraft inequality.

### Kraft–McMillan Inequality


For a code $C$ and its codewords trie $T$,
assign an interval $[l_u,r_u]$ for every node $u\in T$.

1. Assign $[0,1]$ for the root of the tree.
2. If $[l_u,r_u]$ is assigned to $u$,
   then assign $\left[l_u+\frac{k}{|D|}(r_u-l_u), l_u+\frac{k+1}{|D|}(r_u-l_u)\right]$ to $\operatorname{child}(u,k)$.  
   That is: evenly divide the interval into $|D|$ segments, assign them to children.

If $C$ is prefix-free,
the intervals assigned to codeword nodes cover a subset of $[0,1]$.  
The interval of a node at depth $d$ is of length ${|D|}^{-d}$.  
Therefore:

$$
\sum_{x\in \mathcal{X}} {|D|}^{-l(x)} \leq 1
$$

The equality hold if and only if the intervals of codeword nodes form a partition of $[0,1]$.
Or equivalently, the codewords trie is a full $D$-ary tree.

- prefix code implies Kraft Inequality hold
- Kraft inequality hold, a prefix code exists.

The converse of this inequality is also hold:  

Suppose that for $l_1,l_2,\ldots,l_n$

$$
\sum_{i=1}^{n} {|D|}^{-l_i} \leq 1
$$

Then a $|D|$-ary prefix-free code $C:\{1,2,\ldots,n\}\to D$ can be constructed.

**Caveat**:
It is possible that $l(x_1),l(x_2)\ldots l(x_n)$ satisfy the kraft inequality
yet the code $C(x_1),C(x_2)\ldots C(x_n)$ is not prefix-free.

**Extension**: For uniquely decodable codes,
Kraft inequality and code existence theorem are also true.

See [Kraft–McMillan inequality - Wikipedia](https://en.wikipedia.org/wiki/Kraft–McMillan_inequality).  
See [Segment tree - Wikipedia](https://en.wikipedia.org/wiki/Segment_tree) for more insight into the Kraft inequality.

### Lower Bound of Source Coding (DMS)

- A DMS that generate $X\sim p(X)$ from $\{1,2,\ldots,m\}$
- The code alphabet is $\{1,2,\ldots,D\}$
- The codeword length are $l_i=|c(i)|$

Use Lagrange multiplier to find the lower bound of expected code length.  
See [Lagrange multiplier - Wikipedia](https://en.wikipedia.org/wiki/Lagrange_multiplier).

$$
\text{minimize} \sum_{i=1}^{n} p_i l_i
\quad
\text{subject to} \sum_{i=1}^{n} D^{-l_i} = 1
$$

Construct the Lagrangian function:

$$
\mathcal{L}(\vec{l},\lambda) = \sum_{i=1}^{n} p_i l_i - \lambda \left(\sum_{i=1}^{n} D^{-l_i} -1\right)
$$

Let

$$
\begin{cases}
\frac{\partial}{\partial l_i} \mathcal{L}(\vec{l},\lambda) = p_i + \lambda D^{-l_i}\ln D = 0 \\
\sum_{i=1}^{n} D^{-l_i} = 1
\end{cases}
$$

The solution is

$$
\begin{cases}
\lambda = -\frac{1}{\ln D} \\
l_i = - \log_D p_i = \log_D \frac{1}{p_i}\\
\end{cases}
\implies
L^\ast = \sum_{i=1}^{n} p_i \log_D \frac{1}{p_i} = H_D(X)
$$

In DMS source coding, the lower bound of expected code length is the entropy of the source.  
Such lower bound can be achieved if and only if $l_i = -\log_D p_i$ is an integer for every symbol $i$.

Consider the difference between expected code length and entropy:

$$
\begin{aligned}
L(C) - H_D(X)
&= \sum_{i=1}^{n} p_i l_i - \sum_{i=1}^{n} p_i \log_D \frac{1}{p_i}\\
&= \sum_{i=1}^n p_i \log_D D^{l_i} + \sum_{i=1}^{n} p_i \log_D p_i\\
&= \sum_{i=1}^n p_i \log_D \frac{p_i}{D^{-l_i}}\\
\end{aligned}
$$

Let $S = \sum_{j=1}^{n} D^{-l_i}\leq 1$, $q_i = D^{-l_i}/S$

$$
\begin{aligned}
L-H
&= \sum_{i=1}^n p_i \log_D \left( \frac{p_i}{q_i} \cdot \frac{1}{S}\right)\\
&= \sum_{i=1}^n p_i \log_D \frac{p_i}{q_i} + \sum_{i=1}^{n} p_i \log_D \frac{1}{S}\\
&= D_{KL}(p||q) + \log_D \frac{1}{S}\\
&\geq 0
\end{aligned}
$$

Equality hold iff $p_i=q_i \land S=1$, that is $p_i=D^{-l_i}$.

### Roof/Ceil Code

For $p(X) = (p_1,p_2,\ldots,p_n)$.
$l_i^\ast = -\log_D p_i$ might not be an integer.
Round it to roof/ceiling by letting $l_i = \lceil -\log_D p_i \rceil$.

Verify that these code length satisfies the Kraft inequality.

$$
\sum_{i=1}^n D^{-l_i}
=\sum_{i=1}^n D^{-\lceil -\log_D p_i \rceil}
\leq \sum_{i=1}^n D^{\log_D p_i}
= \sum_{i=1}^n p_i = 1
$$

The expected code length is

$$
L_{ceil}=\sum_{i=1}^n p_i \lceil -\log_D p_i \rceil
< \sum_{i=1}^n p_i (-\log_D p_i + 1)
= H_D(X) + 1
$$

The expected code length of roof/Ceil code gives a upper bound of optimal code length.

$$
H_D(X) \leq L^\ast \leq H_D(X) + 1
$$

- lower bound: relaxed source coding problem, non-integer code length solutions are allowed
- upper bound: roof/ceil code length

Similar to the case for Fixed-length code,
by grouping every $k$ symbols to gether

$$
k H_D(X) \leq L_{ceil} \leq k H_D(X) + 1
\implies
L_{ceil} \leq H_D(X) + \frac{1}{k}
$$

which converges to $H_D(X)$ i.e., the lower bound of DMS source coding.

### Shannon–Fano–Elias Code

**TODO**

### Huffman Code

Huffman code finds the optimal integer solution of source coding problem

$$
\text{minimize} \sum_{i=1}^{n} p_i l_i
\quad
\text{subject to} \sum_{i=1}^{n} D^{-l_i} = 1
\quad
\text{where}\ l_i \in \mathbb{N}
$$

#### Huffman Tree Algorithm

$D$-ary Huffman tree construction gives a $D$-ary full tree which has $1+k(D-1)$ nodes.  
So the number of symbols $n$ must satisfy $n \equiv 1 \pmod {D-1}$.  
Add zero probability dummy symbols to make sure $n \equiv 1\pmod{D-1}$.

1. Combine $D$ symbols of least probability to form a super-symbol.
2. Repeat step 1 until only one super symbol remains.
3. Assign codewords for each leaf node i.e., all the word nodes.

#### Optimality of Huffman Code

The optimality of Huffman code can be proved by induction.

**TODO**

### Universal Codes

See [Lempel–Ziv–Welch - Wikipedia](https://en.wikipedia.org/wiki/Lempel–Ziv–Welch)

## Channel Coding and Error Correction

**TODO**
