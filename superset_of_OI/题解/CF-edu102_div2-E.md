# codefoces educational round 102: E- MinimumPath



## problem statement

- [link: origin](https://codeforces.com/contest/1473/problem/E)

给一个edge-weighted undirected graph with $n$ vertexes and $m$ edges.  
对于路径$p=\mathrm{Path}(e_1,e_2,e_3\dots e_k)$,  
我们定义$f(p)=\sum w_i-\max w_i+min w_i$.  

对于$i=2,3,4\dots n$,求出$1\to i$的路径$q_i$,最小化$f(q_i)$.  

## solution

路径边权和扣掉最大值,加倍最小值. 这个约束太强了, 我们没法钦定了最大值/最小值再做.  

**放宽约束** 换成这个目标函数$g(q_i)$. 找一个$1\to i$的路径,任意在上面删掉一条边并加倍一条边, 求边权和.  
这个非常好最优化. 设$\mathrm{dp}(u,0/1,0/1)$表示从$1$走到$u$目前(删掉/未删掉一条边,加倍/未加倍一条边)的边权和.  
写出状态转移方程,发现这个东西满足三角形不等式,并且增量非负,可以使用dijkstra来递推求解.  

刚刚的分析,是微观层次的,即对于每次决策单独分析.  
我们再考虑宏观上的情况,我们如果已经选好了路径上的边,要最小化$g(i,1,1)$,一定会删掉最大边,加倍最小边.  
也就是说,$g(i,1,1)=f(i)$.

至此,我们可以$O((V+E)\log(V+E))$求解本题了,其中$V=4n,E=4\times 4\, m$.这里$n,m$同阶,大致是$O(n\log n)$. 



这种放宽约束后,最优解仍然不变,可以转化为求解更容易的最优化问题的套路,还是比较多见的,但是太久没有做题,举不出好例子.


## implementation


```cpp
#include <bits/stdc++.h>
using i64=signed long long int;
const i64 INF=i64(1e16);
const int N=200000+10;
int read(){
	int x=0;char c='\0';
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}

// dp(u,x,y) shortest path when
//   u: 1 to u.
//   x: have cut a edge or not.
//   y: have doubled a edge or not.
i64 dp[N][2][2]; bool vis[N][2][2];
struct T{
	int u;bool x,y;  i64 len;
	T(int a,bool b,bool c,i64 d):u(a),x(b),y(c),len(d){}
	bool operator<(const T &rhs)const{ return len>rhs.len; }
};
std::vector<std::pair<int,int>> g[N];


int main(){
	int n=read(),m=read();
	for(int i=1;i<=n;i++){
		dp[i][0][0]=dp[i][0][1]=dp[i][1][0]=dp[i][1][1]=INF;
	}
	for(int i=0;i<m;i++){
		int x=read(),y=read(),w=read();
		g[x].push_back(std::make_pair(y,w));
		g[y].push_back(std::make_pair(x,w));
	}

	std::priority_queue<T> pq;
	pq.push(T(1,0,0,dp[1][0][0]=0LL));
	while(!pq.empty()){
		auto [u,x,y,d]=pq.top(); pq.pop();
		if(d>dp[u][x][y]) continue;

		for(auto [v,w]:g[u]){
			auto tmp=dp[u][x][y]+w;
			if(tmp<dp[v][x][y]) pq.push(T{v,x,y,dp[v][x][y]=tmp});
			if(x==0&&y==0){
				if(tmp<dp[v][1][1]) pq.push(T{v,1,1,dp[v][1][1]=tmp});
			}

			if(x==0){
				auto tmp=dp[u][x][y]+0LL;
				if(tmp<dp[v][1][y]) pq.push(T{v,1,y,dp[v][1][y]=tmp});
			}
			if(y==0){
				auto tmp=dp[u][x][y]+2LL*w;
				if(tmp<dp[v][x][1]) pq.push(T{v,x,1,dp[v][x][1]=tmp});
			}
		}
	}

	for(int i=2;i<=n;i++) printf("%lld ",dp[i][1][1]);
	return 0;
}
```



