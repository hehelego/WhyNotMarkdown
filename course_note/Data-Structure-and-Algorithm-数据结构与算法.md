# note on DSA

> - ShanghaiTech SIST CS101: Algorithm and Data Structures. Fall2021
> - ShanghaiTech SIST CS240: Design and Analysis of Algorithms. Spring2022
> - MIT 6.006: Introduction to Algorithms. OCW Spring2020
> - MIT 6.046: Design and Analysis of Algorithms. OCW Spring2015

## expected comparison in randomized quicksort

### reference and links

[wikipedia: quicksort](https://en.wikipedia.org/wiki/Quicksort)

### problem statement

A permutation of $[n]=\{1,2,3\ldots n\}$ is chosen uniformly from all the permutations.

```haskell
qsort::(Ord a)=>[a]->[a]
qsort [] = []
qsort (x:xs) = qsort lhs ++ [x] ++ qsort rhs
  where lhs = [y | y<-xs, y<=x]
  where rhs = [y | y<-xs, y>x]
```

what is the number of comparisons used on average.

### solution

The algorithm can be considered as building a BST from a random permutation.

when building the tree for `(x:xs)`, all the elements in `xs` is compared once with `x`.
`xs` then got split into two disjoint part `lhs,rhs` and no comparison across the two set is performed.

Consider $(i,i+1)$, they always get compared once.  
For $(1,n)$ they get compared if and only if the pivot is $1$ or $n$ when splitting the whole sequence.  
Generally for $(i,j)$ the comparison between then happens if and only if $k=i+1,i+2\ldots j-1,j$ is not selected as pivot before $i$ or $j$ is selected as pivot.(when $k>j$ is selected as a pivot, the pair is in the left subtree; while choosing $k<i$ as a pivot, the pair goes to the right subtree).  

Consider this scenario:  
Given a sequence $(a_1,a_2\ldots a_n)$ we repeatedly delete an element randomly, what is the probability that for all $k$ such that $i<k<j$, the time that $k$ get deleted is latter than the time for $i$ and the time for $j$.  

$(a_1\ldots a_{i-1})$ and $(a_{j+1}\ldots a_n)$ are redundant, we can ignore them.  
The problem becomes: given a sequence of $j-i+1$ elements, an element is uniformly random selected, what is the probability that the head or the tail is chosen.  
The answer is $\frac{2}{j-i+1}$  

Therefore, the expected number of comparisons is

$$
\begin{aligned}
\mathbb{E}\left(\text{comparison}\right)
&=\mathbb{E}\left(
\sum_{i=1}^n\sum_{j=i+1}^n
\text{compared}(i,j)
\right)\\
&=\sum_{i=1}^n\sum_{j=i+1}^n
\mathbb{E}\left(
\text{compared}(i,j)
\right)\\
&=\sum_{i=1}^n\sum_{j=i+1}^n
\Pr\left(
\text{compared}(i,j)
\right)\\
&=\sum_{i=1}^n\sum_{j=i+1}^n
\frac{2}{j-i+1}\\
&<\sum_{i=1}^n\sum_{j=1}^n\frac{2}{j}<2n(\ln n+1)
\end{aligned}
$$

### alternative solution

$$
\mathbb{E}\left[C(n)\right]=(n-1)+\frac{1}{n}\sum_{i=0}^{n-1} \mathbb{E}\left[C(i)+C(n-1-i)\right]
$$

and initial condition $T(1)=1,T(0)=0$

$$
\begin{aligned}
C_n
&=(n-1)+\frac{1}{n}\sum_{i=0}^{n-1}(C_i+C_{n-i-1})\\
&=(n-1)+\frac{2}{n}\sum_{i=0}^{n-1}C_i\\
nC_n
&=n(n-1)+2\sum_{i=0}^{n-1}C_i\\[2em]
nC_n-(n-1)C_{n-1}
&=n(n-1)-(n-1)(n-2)+2C_{n-1}\\
nC_n
&=2(n-1)+(n+1)C_{n-1}\\
\frac{C_n}{n+1}
&=\frac{C_{n-1}}{n}+\frac{2(n-1)}{n(n+1)}\\
&<\frac{C_{n-1}}{n}+\frac{2}{n}\\
&<\frac{C_{n-2}}{n-1}+\frac{2}{n-1}+\frac{2}{n}\\
&<\frac{C_{n-3}}{n-2}+\frac{2}{n-2}+\frac{2}{n-1}+\frac{2}{n}\\
&<\sum_{i=1}^n \frac{2}{i}\approx \int_1^n \frac{2}{x}\mathrm{d}{x}=2\ln n\\
C_n
&\approx 2n\ln n
\end{aligned}
$$

## Trick: Converting paths in directed graph to paths in undirected graph

Given a directed graph $G=(V,E)$, where $E\subseteq \{(u,v)\mid u,v\in V\}$.  
We can construct an undirected graph $G'=(V',E')$ where:

$$
\begin{aligned}
V'&= \{ v_{in}\mid v\in V\} \cup \{ v_{out} \mid v\in V\}\\
E'&= \{ \{u_{out},v_{in}\} \mid (u,v)\in E\}
\end{aligned}
$$

Then

- Every path $u\to v$ in $G$ corresponds to a path $u_{out}\to v_{in}$ in $G'$.  
- Every path $u_{out}\to v_{in}$ in $G'$ corresponds to a path $u\to v$ in $G$.  

Another way:

$$
\begin{aligned}
V^\ast&= \{v_0 \mid v\in V\}\cup \{ v_{in}\mid v\in V\} \cup \{ v_{out} \mid v\in V\}\\
E^\ast&= \{ \{u_{out},v_{in}\} \mid (u,v)\in E\} \cup \{\{v_{in},v_0\} \mid v\in V\} \cup \{\{v_0,v_{out}\} \mid v\in V\}
\end{aligned}
$$

### reduction examples

#### 3-SAT to independent set

#### 3-SAT to Hamilton Cycle

#### 3-SAT to 3-COLOR

## medians of medians

> Given a sequence $(a_1,a_2\ldots a_n)$ where the elements of distinct elements.  
> Find the $k$-th least element $x$ such that $k-1 = \sum_{i=1}^n [a_i < x]$.  

WLOG, let $5\mid n$.  
Divides the sequence into groups of fives:

$$
\begin{aligned}
B_1
&=(a_1,a_2,a_3,a_4,a_5)\\
B_2
&=(a_6,a_7,a_8,a_9,a_10)\\
B_i
&=(a_{5i-4},a_{5i-3},a_{5i-2},a_{5i-1},a_{5i})\\
&\ldots\\
B_{n/5}
&=(a_{n-4},a_{n-3},a_{n-2},a_{n-1},a_{n})\\
\end{aligned}
$$

Find the median of each group $B_i$ denoted by $b_i$.  
Find the median of $(b_1\ldots b_{n/5})$, which is the $(n/10)$-th least element in sequence $b$.  
Let $x$ be the median of medians.

Partition $a$ into $\{a_i \mid a_i <x\}\cup \{x\}\cup \{a_i \mid a_i >x\}$.  
Let $s=\sum_{i=1}^n [a_i \leq x]$

- $s=k$, $x$ is the desired $k$-th element
- $k<s$, recursively find $k$-th in LHS $\{a_i \mid a_i <x\}$
- $k>s$, recursively find $(k-s)$-th in RHS $\{a_i \mid a_i >x\}$

### key observation

We claim that the sets $L=\{a_i \mid a_i<x\}$,$R=\{a_i \mid a_i>x\}$
satisfy $\frac{3}{10}n\leq |L|,|R| \leq {7}{10}n$.  

Consider the groups $B_i$,
we have $\frac{n}{5} \times \frac{1}{2}$ groups $B_j$
such that the median within that group is less than $x$ i.e. $b_j < x$.  
In group $B_j$ we have at least $3$ elements less than $x$.  
That is $|L| \geq \frac{3n}{10}$.

For the same reason, we have $|R| \geq \frac{3n}{10}$.  
Therefore, $|L|,|R| \leq \frac{7n}{10}$.

### complexity

$$
T(n) \leq T\left( \frac{n}{5} \right) + T\left( \frac{7n}{10} \right) + O(n)
$$

This is in fact a linear algorithm.  
Let's verify it quickly, suppose that the $O(n)$ term is bounded by $an$ and $T(n)$ is bounded by $bn$.

$$
bn \leq \frac{1}{5}bn + \frac{7}{10}bn + an
\implies
b\leq \frac{a}{10}
$$

## Gaussian trick and Karatsuba's algorithm

$$
(a_1 x + a_0)(b_1 x + b_0)
=a_1b_1 x^2 + (a_1b_0 + a_0b_1)x + a_0b_0
$$

four multiplications

$$
(a_1+a_0)(b_1+b_0)
=a_1b_1 + (a_1b_0+a_0b_1) + a_0b_0
$$

three multiplications

use this recursively $T(n)=3T(n/2)+O(n)$

## Hall's theorem and Konig's theorem for bipartite-graph

two important theorems concerning the bipartite graph

- [wikipedia: Kőnig's theorem](https://en.wikipedia.org/wiki/Kőnig's_theorem_(graph_theory))
- [wikipedia: Hall's marriage theorem](https://en.wikipedia.org/wiki/Hall's_marriage_theorem)

**TODO:** proof of the frequently used theorem on bipartite graph

## The max-flow min-cut theorem

**TODO:** proof of the max-flow min-cut theorem

## Applications of the network flow problems

**TODO:**

## Examples of local search algorithms

- **TODO:** gradient descent algorithm
- **TODO:** Metropolis algorithm, Simulated-Annealing algorithm
- **TODO:** local-search max-cut 2-approximation

## Fundamental of randomized algorithms

- **TODO:** Markov's inequality
- **TODO:** Chernoff bound

## Examples of randomized algorithms

- **TODO:** random-partitioning 2-approximation for max-cut
- **TODO:** randomized quick sort
- **TODO:** Universal hashing (the 2-universal hashing)
- **TODO:** Perfect hashing
- **TODO:** False positive rate analysis of Bloom filter
- **TODO:** False positive rate analysis of Bloom filter
- **TODO:** The contraction algorithm for global-min-cut
- **TODO:** The $O(d! n)$ randomized algorithm for solving linear-programming

## Examples of approximation algorithms

- **TODO:** Set-Cover greedy $\ln(n)$ approximation
- **TODO:** Vertex-Cover greedy 2-approximation
- **TODO:** MST+shortcutting 2-approximation for metric-TSP
- **TODO:** Christofides $3/2$-approximation for metric-TSP
- **TODO:** Gonzalez's $2$-approximation for K-center problem
- **TODO:** list scheduling (LS) an 2-approximation for optimal scheduling
- **TODO:** Longest processing time (LPT) an $4/3$-approximation for optimal scheduling
