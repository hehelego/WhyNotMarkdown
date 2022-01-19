# SPOJ GSS7

## problem statement

- [SPOJ GSS7](https://www.spoj.com/problems/GSS7/)

> Given a tree with $N$ ($N \leq 100000$) nodes.
> Each node has a interger value $x_i$ ($|x_i| \leq 10000$).
>
> You have to apply $Q$ ($Q \leq 100000$) operations:
>
> - `1 a b`: answer the maximum contiguous sum from the path $a\to b$ (inclusive).
> - `2 a b c`: change all value in the path $a\to b$ (inclusive) to $c$($|c| \leq 10000$).
>
> **Input**:  
>
> 1. first line consists one interger $N$, the size of the tree.
> 2. next line consists $N$ interger $x_i$.
> 3. next $N-1$ line, each consists two interger $u,v$, means that $(u,v)$ is an edge in the tree.
> 4. next line consists one interger $Q$, the number of opertions.
> 5. next $Q$ line : `1 a b` or `2 a b c`.
>
> **Output**:  
> For each query, print the maximum contiguous sum on one line.

## intro

许多DP的转移(我们以一维的为例子)是如下形式:

$$
\mathrm{DP}_i=f\left\{ g(\mathrm{DP}_j,a_j) \mid j\leq i-1\right\}
$$

其中 $f$ 常常是 `max/min/sum` 等运算, 而 $g$ 常出现 `add/mul` 等运算.  

我们发现这种转移往往具有结合律的, 即:

$$
\begin{aligned}
&f(f(a,b),c)=f(a,f(b,c))\\
&f(
  f(  g(\mathrm{DP}_1,a_1), g(\mathrm{DP}_2,a_2)  ),
  g(\mathrm{DP}_3,a_3)
)=f(
  g(\mathrm{DP}_1,a_1),
  f(  g(\mathrm{DP}_2,a_2), g(\mathrm{DP}_3,a_3)  )
)
\end{aligned}
$$

这个结合性,允许我们使用一些辅助快速合并的数据结构维护或者使用分治算法.  
具体来说,是将一个常规DP转移,进行扩充,写成矩阵乘法的形式:

- 子问题/子状态 $\mathrm{DP}_i$ 扩充成一个 $k$ 维列向量
- 一个转移 $g(\mathrm{DP}_j,a_j)$ 扩充成一个 $k\times k$矩阵.  
  加入转移即左乘一个矩阵(这个矩阵乘法和添加转移一一对应, 具有我们熟悉$\mathbb{R}_{n\times n}$矩阵乘法的结合律)
- 使用数据结构或者分治算法计算转移

这样造出来的算法, 往往能支持进行各种修改之后快速重新计算转移, 是算法竞赛中出题的新套路(2018年附近), 国内称之为 `DDP/动态DP`.

## sol

回到这个题, 我们先搞一个$O(n)$单次的序列上dp来做.  

$$
\begin{cases}
f_i=\max(f_{i-1}+a_i,0)\\
g_i=\max(g_{i-1},f_i)
\end{cases}
$$

进行状态和状态转移改写, 首先是状态/子问题, 改写成列向量.

$$
\vec f
=\begin{bmatrix}
g_i\\
f_i\\
0
\end{bmatrix}
$$

对于$(f_{i-1},g_{i-1})\to (f_i,g_i)$ 即在末尾加一个 $a_i=v$ 的转移, 改写成.
(对于此题的数据范围, 用 $\infty=2^{30}\gt 10^9$ 就没问题)

$$
A_v=\begin{bmatrix}
0       & v       & -\infty\\
-\infty & v       & 0\\
-\infty & -\infty & 0
\end{bmatrix}
$$

我们考虑一个初值, 和单位矩阵(即不变转移).

$$
\vec f
=\begin{bmatrix}
-\infty \\
0 \\
0
\end{bmatrix}
\qquad
I=\begin{bmatrix}
0&-\infty       & -\infty\\
-\infty&0       & -\infty\\
-\infty&-\infty & 0
\end{bmatrix}
$$

用线段树维护区间转移矩阵乘法.  

对于修改一段区间的操作, 乘积自然变成矩阵的幂, 在线段树上面划分$O(\log n)$段,做修改并打标记.
查询时下传标记, 并做出相应的修改和计算操作.  

对于树上问题, 使用HLD划分成序列上问题.  
**note** 转移方程定义出的乘法是没有交换律的, 所以计算时, 要按照dfs序递增/递减方向的乘法.

## code

```cpp
#include <bits/stdc++.h>
const int N = 100000 + 10;
const int K = 3;
typedef int Int;
const int INF = int(1e9) + 10;
int read() {
  int x = 0, f = 1;
  char c;
  do { c = getchar(); if (c == '-') f = -1; } while (!isdigit(c));
  do { x = x * 10 + c - '0'; c = getchar(); } while (isdigit(c));
  return x * f;
}
struct Matrix {
  Int a[K][K];
  Int &operator()(int i, int j) { return a[i - 1][j - 1]; }
  Int operator()(int i, int j) const { return a[i - 1][j - 1]; }
  Matrix() {}
  ~Matrix() {}
};
inline Matrix identity() { // identity matrix
  Matrix a;
  a(1, 1) = 0, a(1, 2) = -INF, a(1, 3) = -INF, a(2, 1) = -INF;
  a(2, 2) = 0, a(2, 3) = -INF;
  a(3, 1) = -INF, a(3, 2) = -INF, a(3, 3) = 0;
  return a;
}
inline Matrix cons(Int v) {
  Matrix a;
  a(1, 1) = 0, a(1, 2) = v, a(1, 3) = -INF;
  a(2, 1) = -INF;
  a(2, 2) = v, a(2, 3) = 0;
  a(3, 1) = -INF, a(3, 2) = -INF, a(3, 3) = 0;
  return a;
}
Int max3(Int a, Int b, Int c) { return std::max(a, std::max(b, c)); }
Matrix operator*(const Matrix &a, const Matrix &b) {
  Matrix c;
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) c(i, j) = std::max(-INF, max3(a(i, 1) + b(1, j), a(i, 2) + b(2, j), a(i, 3) + b(3, j)));
  }
  return c;
}
Matrix qpow(Matrix a, int p) {
  Matrix r = identity();
  while (p) {
    if (p & 1) r = r * a;
    a = a * a, p >>= 1;
  }
  return r;
}

typedef std::pair<int, int> Pair;
int a[N], b[N];
Pair tag[N << 2];
Matrix t[2][N << 2];
inline void pushup(int o) {
  int lc = o << 1, rc = lc | 1;
  t[0][o] = t[0][lc] * t[0][rc];
  t[1][o] = t[1][rc] * t[1][lc];
}
inline void pushdown(int o, int L, int R) {
  int mid = (L + R) >> 1, lc = o << 1, rc = lc | 1;
  if (L == R || tag[o].first == 0) return;
  Matrix tmp = cons(tag[o].second);
  tag[lc] = tag[o], t[0][lc] = t[1][lc] = qpow(tmp, mid - L + 1);
  tag[rc] = tag[o], t[0][rc] = t[1][rc] = qpow(tmp, R - mid);
  tag[o] = Pair(0, 0);
}
void build(int o, int l, int r) {
  if (l == r) {
    t[0][o] = t[1][o] = cons(b[l]);
    tag[o] = Pair(0, 0);
    return;
  }
  int mid = (l + r) >> 1, lc = o << 1, rc = lc | 1;
  build(lc, l, mid), build(rc, mid + 1, r);
  pushup(o);
}
Matrix qry(int qwq, int o, int L, int R, int l, int r) {
  if (L > r || R < l) return identity();
  if (l <= L && R <= r) return t[qwq][o];
  pushdown(o, L, R);
  int mid = (L + R) >> 1, lc = o << 1, rc = lc | 1;
  Matrix ql = qry(qwq, lc, L, mid, l, r), qr = qry(qwq, rc, mid + 1, R, l, r);
  return qwq ? qr * ql : ql * qr;
}
void upd(int o, int L, int R, int l, int r, int v) {
  if (L > r || R < l) return;
  if (l <= L && R <= r) {
    tag[o] = Pair(1, v);
    t[0][o] = t[1][o] = qpow(cons(v), R - L + 1);
    return;
  }
  pushdown(o, L, R);
  int mid = (L + R) >> 1, lc = o << 1, rc = lc | 1;
  upd(lc, L, mid, l, r, v), upd(rc, mid + 1, R, l, r, v);
  pushup(o);
}

std::vector<int> g[N];
int fa[N], size[N], son[N], dep[N];
int top[N], dfn[N], idx;
void dfs1(int u, int f) {
  dep[u] = dep[fa[u] = f] + 1;
  size[u] = 1;
  for (int v : g[u]) {
    if (v == f) continue;
    dfs1(v, u);
    size[u] += size[v];
    if (size[v] > size[son[u]]) son[u] = v;
  }
}
void dfs2(int u, int f) {
  b[dfn[u] = ++idx] = a[u], top[u] = f;
  if (son[u]) dfs2(son[u], f);
  for (int v : g[u]) {
    if (dfn[v] == 0) dfs2(v, v);
  }
}
void update(int x, int y, int v) {
  while (top[x] != top[y]) {
    if (dep[top[x]] < dep[top[y]]) std::swap(x, y);
    upd(1, 1, n, dfn[top[x]], dfn[x], v);
    x = fa[top[x]];
  }
  if (dep[x] < dep[y]) std::swap(x, y);
  upd(1, 1, n, dfn[y], dfn[x], v);
}
Matrix qry(int o, int l, int r) { return qry(o, 1, 1, n, l, r); }
Int sol(int x, int y) {
  Matrix A = identity(), B = identity();
  while (top[x] != top[y]) {
    if (dep[top[x]] < dep[top[y]]) {
      B = qry(0, dfn[top[y]], dfn[y]) * B;
      y = fa[top[y]];
    } else {
      A = A * qry(1, dfn[top[x]], dfn[x]);
      x = fa[top[x]];
    }
  }
  if (dep[x] < dep[y]) B = qry(0, dfn[x], dfn[y]) * B;
  else A = A * qry(1, dfn[y], dfn[x]);
  Matrix ret = A * B;
  return std::max(ret(1, 2), ret(1, 3));
}

int main() {
  int n = read();
  for (int i = 1; i <= n; i++) a[i] = read();
  for (int i = 1, a, b; i < n; i++) {
    a = read(), b = read();
    g[a].push_back(b), g[b].push_back(a);
  }
  dfs1(1, 1), dfs2(1, 1), build(1, 1, n);

  int m = read();
  while (m--) {
    int o = read(), x = read(), y = read();
    if (o == 1) printf("%d\n", std::max(Int(0), sol(x, y)));
    else update(x, y, read());
  }
  return 0;
}
```
