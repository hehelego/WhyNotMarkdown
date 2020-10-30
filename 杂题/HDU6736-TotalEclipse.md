# HduOJ 6736 total eclipse



## statement

给出一个点带权的无向图,定义一次操作为.  
选点数最多的连通块,其中每个点的点权减一,如果某个点的点权降低到0,那么删除这个点以及所有和它相连的边.  
求操作多少次后,所有点都被删掉.  

图的边点数同阶,点权非常大.

## solution

显然要反过来加点,合并连通块做.  

考虑原图中的任意一个连通块,这个块中的权最大点一定比其他点删除得晚,于是我们从大到小按点权排序,逐个加入维护这个导出子图的答案.   
加入一个点$(i,a_i),仅仅考虑它和那些已经被插入的点的连边.  

假设这些边连向了$k$个连通块.  
那么按照题目描述中的操作,这$k$个连通块(和$i$本身)会一起被操作$a_i$次,然后断开,分别继续操作.  
也就是说,由于$i$的存在,那$k$个连通块中的每个点$(j,a_j)$应该从$a_j-a_i$开始减.  
于是答案加上$-k\times a_i+a_i$.


最后我们把这$k$个连通块,还有$i$合并起来.  
用归纳法可以指导这样做的正确性.


## code


```cpp
#include <bits/stdc++.h>
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}
using Int= signed long long int;
const int N=200000+10;
int n,m,a[N],fa[N],vis[N];
std::vector<int> g[N];
int par(int x){
	if(fa[x]==x) return x;
	return fa[x]=par(fa[x]);
}
int merge(int x,int y){
	x=par(x);y=par(y);
	if(x==y) return 0;
	fa[x]=y;
	return 1;
}

int main(){
	int T=read(); while(T--){
		n=read(); m=read();
		std::vector<int> vec;
		for(int i=1;i<=n;i++){
			a[i]=read(); fa[i]=i; vis[i]=0;
			g[i].clear(); vec.push_back(i);
		}
		std::sort(vec.begin(),vec.end(),[](int i,int j){
				return a[i]>a[j];
		});
		for(int i=0;i<m;i++){
			int a=read(),b=read();
			g[a].push_back(b);
			g[b].push_back(a);
		}
		long long ans=0;
		for(int x:vec){
			ans+=a[x]; vis[x]=1;
			std::set<int> qwq;
			for(int v:g[x]) if(vis[v]) qwq.insert(par(v));
			ans-=1LL*qwq.size()*a[x];
			for(int v:qwq) merge(x,v);
		}
		printf("%lld\n",ans);
	}
	return 0;
}
```
