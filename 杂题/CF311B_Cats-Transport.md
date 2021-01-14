# CF311B Cats Transport

## statement

link: [luogu](https://www.luogu.com.cn/problem/CF311B),[codeforces](https://codeforces.com/contest/311/problem/B)  

有$n$座编号为$1,2,3\dots n$的山,用$h_i$表示,其中$dis(h_{i+1},h_i)=d_i$.  
有$m$只猫,一只猫用$cat\{t,p\}$表示,要求在时间$t$之后,从$h_p$接走它.  
可以安排$p$次接猫行动,选定开始时间$T$之后,从$(T,h_1)$开始,到$(T+d_1,h_2)$,以及$(T+\sum_{j\leq i}d_j,h_i)$.到达$h_i$时,可以不花费任何时间地接走那里的猫.  

最小化所有猫的等待时间之和.


## solution

令$D_i=\sum_{j\leq i}d_j$以及$s(c\{t,p\})=t-D_p$  

对于猫$c$而言,出发时间$t$必须满足$t\geq s(c)$才可以接走它.  
并且出发时间为$t$时,$c$的等待时间是$t-s(c)$  


由于接猫行动不会在任何地方等待,所以每次行动取走的$c$的$[\min\,s(c_i),\max\,s(c_i)]$应该是不相交的.  
或者这么描述,把$c_1,c_2\dots c_m$按照$s(c_i)$升序排列,我们每次取走一个前缀是最优的.  
于是就是喜闻乐见的区间划分问题了.  

考虑在依次接猫中,取走区间$[l,r]$中的所有猫猫,对于出发时间有$t\geq s(c_r)$,而$t$越大等待时间越长,于是令$t=s(c_r)$即可.  
总等待时间是$(r-l+1)t-\sum_{l\leq i\leq r}s(c_i)$  

这个最优化问题显然是有无后效性和最优子结构的,于是我们可以尝试写个动态规划.  
设$f(i,j)$表示进行了$i$次接猫,已经接走了按照$s(c)$排序后的前$j$个猫,有状态转移方程  

$$
\begin{aligned}
f(i,j)=\min_{0\leq k<j} (f(i-1,k)+g(k+1,j))\\
g(l,r)=(r-l+1)\times s(c_r) - \sum_{l\leq i\leq r} s(c_i)
\end{aligned}
$$

也就是  

$$
\begin{aligned}
&pre_i=\sum_{j\leq i} s(c_j)\\
\newline
&f(i,j)=\min_{0\leq k<j} \{ f(i-1,k)+(j-k)\times s(c_j)-(pre_j-pre_k) \}\\
&=\min_{0\leq k<j} \{ (j\times s(c_j)-pre_j)+(f(i-1,k)+pre_k-k\times s(c_j)) \}\\
\end{aligned}
$$

是喜闻乐见的`斜率优化(也称为convex hull trick)`模型.    
使用一个几何意义,  

令$(x_k,y_k)=(k,f(i-1,k)+pre_k),slope_j=s(c_j)$有  
$$
f(i,j)=\min_{0\leq k<j} \{ y_k-slope_j\times x_k \}
$$

动态规划的状态转移变成了这样的形式: 二维平面上有一些点$(x_k,y_k)$,选择过其中一个点,作一条斜率为$slope_j$的直线,最小化直线与$y-axis$的截距.  
通过几何直观,我们容易发现以下性质.  

- 只有过点集的下凸壳上的点作直线才可能得到最小值.  
- 考虑把凸包上的点按照$x$分量升序排列,设当前在点$(x_k,y_k)$,如果$(x_{k+1},y_{k+1})-(x_k,y_k)$之间的连线的斜率小于$slope$(或者说,$(x_k,y_k)-(x_{k+1},y_{k+1})$的连线在 过$(x_k,y_k)$有斜率$slope$的直线的顺时针或者说左侧),那么选择$k+1$比$k$得到截距更小

> 画图就知道上述结论的正确性了,当然通过计算来证明也是可以的  

下面就只剩利用计算几何与数据结构的技巧了,不再讲解.  


**当然更通用的做法是利用“决策单调性"进行优化**


## code

### 暴力DP

(总状态转移)时间复杂度$O(p\,m^2)$

```cpp
#include <bits/stdc++.h>
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}
typedef long long Int;
const Int INF=Int(1e18);
const int N=100000+10;
int n,m,p,d[N];
struct Cat{
	int h,t;
	Cat(int a=0,int b=0):h(a),t(b){}
	Int st()const{return t-d[h];}
	bool operator<(const Cat&r)const{ return st()<r.st(); }
}cat[N];

Int dp[101][N],pre[N];
Int solve(int l,int r){ return (r-l+1)*cat[r].st()-(pre[r]-pre[l-1]); }

int main(){
	n=read();m=read();p=read();
	for(int i=2;i<=n;i++) d[i]=d[i-1]+read();
	for(int i=1;i<=m;i++){
		int h=read(),t=read();
		cat[i]=Cat(h,t);
	}
	std::sort(cat+1,cat+m+1);
	for(int i=1;i<=m;i++) pre[i]=pre[i-1]+cat[i].st();

	for(int i=0;i<=p;i++) for(int j=0;j<=m;j++) dp[i][j]=INF;
	dp[0][0]=0;

	for(int i=1;i<=p;i++){
		for(int j=1;j<=m;j++){
			Int &r=dp[i][j];
			for(int k=0;k<j;k++) r=std::min(r,dp[i-1][k]+solve(k+1,j));
		}
	}

	Int ans=Int(1e18);
	for(int i=0;i<=p;i++) if(dp[i][m]>=0) ans=std::min(ans,dp[i][m]);
	std::cout<<ans<<std::endl;
	return 0;
}
```

### 斜率优化(国外称为convex hull trick) - 单调队列优化

(总状态转移)时间复杂度$O(pm)$

```cpp
#include <bits/stdc++.h>
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}
typedef long long Int;
const Int INF=Int(1e18);
const int N=100000+10;
int n,m,p,d[N];
struct Cat{
	int h,t;
	Cat(Int a=0,Int b=0):h(a),t(b){}
	Int st()const{return t-d[h];}
	bool operator<(const Cat&r)const{ return st()<r.st(); }
}cat[N];

Int dp[101][N],pre[N];
Int solve(int l,int r){ return (r-l+1)*cat[r].st()-(pre[r]-pre[l-1]); }

struct Vec{ Int x,y; Vec(Int a,Int b):x(a),y(b){} };
Int cross(const Vec&a,const Vec&b){return a.x*b.y-a.y*b.x;}
Vec operator+(const Vec&a,const Vec&b){return Vec(a.x+b.x,a.y+b.y);}
Vec operator-(const Vec&a,const Vec&b){return Vec(a.x-b.x,a.y-b.y);}
Vec operator*(const Vec&a,Int k){return Vec(a.x*k,a.y*k);}

Vec get(int k,int i){ return Vec(k,dp[i-1][k]+pre[k]); }
int q[N],ql,qr;

int main(){
	n=read();m=read();p=read();
	for(int i=2;i<=n;i++) d[i]=d[i-1]+read();
	for(int i=1;i<=m;i++){
		int h=read(),t=read();
		cat[i]=Cat(h,t);
	}
	std::sort(cat+1,cat+m+1);
	for(int i=1;i<=m;i++) pre[i]=pre[i-1]+cat[i].st();




	for(int i=0;i<=p;i++) for(int j=0;j<=m;j++) dp[i][j]=INF;
	dp[0][0]=0;
	for(int j=1;j<=m;j++) dp[1][j]=solve(1,j);

	for(int i=2;i<=p;i++){
		q[ql=0]=i-1; qr=1;
		for(int j=i;j<=m;j++){
			while(qr-ql>1&&cross(Vec(1,cat[j].st()),get(q[ql+1],i)-get(q[ql],i))<=0) ql++;
			int pp=q[ql]; dp[i][j]=dp[i-1][pp]+solve(pp+1,j);
			
			while(qr-ql>1&&cross(get(q[qr-1],i)-get(q[qr-2],i),get(j,i)-get(q[qr-1],i))<=0) qr--;
			q[qr++]=j;
		}
	}


	Int ans=Int(1e18);
	for(int i=1;i<=p;i++) ans=std::min(ans,dp[i][m]);
	std::cout<<ans<<std::endl;
	return 0;
}
```
