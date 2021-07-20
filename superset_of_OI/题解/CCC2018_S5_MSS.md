# CCC2018 S5 Maximum Strategic Savings

## statement

[link:DMOJ](https://dmoj.ca/problem/ccc18s5)  
[link:luogu](https://www.luogu.com.cn/problem/P4809)  

给一个$N\times M$个点的无向图$G=(V,E)$,每个点是$V=\{(e,f) \mid 1\leq e\leq N,1\leq f\leq M\}$.  
给$P$个二元组$(x_i,y_i)$表示$\forall e\ (1\leq e\leq N)\to ((e,x_i)\leftrightarrow (e,y_i)\in E)$  
和$Q$个二元组$(u_i,v_i)$表示$\forall f\  (1\leq f\leq M)\to ((u_i,f)\leftrightarrow (v_i,f)\in E)$  
求$G$的$MST$的边权和.

加边的方式可以描述为如下的程序

```cpp
for(int i=0;i<p;i++){
    int x=read(),y=read(),w=read();
    for(int e=1;e<=n;e++) link(id(e,x),id(e,y),w);
}
for(int i=0;i<q;i++){
    int u=read(),v=read(),w=read();
    for(int f=1;f<=m;f++) link(id(u,f),id(v,f),w);
}
```

## solution

$V=\{(e,f)\mid e\in [N],f\in [M]\}$可以看一个$N\times M$的矩阵.  
对第一类边$(e,x_i)\leftrightarrow (e,y_i)$可以看作两列$x_i,y_i$之间的边.  
而第二类边$(u_i,f)\leftrightarrow (v_i,f)$可以看作两行$u_i,v_i$之间的边.

考虑用`kruskal's algorithm`求解MST

- 如果边权最小的是一组$(e,x_i)\leftrightarrow (e,y_i)$的边,  
  我们可以全部加入它们而不成环. 边权和为$N\times w$,  
  这样之后,矩阵的$x_i,y_i$两列被合并为一列.  
	得到了一个规模$N\times (M-1)$的子问题
- 如果边权最小的是一组$(u_i,f)\leftrightarrow (v_i,f)$的边,  
  我们可以全部加入它们而不成环. 边权和为$M\times w$,  
  这样之后,矩阵的$u_i,v_i$两行被合并为一行.  
	得到了一个规模$(N-1)\times M)$的子问题

我们用两个并查集, 分别维护"两行是否已经被连通","两列是否已经被连通"的连通性,
即可套用`kruskal's algorithm`.


## code

```cpp
#include <bits/stdc++.h>
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}
const int N=100000+10;
struct E{
	int a,b,w;
	bool operator<(const E&rhs)const{return w<rhs.w;}
}ea[N],eb[N];


int fa[N],fb[N];
int pa(int x){
	if(fa[x]!=x) return fa[x]=pa(fa[x]);
	return fa[x];
}
int pb(int x){
	if(fb[x]!=x) return fb[x]=pb(fb[x]);
	return fb[x];
}
int ma(int u,int v){
	u=pa(u);v=pa(v);
	if(u==v) return 0;
	fa[u]=v;
	return 1;
}
int mb(int u,int v){
	u=pb(u);v=pb(v);
	if(u==v) return 0;
	fb[u]=v;
	return 1;
}


int main(){
	int n=read(),m=read(),p=read(),q=read();
	for(int i=0;i<p;i++){
		ea[i].a=read(); ea[i].b=read();
		ea[i].w=read(); ans+=1LL*n*ea[i].w;
	}


	unsigned long long ans=0;
	for(int i=1;i<=m;i++) fa[i]=i;
	for(int i=1;i<=n;i++) fb[i]=i;

	std::sort(ea,ea+p);
	for(int i=0;i<q;i++){
		eb[i].a=read(); eb[i].b=read();
		eb[i].w=read(); ans+=1LL*m*eb[i].w;
	} std::sort(eb,eb+q);


	int i=0,j=0;
	while(i<p&&j<q){
		if(ea[i].w<eb[j].w){
			if(ma(ea[i].a,ea[i].b)){
				ans-=1LL*n*ea[i].w;
				m--;
			}
			i++;
		}else{
			if(mb(eb[j].a,eb[j].b)){
				ans-=1LL*m*eb[j].w;
				n--;
			}
			j++;
		}
	}

	while(i<p){
		if(ma(ea[i].a,ea[i].b)){
			ans-=1LL*n*ea[i].w;
			m--;
		}
		i++;
	}
	while(j<q){
		if(mb(eb[j].a,eb[j].b)){
			ans-=1LL*m*eb[j].w;
			n--;
		}
		j++;
	}
	std::cout<<ans<<std::endl;
	return 0;
}
```



