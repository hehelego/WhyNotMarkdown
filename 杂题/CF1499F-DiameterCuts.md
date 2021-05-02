# CF-edu106Div2-DiameterCuts

[TOC]

## problem statement

给定一个$n$点的树$T$,和一个不超过$n-1$的正整数$k$.  
定义树上两点$u,v$的距离为,$T$中唯一连接$u,v$的路径上的边数$.  
定义一个图的直径为其中任意两点的距离的上确界.  

删掉$T$中的一些边,使得其分裂为一些较小的树,其中每个连通块的直径不超过$k$.  
求满足上述约束的删边的方案数量.如果两个方案删掉的边子集不同则称两个方案不同.  

## solution

首先转有根树.  


这类问题的套路是统一的,设$f(u,d)$表示仅考虑$subtree(u)$内,符合题目约束,并且切割后这个连通块到$u$最近/最远的点与它距离为$d$.  
对于一个点$u$,和其子树中的两个点$v_1,v_2$. 如果$LCA(v_1,v_2)\neq u$,那么会在更小的子问题中被处理好, 否则,我们只需要关心$v_1,v_2$到$u$的距离而不必考虑具体的路径. 要使得任意路径长度小于/大于$k$,我们需要关心$subtree(u)$中能走到$u$的点中离$u$最远/最近的点即可.

> 比如下面这个题  
>
> 给定一个树$T=(V,E)$,和点权$w:V\to \mathbb{Z}^+$,选一个$V$的子集$U$,  
> 使得$U$中任意两点距离不小于给定常数$k$,
> 最大化$\sum_{u\in U}w(u)$  
>
> 我们设$f(u,d)$表示仅考虑$subtree(u)$内的点,满足所选点两辆距离不小于$k$,并且选中的点中离$u$最近的那个距离为$d$(这个点可以$u$本身,此时$d=0$)  
> - 边界条件 $f(u,i)=[i=0]w(u)$ 是仅考虑$u$这个点
> - 状态转移: 设$u$的直接相邻的子节点为$son(u)=\{v_1,v_2\ldots v_m\}$  
> 依次加入考虑$subtree(v_1),subtree(v_2)\ldots subtree(v_m)$  
> 假设已经把$u,subtree(v_1)\ldots subtree(v_r)$纳入考虑,尝试加入$subtree(v_{r+1})$  
> 对于已有状态$f(u,i)$和新加入子树中的状态$f(v,j)$  
> 这样拼接过后,新产生了一些  
> "一个端点在$subtree(v_{r+1})$中,另一个端点在$\{u\}\cup subtree(v_1)\cup subtree(v_2)\ldots subtree(v_{r})$"   
> 的路径,其中最长的那个长度为$i+(j+1)$,我们需要$i+(j+1)$才能使得方案合法,  
> 这会转移到$f'(u,\max(i,j+1))\leftarrow f(u,i)+f(v,j)$  
> 
> 这样暴力转移,可以做到$O(nk^2)$

### part 1

设$f(u,d)$表示仅考虑$subtree(u)$中的点和边, 满足题目约束,与$u$连通的点和$u$的最大距离为$d$, 的方案计数.  

考虑新加入一个子树$subtree(v)$,  
- 切断$(u,v)$这条边, 那么$subtree(v)$中如何切割是不影响"与$u$连通的点和$u$的最大距离"的,有  
  $f'(u,i)\leftarrow f(u,i)\cdot \sum_{j=0}^k f(v,j)$
- 保留$(u,v)$这条边, 已有$f(u,i),f(v,j)$产生的最长新路径为$i+(j+1)$, 若满足$i+j+1\leq k$有  
  $f'(u,\max(i,j+1))\leftarrow (u,i)f(v,j)$

具体实现, 为了避免重复计算和计算顺序的讨论, 我们先把$f(u,\ast)$复制一份,按照转移方程重新计算后再写回去. 具体写法见`implementation > part 1`  
这样复杂度是$O(nk^2)$的,一个$T=(V,E)=([n],\{(1,i+1)\mid i\in [n-1]\})$ (其中$[n]=\{1,2,3\ldots n\}$) 的构造就可以跑满, 是不足以通过本题的.


### part 2

瓶颈在第二类状态转移的计算, 我们设$g(u,i)=\sum_{j\leq i}f(u,i)$.
1. 到$u$的最长路径,在$\{u\}\cup subtree(v_1)\ldots subtree(v_r)$内的取到.  
  $f'(u,i)\leftarrow f(u,i)g(v,\min(i-2,k-i-1))$
2. 到$u$的最长路径,在$subtree(v_{r+1})$内的取到.  
  $f'(u,i)\leftarrow g(u,\min(i-1,k-i))f(v,i-1)$
3. 两边的最长根链一样长,当$2i\leq k$时,有.
  $f'(u,i)\leftarrow f(u,i)f(v,i-1)$



这样就可以$O(nk)$计算了.  
实现见`implementation > part 2`,代码中合并了`1,3`.  

### part 3

这部分来自官方题解,是一个基于深度范围的优化.  
设$dep(u)=\max\{dis(u,v)\mid v\in subtree(u)\}$  
目前已经考虑了$v_1,\ldots v_r$,那么使得$f(u,i)$有效的$i$不超过$1+\max(dep(v_1),dep(v_2)\ldots dep(v_r))$  
而将要合并的子树$v_{r+1}$中,使得$f(v_{r+1},j)$有效的$j$不超过$dep(v_{r+1})$  
或者把$dep$放宽一点,用$size(u)=|subtree(u)|$也是可以的.

这样操作之后, 可以算出最坏情况总复杂度是$O(n^2)$的.  
考虑计算$f(u,\ast)$的复杂度, 这部分的消耗为  
$$
\sum_{v\in son(u)}dep(u)dep(v)\leq size(u)\sum_{v\in son(u)}size(v)\leq {\left(size(u)\right)}^2
$$

于是我们有

$$
\sum_{u\in T} {\left(size(u)\right)}^2
\leq
{\left(\sum_{u\in T} size(u)\right)}^2
=n^2
$$


## implementation


### part 1

```cpp
#include <bits/stdc++.h>
int read() {
  int x=0; char c;
  do{c=getchar();}while(!isdigit(c));
  do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
  return x;
}
const int N = 5000 + 10;
const int mod = 998244353;
int n, k;
std::vector<int> g[N];

// f(u,l)=count of cut, such that
//   1. the diameter of subtree(u) after cut is less than or equal to k
//   2. l == max dis(v,u)
//      for v over subtree(u)
//      where the path (u,v) does not contain cutted any edge.
int dp[N][N];
int tmp[N];

void dfs(int u, int f) {
  dp[u][0] = 1;
  for (int v : g[u]) {
    if (v == f) { continue; }
    dfs(v,u); std::copy(dp[u], dp[u] + k + 1, tmp);

    int s = 0;
    for (int j = 0; j <= k; j++) { s = (s + dp[v][j]) % mod; }
    // transition type 1
    for (int i = 0; i <= k; i++) { dp[u][i] = 1LL * tmp[i] * s % mod; }
    // transition type 2
    for (int i = 0; i <= k; i++) {
      for (int j = 0; j < k; j++) {
        if (i + j + 1 <= k) {
          int &t = dp[u][std::max(i, j + 1)];
          t = (t + 1LL * tmp[i] * dp[v][j]) % mod;
        }
      }
    }

  }

  // fprintf(stderr,"\nvertex %d\n", u);
  // for (int i = 0; i <= k; i++) {
  //   fprintf(stderr,"\tdp(%d)=%d\n", i, dp[u][i]);
  // }
}

int main() {
  n = read(); k = read();
  for (int i = 1; i < n; i++) {
    int x = read(), y = read();
    g[x].emplace_back(y);
    g[y].emplace_back(x);
  }

  dfs(1, 0);
  int ans = 0;
  for (int i = 0; i <= k; i++) { ans = (ans + dp[1][i]) % mod; }
  printf("%d\n", ans);
  return 0;
}
```

### part 2

```cpp
#include <bits/stdc++.h>
int read() {
  int x = 0;
  char c;
  do {
    c = getchar();
  } while (!isdigit(c));
  do {
    x = x * 10 + c - '0';
    c = getchar();
  } while (isdigit(c));
  return x;
}
const int N = 5000 + 10;
const int mod = 998244353;
int n, k;
std::vector<int> adj[N];

// f(u,l)=count of cut, such that
//   1. the diameter of subtree(u) after cut is less than or equal to k
//   2. l == max dis(v,u)
//      for v over subtree(u)
//      where the path (u,v) does not contain cutted any edge.
int f[N][N], g[N][N];
int cf[N], cg[N];

void dfs(int u, int fa) {
  g[u][0] = f[u][0] = 1;
  for (int i = 1; i <= k; i++) { g[u][i] = (g[u][i - 1] + f[u][i]) % mod; }

  for (int v : adj[u]) {
    if (v == fa) {
      continue;
    }
    dfs(v, u);
    std::copy(f[u], f[u] + k + 1, cf);
    std::copy(g[u], g[u] + k + 1, cg);

    // transition type 1
    for (int i = 0; i <= k; i++) f[u][i] = 1LL * f[u][i] * g[v][k] % mod;
    // transition type 2
    for (int i = 1; i <= k && k - 1 - i >= 0; i++) {
      int &t = f[u][i], r = std::min(i - 1, k - 1 - i);
      t = (t + 1LL * cf[i] * g[v][r]) % mod;
    }
    for (int i = 1; i <= k && k - i >= 0; i++) {
      int &t = f[u][i], r = std::min(i-1, k - i);
      t = (t + 1LL * f[v][i - 1] * cg[r]) % mod;
    }

    g[u][0] = f[u][0];
    for (int i = 1; i <= k; i++) { g[u][i] = (g[u][i - 1] + f[u][i]) % mod; }
  }
}
int main() {
  n = read();
  k = read();
  for (int i = 1; i < n; i++) {
    int x = read(), y = read();
    adj[x].emplace_back(y);
    adj[y].emplace_back(x);
  }

  dfs(1, 0);
  int ans = 0;
  for (int i = 0; i <= k; i++) {
    ans = (ans + f[1][i]) % mod;
  }
  printf("%d\n", ans);
  return 0;
}
```


### part 3

```cpp
#include <bits/stdc++.h>
int read() {
  int x = 0;
  char c;
  do {
    c = getchar();
  } while (!isdigit(c));
  do {
    x = x * 10 + c - '0';
    c = getchar();
  } while (isdigit(c));
  return x;
}
const int N = 5000 + 10;
const int mod = 998244353;
int n, k;
std::vector<int> g[N];

// f(u,l)=count of cut, such that
//   1. the diameter of subtree(u) after cut is less than or equal to k
//   2. l == max dis(v,u)
//      for v over subtree(u)
//      where the path (u,v) does not contain cutted any edge.
int dp[N][N];
int tmp[N];

int dfs(int u, int f) {
  int dep = 0; dp[u][0] = 1;
  for (int v : g[u]) {
    if (v == f) { continue; }
    int dis = dfs(v, u);
    std::copy(dp[u], dp[u] + k + 1, tmp);

    int s = 0;
    for (int j = 0; j <= dis; j++) { s = (s + dp[v][j]) % mod; }
    for (int i = 0; i <= dep; i++) { dp[u][i] = 1LL*tmp[i]* s % mod; }

    for (int i = 0; i <= dep; i++) {
      for (int j = 0; j <= dis; j++) {
        if (i + j + 1 <= k) {
          int &t = dp[u][std::max(i, j + 1)];
          t = (t + 1LL * tmp[i] * dp[v][j]) % mod;
        }
      }
    }
    dep = std::max(dep, dis + 1);

  }
  return dep;
}
int main() {
  n = read();
  k = read();
  for (int i = 1; i < n; i++) {
    int x = read(), y = read();
    g[x].emplace_back(y);
    g[y].emplace_back(x);
  }

  dfs(1, 0);
  int ans = 0;
  for (int i = 0; i <= k; i++) { ans = (ans + dp[1][i]) % mod; }
  printf("%d\n", ans);
  return 0;
}
```
