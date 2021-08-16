# Codeforces Round 734(Div. 3) F: Equidistant Vertices

## problem statement

[CF 1551F](https://codeforces.com/contest/1551/problem/F)

Given a (unrooted) tree of $n$ vertices which are numbered from $1$ to $n$.  
The distance between a pair of two vertices $(u,v)$ is defined as the number of edges in the unique path from $u$ to $v$.  
Evaluate the size of set $S$

$$
\begin{aligned}
S_c &= \{T\subseteq [n]:\quad |T|=k, \forall (u,v)\!\in\! T\times T\ (u\!\neq\! v\to \mathrm{dis}(u,v)\!=\!c)\}\\
S &= \bigcup_{i=1}^{+\infty} S_i
\end{aligned}
$$

It is guaranteed that $2\leq k\leq n$

## solution

(For $k=2$, the answer is $\binom{n}{2}=\frac{n(n-1)}{2}$.)

## part 1: the lemma

**Intuition**: there exists a unique vertex $x$ such that all the $k$ vertices have equal distance to $x$

For $k\geq 3$, Let $u,v,w$ be three vertices such that $\mathrm{dis}(u,v)=\mathrm{dis}(v,w)=\mathrm{dis}(w,u)=c$.  
Make $u$ the root of the tree, so techniques for rooted trees can be applied to this problem.

- $\mathrm{lca}(v,w)=u$.  
  $c=\mathrm{dis}(v,w)=\mathrm{dis}(v,u)+\mathrm{dis}(u,w)=2c$. Impossible.
- $\mathrm{lca}(v,w)=v$ (or $\mathrm{lca}(v,w)=w$)  
  $c=\mathrm{dis}(u,w)=\mathrm{dis}(u,v)+\mathrm{dis}(v,w)=2c$. Impossible.
- $\mathrm{lca}(v,w)=p$, where $p\not\in\{u,v,w\}$  

$$
\begin{aligned}
&\begin{cases}
c=\mathrm{dis}(u,v)=\mathrm{dis}(u,p)+\mathrm{dis}(p,v)\\
c=\mathrm{dis}(u,w)=\mathrm{dis}(u,p)+\mathrm{dis}(p,w)
\end{cases}\\
&\implies \mathrm{dis}(p,v)=\mathrm{dis}(p,w)\\
&\text{let}\ d=\mathrm{dis}(p,v)=\mathrm{dis}(p,w)\\
&\begin{cases}
c=\mathrm{dis}(v,w)=\mathrm{dis}(v,p)+\mathrm{dis}(p,w)=2d\\
c=\mathrm{dis}(u,v)=\mathrm{dis}(u,p)+\mathrm{dis}(p,v)=\mathrm{dis}(u,p)+d
\end{cases}\\
&\implies \mathrm{dis}(u,p)=d=\mathrm{dis}(v,p)=\mathrm{dis}(w,p)
\end{aligned}
$$

Thus, there is a vertex, namely $p$, such that $u,v,w$ have equal distance to it.  
Moreover $p$ is the unique point that $\mathrm{dis}(v,p)=\mathrm{dis}(w,p)$.  

## part 2: counting

For $p=1,2,3\ldots n$, delete $p$ and split the tree into $\mathrm{deg}(p)$ disjoint subtrees.  
Count the ways to select $k$ vertices s.t. for every two vertices $(x,y)$, $p$ is in the middle of the unique path between $x$ and $y$.  
The $k$ vertices should be selected from distinct subtrees.  

The algorithm:  

1. enumerate $p$ from $1$ to $n$
2. make $p$ the root of the tree, let $v_1,v_2\ldots v_{\mathrm{deg}(p)}$ be the neighbors of $p$,  
   and $\mathrm{subtree}(v_i)$ be the $i$-th subtree whose root is $v_i$ be the $i$-th subtree whose root is $v_i$.
3. let $\mathrm{cnt}(i,d)=\sum_{u\in\mathrm{subtree}(v_i)}[\mathrm{dis}(u,v_i)=d]$  
4. for $d$ in range $[1,n]$

$$
[x^k]
\prod_{i=1}^{\mathrm{deg}(p)}\left(
\sum_{j=1}^{n} 1+\mathrm{cnt}(i,j)x
\right)
$$

## implementation (in cpp)

```cpp
#include <bits/stdc++.h>
int read(){
  int x=0; char c;
  do{c=getchar();}while(!isdigit(c));
  do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
  return x;
}
const int mod=int(1e9)+7LL;
const int N=100+10;
int n,k;
std::vector<int> g[N];

int cnt[N];
void dfs(int u,int fa,int dep){
  cnt[dep]++;
  for(int v:g[u]){ if(v!=fa){ dfs(v,u,dep+1); } }
}
int dp[N][N];
int solve(int root){
  memset(dp,0,sizeof(dp));
  for(int i=1;i<=n;i++){ dp[i][0]=1; }

  for(int v:g[root]){
    for(int i=1;i<=n;i++) cnt[i]=0;
    dfs(v,root,1);
    for(int d=1;d<=n;d++){
      for(int i=k;i>0;i--){
        dp[d][i]=(dp[d][i]+1LL*dp[d][i-1]*cnt[d])%mod;
      }
    }
  }
  int res=0;
  for(int i=1;i<=n;i++){ res=(res+dp[i][k])%mod; }
  return res;
}

int main(){
  int T=read(); while(T--){
    n=read();k=read();
    for(int i=1;i<=n;i++){
      g[i].clear(); 
    }
    for(int i=1;i<n;i++){
      int x=read(),y=read();
      g[x].push_back(y); g[y].push_back(x);
    }

    int ans=0;
    if(k==2){
      ans=(1LL*n*(n-1)/2)%mod;
    }else{
      for(int i=1;i<=n;i++){ ans=(ans+solve(i))%mod; }
    }
    printf("%d\n",ans);
  }
  return 0;
}
```
