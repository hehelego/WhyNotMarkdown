# CCC2018 S5 Maximum Strategic Savings

## statement
[link:DMOJ](https://dmoj.ca/problem/ccc18s5)  [link:luogu](https://www.luogu.com.cn/problem/P4809)
给一个$N\times M$个点的无向图$G=(V,E)$,每个点是$V=\{(e,f) \mid 1\leq e\leq N,1\leq f\leq M\}$.
给$P$个二元组$(x_i,y_i)$表示$\forall e\ (1\leq e\leq N)\to ((e,x_i)\leftrightarrow (e,y_i)\in E)$
和$Q$个二元组$(u_i,v_i)$表示$\forall f\  (1\leq f\leq M)\to ((u_i,f)\leftrightarrow (v_i,f)\in E)$
求$G$的$MST$的边权和.

大概这样

```cpp
for(int i=0;i<p;i++){
    int a=read(),b=read(),c=read();
    for(int e=1;e<=n;e++) link(id(e,a),id(e,b),c);
}
for(int i=0;i<q;i++){
    int a=read(),b=read(),c=read();
    for(int f=1;f<=m;f++) link(id(a,f),id(b,f),c);
}
```

## solution

> 其实是个做法很trivial的题目,但是2018年为NOIp训练的时候遇到这个题目,还是很难解决它.
> 现在有了足够的基础熟练度,有了认真思考的冷静头脑以及我能做得出来的自信,解决这种题目已经变得非常轻松了.
> 不得不说那时候我还没入算法竞赛的门,OI弱校学生往往难以轻松跨过从接触OI到拥有自己深入学习高级知识和技巧的能力并开始快速进步之间的巨大鸿沟,或者做到它的时间过长压缩了之后的训练时间.希望我们能做点什么,尝试改善这个情况.
> 我知道2020年有强基计划和新冠肺炎疫情的打击,OIer不好过;CCF的离谱操作使得他们的公信力快速流失.但是这不应该阻止那些真的有兴趣,有天赋的人成为算法竞赛爱好者,或者阻止对CS有兴趣的孩子们靠近这个学科的大门.



这个$(e,f)$可以看一个$N\times M$的矩阵.

考虑`kruskal's algorithm`求解MST,我们对于所有的边进行排序,
把边分成$P+Q$组,组之间按照边权大小排序.

此时开始选边,合并联通分量.必然是首先选择一组$\forall e\ (e,x)\leftrightarrow (e,y)$或者一组$\forall f\ (u,f)\leftrightarrow (v,f)$把它们全都加入.

- 对于第一种情况,相当于合并了第$x$行与第$y$行,变成了一个$N\times (M-1)$的矩阵(加入了$N$条边).
  我们把$(u,v)\in E$其中$u=(e,y)$的边替换为$u'=(e,x)$的边,权值不变,得到了一个规模更小的子问题.

- 第二种情况是合并了$u$列和$v$列,变成了$(N-1)\times M$的矩阵(加入了$M$条边).
  类似上面的情况,替换一些边,得到规模更小的子问题.

我们发现这个合并的操作并不用真的遍历边,只要用一个并查集维护这个合并的关系即可.
于是我们最多选择$n+m$组边,每次都会合并两行或者两列,用一个按照集合大小启发式合并的并查集就可以$O(\log \max(N+M))$时间内完成合并操作.
于是这样得到了一个$O(E\log E+(V+E\log V))$的算法,其中$E=P+Q,V=M+N$.



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
	unsigned long long ans=0;
	for(int i=1;i<=m;i++) fa[i]=i;
	for(int i=1;i<=n;i++) fb[i]=i;
	for(int i=0;i<p;i++){
		ea[i].a=read(); ea[i].b=read();
		ea[i].w=read(); ans+=1LL*n*ea[i].w;
	} std::sort(ea,ea+p);
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



