# luogu P3401 洛谷树

## statement

[link:luogu P3401](https://www.luogu.com.cn/problem/P3401)

给你一个$n$个点,边上带自然数权的树.
进行$m$次操作.

- 修改一条边的权
- 询问路径$(u,v)$的所有子路径,边权异或和求和.

设最大的边权是$w$

## solution

经典的不同位之间无影响,分成$\lceil \log_2 w\rceil$位之后.
每一位的问题,是$w=1$的子问题.

考虑树退化为序列的情况,考虑用线段树(任何平衡树都没问题)维护它.
我们发现,合并两个区间的信息以得到整个区间的所有子区间异或和之和需要记录

- 左侧和右侧区间异或和为$0/1$的子区间数量
- 左侧区间的异或和为$0/1$的后缀数量
- 右侧区间的异或和为$0/1$的前缀数量
- 左侧区间,右侧区间的异或和.

而他们都是可以快速合并的.具体而言
设异或和,异或和为$0/1$的子区间计数,异或和为$0/1$的前缀/后缀数量,异或和,分别为$\text{sum},\text{cnt}_{0/1},\text{pre}_{0/1},\text{suf}_{0/1}$我们有
$$
S=L+R\\
\text{sum}(S)=\text{sum(L)}\oplus \text{sum(R)}\\
\text{cnt}_0(S)=\text{cnt}_0(L)+\text{cnt}_0(R)+\text{suf}_0(L)\text{suf}_0(R)+\text{suf}_1(L)\text{suf}_1(R)\\
\text{cnt}_0(S)=\text{cnt}_1(L)+\text{cnt}_1(R)+\text{suf}_0(L)\text{suf}_1(R)+\text{suf}_1(L)\text{suf}_0(R)\\
\text{pre}_0(S)=\text{pre}_0(L)+\text{pre}_{\text{sum}(L)}(R)\\
\text{pre}_1(S)=\text{pre}_1(L)+\text{pre}_{\neg \text{sum}(L)}(R)\\
\text{suf}_0(S)=\text{suf}_0(R)+\text{suf}_{\text{sum}(R)}(L)\\
\text{suf}_1(S)=\text{suf}_1(R)+\text{suf}_{\neg \text{sum}(R)}(L)
$$
最后用HLD把树上问题转化成序列问题.

### notice

- 对询问答案的数量级估计.一个长度为$n$的序列,相邻两点间边权为$w$,那么整个序列的所有子区间,按照其中边的奇偶性有一半是异或和为$0$,另一半是$w$于是答案至少是$\frac{n(n+1)}{2}w$的.按照题目给的数据算一下,是超过了`c++ signed int32`的需要用一个64位整数数据类型.
- 关于结合律和交换律.显然这个合并操作是有结合而没有交换的,所以需要注意一下顺序的问题.HLD之后爬交替轻重链走到LCA时可以求出以LCA为分界点的两段路径的信息,需要保证其中一段是自上而下合并出来,另一段是自下而上的.前者作为$L$后者作为$R$进行合并.
- hld是直接解决了点带权的问题,边带权,用每个点和它的父节点之间的边作为其点权即可.这时,路径$u\to \text{LCA}(u,v)\to v$的$w(\text{LCA})$其实是$\text{fa}(\text{LCA})\to\text{LCA}$这并不是路径$(u,v)$上的边,应当排除掉.

## code



```cpp
#include <bits/stdc++.h>
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}
typedef long long Int;
const int P=11;
const int N=30000+10;
int  n,m;
struct E{
	int v,w;
	E(int a,int b):v(a),w(b){}
}; std::vector<E> g[N];


int fa[N],dep[N],size[N],son[N],in[N];
int dfn[N],idx,top[N],arr[N];
void dfs1(int u,int f){
	dep[u]=dep[fa[u]=f]+1; size[u]=1;
	for(auto e:g[u]) if(e.v!=f){
		int v=e.v; in[v]=e.w;
		dfs1(v,u); size[u]+=size[v];
		if(size[son[u]]<size[v]) son[u]=v;
	}
}
void dfs2(int u,int f){
	arr[dfn[u]=++idx]=in[u]; top[u]=f;
	if(son[u]) dfs2(son[u],f);
	for(auto e:g[u]){
		int v=e.v; if(dfn[v]==0) dfs2(v,v);
	}
}
struct T{
	int pre[2],suf[2],cnt[2],sum;
	T(){ sum=0;
		pre[0]=pre[1]=0;
		suf[0]=suf[1]=0;
		cnt[0]=cnt[1]=0;
	}
	T(int x){ sum=x;
		pre[x]=1; pre[x^1]=0;
		suf[x]=1; suf[x^1]=0;
		cnt[x]=1; cnt[x^1]=0;
	}
};
struct Node{
	T a[P]; Node(){for(int i=0;i<P;i++) a[i]=T();}
	const T& operator[](int x)const{ return a[x]; }
	T& operator[](int x){ return a[x]; }
	Node(int v){ for(int i=0;i<P;i++) a[i]=T((v>>i)&1); }
}t[N<<2];
T merge(const T&l,const T&r){
	T a; a.sum=l.sum^r.sum;
	a.pre[0]=l.pre[0]+r.pre[l.sum];
	a.pre[1]=l.pre[1]+r.pre[l.sum^1];
	a.suf[0]=r.suf[0]+l.suf[r.sum];
	a.suf[1]=r.suf[1]+l.suf[r.sum^1];
	a.cnt[0]=l.cnt[0]+r.cnt[0]+l.suf[0]*r.pre[0]+l.suf[1]*r.pre[1];
	a.cnt[1]=l.cnt[1]+r.cnt[1]+l.suf[0]*r.pre[1]+l.suf[1]*r.pre[0];
	return a;
}
T reverse(const T&a){
	T b; b.sum=a.sum;
	b.pre[0]=a.suf[0]; b.pre[1]=a.suf[1];
	b.suf[0]=a.pre[0]; b.suf[1]=a.pre[1];
	b.cnt[0]=a.cnt[0]; b.cnt[1]=a.cnt[1];
	return b;
}
Node merge(const Node&l,const Node&r){
	Node a;
	for(int i=0;i<P;i++) a[i]=merge(l[i],r[i]);
	return a;
}
Node reverse(const Node&x){
	Node b;
	for(int i=0;i<P;i++) b[i]=reverse(x[i]);
	return b;
}
void build(int o,int l,int r){
	if(l==r){ t[o]=Node(arr[l]); return ; }
	int mid=(l+r)>>1,ls=o<<1,rs=ls|1;
	build(ls,l,mid); build(rs,mid+1,r);
	t[o]=merge(t[ls],t[rs]);
}
Node qry(int o,int L,int R,int l,int r){
	if(L>r||R<l) return Node();
	if(l<=L&&R<=r) return t[o];
	int mid=(L+R)>>1,ls=o<<1,rs=ls|1;
	return merge(qry(ls,L,mid,l,r),qry(rs,mid+1,R,l,r));
}
inline Node qry(int l,int r){ return qry(1,1,n,l,r); }
void upd(int o,int L,int R,int p,int v){
	if(L==R){t[o]=Node(v); return ;}
	int mid=(L+R)>>1,ls=o<<1,rs=ls|1;
	if(p<=mid) upd(ls,L,mid,p,v);
	else upd(rs,mid+1,R,p,v);
	t[o]=merge(t[ls],t[rs]);
}
inline void upd(int p,int v){ upd(1,1,n,p,v); }


Int query(int x,int y){
	int s=dep[x]+dep[y];
	Node tx,ty;
	while(top[x]!=top[y]){
		if(dep[top[x]]>dep[top[y]]){
			tx=merge(qry(dfn[top[x]],dfn[x]),tx);
			x=fa[top[x]];
		}else{
			ty=merge(qry(dfn[top[y]],dfn[y]),ty);
			y=fa[top[y]];
		}
	}
	if(dep[x]>dep[y]){
		tx=merge(qry(dfn[y]+1,dfn[x]),tx);
		s-=2*dep[y];
	}else{
		ty=merge(qry(dfn[x]+1,dfn[y]),ty);
		s-=2*dep[x];
	}
	Node tt=merge(reverse(ty),tx);
	int ans=0; for(int i=0;i<P;i++) ans+=(1<<i)*tt[i].cnt[1];
	return ans;
}
void update(int x,int y,int v){
	if(dep[x]<dep[y]) std::swap(x,y);
	upd(dfn[x],in[x]=arr[dfn[x]]=v);
}

int main(){
	n=read();m=read();
	for(int i=1;i<n;i++){
		int a=read(),b=read(),c=read();
		g[a].push_back(E(b,c));
		g[b].push_back(E(a,c));
	}
	dfs1(1,1); dfs2(1,1); build(1,1,n);
	while(m--){
		int o=read(),u=read(),v=read();
		if(o==1) printf("%lld\n",query(u,v));
		else update(u,v,read());
	}
	return 0;
}
```
