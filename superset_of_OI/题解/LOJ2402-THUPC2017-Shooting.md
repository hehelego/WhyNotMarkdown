# THUPC2017 Shooting: 天天爱射击

## problem statement

- source: [loj 2402](https://loj.ac/p/2402)

Two positive integers $n,m$ are given first.
Then we have $n$ intervals $[l_i,r_i]$ where $1\leq l_i\leq r_i\leq X$ and $l_i,r_i\in \mathbb{N}$.
Each interval has an associated number $s_i$.  

Then, we have to carry out $m$ operations.
In each operation $j$ an interger $x_j\in [1,X]$ is given.
For all interval $[l_i,r_i]$ such that $x_j\in [l_i,r_i]$, let $s_i\gets s_i-1$.  
We are required to remove intervals such that the corresponding $s_i$ is $0$ and return the number of removed intervals.

In this problem, we have $X=2\times 10^5$, $n,m\leq X$

## An offline algorithm: `divide and conquer + binary search`

For each interval $[l_i,r_i]$, we can use binary search to find the time $t_i$, when $s_i$ becomes $0$:  
$\forall j\in [1,m]$, if $\sum_{k=1}^j \mathbf{I}\left[ x_k \in [l_i,r_i] \right]\geq s_i$, then $t_i\leq k$, otherwise $t_i>k$.  
After finding all the $t_i$s, the number of intervals removed in $j$-th operation is $\sum_{i=1}^n \mathbf{I}[t_i=j]$.

Use some fancy data structure, we can have a $O(m\cdot n\log n)$ time brute-force solution.  
Now let's try to reduce the redundant computation.

1. We can start with $S=\{1,2,3\ldots n\}$.
2. Pick a time $j$. Add $x_1,x_2\ldots x_j$ into certain data structure.  
   We can use BIT/SegmentTree/BST or any other DS that support range sum query.
3. Partition $S$ into $S_l,S_r$ where $S_l=\{i\in S\mid t_i\leq j\}$ and $S_r=\{i\in S\mid t_i>j\}$.  
   For every $i\in S$, we do a range sum query on $[l_i,r_i]$ if the result is larger than $s_i$ then $i\in S_l$, otherwise $i\in S_r$.
4. Recursively solve two subproblems:  
   - Forevery $i\in S_r$, find $t_i'$ such that $t_i=t_i'+j$ where $j\in [1,m-j]$  
     We firstly solve this subproblem, do not remove the $x_j$s from the DS.
   - Forevery $i\in S_r$, find $t_i$ in $[1,j]$.  
     After we have solved the previous subproblem, we remove $x_1\ldots x_j$s from that DS,
     and dive into this subproblem.

Suppose that we use a BST to store the $s_i$s i.e. insertion/deletion/range-query takes $O(\log X)$ time,
this algorithm takes $O\left((n+m)\log n\log X\right)$ time:  
We can draw the recursive tree where each node on that tree is $(T,L,R)$,  
representing a subproblem. ($T\subseteq S, 1\leq L\leq R\leq X$).  
For $(T,L,R)$ we want to decide $t_i$ for each $i\in T$ with the knowledge that $L\leq t_i\leq R$.  

- For every interval $([l_i,r_i]; s_i)$, there is a chain $(S,1,n)\to (\{i\},t_i,t_i)$  
  We have to run a range sum query on each node within that chain,  
  this spends $O(m\log n\cdot \log X)$ time.
- For every $x_j$, we do an insertion and deletion for $x_j$ in all subproblems $(T,L,R)$ where $j\in [L,R]$  
  This spends $O(n\log n\cdot \log X)$ time.

This trick is called `整体二分` in chinese competitive programming community.

## code

```cpp
#include <bits/stdc++.h>

int read() {
  int x = 0, c = '\0';
  do { c = getchar(); } while (!isdigit(c));
  do { x = x * 10 + c - '0', c = getchar(); } while (isdigit(c));
  return x;
}

const int X = 200000;
const int N = X + 10;

void add(int x, int v);
int qry(int l, int r);

int x[N], ans[N];
struct Interval {
  int l, r, s, t;
} t[N];
void solve(int tl, int tr, int sl, int sr) {
  if (tl >= tr || sl >= sr) return;
  if (sr - sl == 1) {
    add(x[sl], 1);
    for (int i = tl; i < tr; i++) {
      if (qry(t[i].l, t[i].r) >= t[i].s) t[i].t = sl;
    }
    add(x[sl], -1);
    return;
  }

  int smid = (sl + sr) >> 1;
  for (int i = sl; i < smid; i++) add(x[i], 1);

  int pl = tl, pr = tr - 1, tmid = 0;
  while (pl < pr) {
    while (qry(t[pl].l, t[pl].r) < t[pl].s && pl < pr) pl++;
    while (qry(t[pr].l, t[pr].r) >= t[pr].s && pl < pr) pr--;
    if (pl < pr) std::swap(t[pl], t[pr]);
  }

  for (tmid = tl; tmid < tr && (qry(t[tmid].l, t[tmid].r) < t[tmid].s); tmid++) {}
  for (int i = tmid; i < tr; i++) t[i].t = smid - 1;
  solve(tl, tmid, smid, sr);

  for (int i = sl; i < smid; i++) add(x[i], -1);
  solve(tmid, tr, sl, smid);
}
int main() {
  int n = read(), m = read();
  for (int i = 0; i < n; i++) t[i].l = read(), t[i].r = read(), t[i].s = read(), t[i].t = X;
  for (int i = 0; i < m; i++) x[i] = read();

  solve(0, n, 0, m);
  for (int i = 0; i < n; i++) ans[t[i].t]++;

  for (int i = 0; i < m; i++) printf("%d\n", ans[i]);
  return 0;
}

// Fenwick Tree or BinaryIndexTree
int _t[N];
inline int lowbit(int x) { return x & (-x); }
void add(int x, int v) {
  while (x <= X) { _t[x] += v; x += lowbit(x); }
}
int qry(int x) {
  int y = 0;
  while (x) { y += _t[x]; x ^= lowbit(x); }
  return y;
}
int qry(int l, int r) { return qry(r) - qry(l - 1); }
```
