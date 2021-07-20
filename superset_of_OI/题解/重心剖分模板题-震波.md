# 震波: 重心剖分(centroid decomposition, 或称为树的点分治)

## statement

- [link:luogu p6329](https://www.luogu.com.cn/problem/P6329)
- [link:BZOJ 3730](https://darkbzoj.tk/problem/3730)


给一个$n$点的树,定义两点$(u,v)$距离$d(u,v)$为树上路径中边的数目.  
点带有weight,$w_i$  

强制在线,进行$m$次操作.  

- 给出$x,k$,修改 $w_x^\prime \leftarrow k$
- 给出$x,k$,查询 $\sum_y [d(x,y)]\leq k]w_y$


## solution

考虑点分治的过程,每个点都会成为一次关键点,计算满足两端在它的不同子树中的路径信息.  
对于点$u$,考虑以$c_1,c_2\dots c_r$为关键点时,某个子树中包含$u$. 显然有$r=O(\log n)$.  
我们把这个分治过程经过的关键点建一个树(删掉$u$后得到的所有子树的重心都与$u$连边),这个树的高度是$O(\log n)$的.


对于点$u$,考虑以$c_1,c_2\dots c_r$为关键点时,某个子树中包含$u$,并且设这个包含$u$的子树的根(在原树中与$u$直接相连)为$v_1,v_2\dots v_r$. 

我们考虑计算$\sum_i d(u,i)$,重构树上$x=LCA(u,i)$一定在$path(u,i)$上在(或者说考虑点分治的计算过程,$path(u,i)$一定在$x$处被计算),可以在这里计算$d(u,i)$.  
于是我们枚举$u$在重构树中的祖先,即$c_1,c_2\dots c_r$,考察以$c$为关键点时,不在$v$子树中,满足$d(c,j)\leq k-d(c,u)$的$j$即可.  

这里的统计是求和,是可逆的,我们用$c$为关键点时所有满足距离约束的点的贡献,减掉$c$为关键点时$v$的子树中满足距离约束的点的贡献.


> remark:  
> 这个技巧,实际上是显式保留分治的递归树结构,保留归并时的信息.  
> 部分修改可以快速维护时,直接利用这个分治结构进行统计.  
> 
> 重心剖分还可以玩出一些有趣的题目,  
> 这种保留分治递归树,在上面进行高效局部修改和重新进行统计的想法,也有不少其他应用.比如所谓DDP.



## code

```cpp
#include <bits/stdc++.h>
template<typename T>
int vecsz(const std::vector<T> &v){ return int(v.size()); }
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}
const int N=100000+10;
const int LOG=28;
int n,m,weight[N],root_all[N];
std::vector<int> root_sub[N];
std::vector<int> g[N];
int par[N][LOG],bel[N][LOG],dep[N][LOG],qwq[N];


struct T{
	int s,ch[2];
	T(){ s=ch[0]=ch[1]=0; }
}t[N*3*LOG]; int __cnt;
int create(){ return ++__cnt; }
int add(int o,int L,int R,int p,int v){
	o=(o==0)?create():o; t[o].s+=v;
	if(L<R){
		int mid=(L+R)>>1;
		if(p<=mid) t[o].ch[0]=add(t[o].ch[0],L,mid,p,v);
		else t[o].ch[1]=add(t[o].ch[1],mid+1,R,p,v);
	}
	return o;
}
int add(int o,int p,int v){ return add(o,0,n,p,v); }
int qry(int o,int L,int R,int l,int r){
	if(L>r||R<l||o==0) return 0;
	if(l<=L&&R<=r) return t[o].s;
	int mid=(L+R)>>1;
	return qry(t[o].ch[0],L,mid,l,r)+qry(t[o].ch[1],mid+1,R,l,r);
}
int qry(int o,int l,int r){ return qry(o,0,n,l,r); }


int sz[N],hson[N],vec[N],vend,vis[N];
void dfs1(int u,int f){
	vec[vend++]=u; sz[u]=1; hson[u]=0;
	for(int v:g[u]) if(vis[v]==0&&v!=f){
		dfs1(v,u); sz[u]+=sz[v];
		hson[u]=std::max(hson[u],sz[v]);
	}
}
int cost(int u){ return std::max(hson[u],vend-sz[u]); }
void dfs2(int u,int f,int ctr,int dis,int id){
	qwq[u]++; int j=qwq[u]-1;
	par[u][j]=ctr; bel[u][j]=id; dep[u][j]=dis;

	root_all[ctr]=add(root_all[ctr],dis,weight[u]);
	root_sub[ctr][id]=add(root_sub[ctr][id],dis,weight[u]);

	for(int v:g[u]) if(v!=f&&vis[v]==0) dfs2(v,u,ctr,dis+1,id);
}
void init(int u){
	vend=0; dfs1(u,0);
	int ct=u,now=cost(ct);
	for(int i=1;i<vend;i++){
		int t=cost(vec[i]);
		if(t<now){ now=t; ct=vec[i]; }
	}
	vis[u=ct]=1; root_all[ct]=add(root_all[ct],0,weight[ct]);
	for(int v:g[ct]) if(!vis[v]){
		root_sub[ct].push_back(create());
		dfs2(v,u,u,1,vecsz(root_sub[ct])-1);
	}
	for(int v:g[ct]) if(!vis[v]) init(v);
}

int query(int x,int k){
	int res=qry(root_all[x],0,k);
	for(int i=0;i<qwq[x];i++){
		int p=par[x][i],b=bel[x][i],d=dep[x][i];
		res+=qry(root_all[p],0,k-d);
		res-=qry(root_sub[p][b],0,k-d);
	}
	return res;
}
void update(int x,int delta){
	root_all[x]=add(root_all[x],0,delta);
	for(int i=0;i<qwq[x];i++){
		int p=par[x][i],b=bel[x][i],d=dep[x][i];
		root_all[p]=add(root_all[p],d,delta);
		root_sub[p][b]=add(root_sub[p][b],d,delta);
	}
}

int main(){
	n=read();m=read();
	for(int i=1;i<=n;i++) weight[i]=read();
	for(int i=1;i<n;i++){
		int x=read(),y=read();
		g[x].push_back(y); g[y].push_back(x);
	}
	init(1); int last=0;
	while(m--){
		int op=read(),x=read(),y=read();
		x^=last; y^=last;
		if(op==0){ printf("%d\n",last=query(x,y)); }
		else{ int d=y-weight[x]; weight[x]=y; update(x,d); }
	}
	return 0;
}
```
