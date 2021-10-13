# note on CS101, data structure and algorithm

> ShanghaiTech SIST CS101

## expected comparision in randomized quicksort

### reference and links

[wikipedia: quicksort](https://en.wikipedia.org/wiki/Quicksort)

### problem statement

A permutation of $[n]=\{1,2,3\ldots n\}$ is choosen uniformly from all the permutations.

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
For $(1,n)$ they get compared if and only if the pivot is $1$ or $n$ when spliting the whole sequence.  
Generally for $(i,j)$ the comparision between then happens if and only if $k=i+1,i+2\ldots j-1,j$ is not selected as pivot before $i$ or $j$ is selected as pivot.(when $k>j$ is selected as a pivot, the pair is in the left subtree; while choosing $k<i$ as a pivot, the pair goes to the right subtree).  

Consider this scenario:  
Given a sequence $(a_1,a_2\ldots a_n)$ we repeatedly delete an element randomly, what is the probability that for all $k$ such that $i<k<j$, the time that $k$ get deleted is latter than the time for $i$ and the time for $j$.  

$(a_1\ldots a_{i-1})$ and $(a_{j+1}\ldots a_n)$ are redundant, we can ignore them.  
The problem becomes: given a sequence of $j-i+1$ elements, an element is uniformly random selected, what is the probability that the head or the tail is choosen.  
The answer is $\frac{2}{j-i+1}$  

Therefore, the expected number of comparisions is

$$
\begin{aligned}
\mathrm{E}\left(\text{comparison}\right)
&=\mathrm{E}\left(
\sum_{i=1}^n\sum_{j=i+1}^n
\text{compared}(i,j)
\right)\\
&=\sum_{i=1}^n\sum_{j=i+1}^n
\mathrm{E}\left(
\text{compared}(i,j)
\right)\\
&=\sum_{i=1}^n\sum_{j=i+1}^n
\mathrm{P}\left(
\text{compared}(i,j)
\right)\\
&=\sum_{i=1}^n\sum_{j=i+1}^n
\frac{2}{j-i+1}\\
&<\sum_{i=1}^n\sum_{j=1}^n\frac{2}{j}<2n(\ln n+1)
\end{aligned}
$$

## alternative solution


$$
\mathrm{E}\left[C(n)\right]=(n-1)+\frac{1}{n}\sum_{i=0}^{n-1} \mathrm{E}\left[C(i)+C(n-1-i)\right]
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
