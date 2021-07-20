## [Usaco2002 Feb]Rebuilding Roads

> 给一个$n$点的树,在树上删掉一些边,分成一些连通块,其中出现一个大小为$k$的块.  
> 最小化删除的边的数目.  

[link: luogo p1272](https://www.luogu.com.cn/problem/P1272)


### solution

首先搞成有根树,显然答案不变.  

考虑答案是什么样子的,  
一个深度最小的点$u$做为连通块的根,删掉$(u,fa_u)$(如果$u$是根那么不需要这个操作),  
选一些儿子,在它们对应的子树中分别取点,总共取$k-1$个;对于没有被选择的子树要删掉它和$u$之间的边.  

令$f(u,i,j)$为,仅考虑以$u$为根的子树时,考虑了前$i$个儿子对应的子树,在者前$i$个子树中,选出了$j-1$个的点,最小化的删边数目.  .   
再令$g(u,i)=f(u,|son(u)|,i)$.  

有转移方程$f(u,i,j)=\min_{k>0}(f(u,i-1,k)+g(v,j-k))$  
此外,还有$f(u,i,j)\leftarrow f(u,i-1,j)+1$表示不在$subtree(v)$中选择任何点,断开$(v,u)$  
最后,要给出初始条件,$f(u,0,1)=0$
  
答案是$\min\{g(u,k)+[u\neq \text{root}]\}$ 

### code

```cpp
#include <bits/stdc++.h>
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}
const int N=150+3;
int n,m,degree_in[N],root,dp[N][N],tmp[N],ans;
std::vector<int> son[N];

void my_copy(int *a,int *b){
	for(int i=0;i<=m;i++) b[i]=a[i];
}

void dfs(int u){
	dp[u][1]=0;
	for(int v:son[u]){
		dfs(v);
		my_copy(dp[u],tmp);
		for(int j=1;j<=m;j++){
			int qwq=10000+10;
			for(int k=0;k<j;k++){
				qwq=std::min(qwq,tmp[j-k]+dp[v][k]+(k==0));
			}
			dp[u][j]=qwq;
		}
	}
	ans=std::min(ans,dp[u][m]+(u!=root));
}
int main(){
	n=read();m=read(); ans=10000+10;
	for(int i=1;i<=n;i++) for(int j=1;j<=m;j++) dp[i][j]=10000+10;
	for(int i=1;i<n;i++){
		int x=read(),y=read();
		son[x].push_back(y);
		degree_in[y]++;
	}
	for(int i=1;i<=n;i++) if(degree_in[i]==0) root=i;
	dfs(root);
	std::cout<<ans<<std::endl;
	return 0;
}
```


