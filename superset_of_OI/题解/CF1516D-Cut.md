# CF1516D-Cut


## problem statement

- link: [codeforces round 717(div.2) D. Cut](https://codeforces.com/contest/1516/problem/D)

Given a sequence of $n$ positive integers $\vec a=(a_1,a_2\ldots a_n)$.  
For each $l_i,r_i$,
split $(a_{l},a_{l+1},a_{l+2}\ldots a_{r})$ into some sub-arrays  
such that in each sub-array, the LCM of every element euqal to the product of all elements.  
Minimize the number of sub-arrays.  

> 给定一个正整数序列,多次查询一个区间$[l_i,r_i]$,  
> 将它划分为一些互不相交,并为$[l_i,r_i]$的子区间,  
> 使得每个子区间内的元素乘积等于子区间内元素的最小公倍数.


Appedix:

- $n\leq 10^5$
- $q\leq 10^5$
- $1\leq a_i\leq 10^5$

## solution

> 虽然很trivial,但是还是记录一下,  
> 因为很久没有做任何训练,熟练度下降了,一些状态好时能够规避的问题也开始重现了.

对于一个区间$[l,r]$,$\prod_i a_i=\mathrm{lcm}(a_i)$即$a_i$两两互质,
即质数$p$,最多整除$a_l\ldots a_r$中的一个元素.  

如果$[l,r]$满足约束,那么$([l,k],[k+1,r])\ k=l,l+1,l+2\ldots r-1$这样拆分的两个区间仍然满足约束.  
所以我们可以贪心地直接构造最优方案,从$l$开始,向右扩展找到一个极大的满足约束的子区间$[l,k]$再对$[k+1,r]$继续做同样操作,直到得到空区间.  

于是我们需要对于$i=1,2,3\ldots n$求出$c_i=\max\{j\geq i\mid \prod_{i\leq k\leq j}a_k=\mathrm{lcm}(a_i,\ldots a_j)\}$.  
这样之后,仍然不能暴力构造方案. 考虑一个bad case,`a=(2,2,2,2...2)`,有$c_i=i$,单次构造复杂度可以达到$O(n)$,这是不可接受的.  
不过,很容易想到倍增,这样每次查询的复杂度可以降低到$O(\log n)$

> 可以构造一个树$G=(V,E)$其中$V=[n]\cup\{n+1\},E=\{(u,v)\mid c_u+1 =v\}$  
> 这个树是个大根堆. 即沿着一条链向上走,经过的节点编号递增.  
> 对于查询$[l,r]$我们就是查询从$l$向上跳多少次能够到达$r+1,r+2\ldots n$中的一个点.

考虑如何求解$\vec c$, 对于一个素数$p$,我们标记$\vec a$中被它整除的元素的位置集合为$\mathrm{at}(p)$,  
对于$[i,c_i]$, 我么希望其中出现最多一个$\mathrm{at}(p)$中元素,  
例如下面的情况,我们可以推出一些对于$\vec c$的约束.  

```cpp
prime = 3;
at[3] = {1,5,15,1333};
// 我们有以下关系
c[1] <  5  <  15  <  1333
c[2]       <  15  <  1333
c[3]       <  15  <  1333
c[4]       <  15  <  1333
c[5]       <  15  <  1333
c[6]              <  1333
// and so on
```

于是可以这样求解$\vec c$

```cpp
for(int i=1; i<=n; i++) c[i]=n;

for(int p: primes) if(at[i].size()>1){
  for(int i=1,sz=int(at[p].size()); i<sz; i++){
    int lim=at[p][i-1],pos=at[p][i];
    for(int j=1;j<=lim;j++) c[j]=std::min(c[j],pos-1);
  }
}
```

这样虽然是$O(n^2)$的,但是其中更新整个区间的操作,可以用类似"差分序列"的技巧,打标记来优化到$O(n)$  

```cpp
for(int i=1; i<=n; i++) c[i]=n;

for(int p: primes) if(at[i].size()>1){
  for(int i=1,sz=int(at[p].size()); i<sz; i++){
    int lim=at[p][i-1],pos=at[p][i];
    c[lim]=std::min(c[j],pos-1);
  }
}
for(int i=n;i>1;i--) c[i-1]=std::min(c[i],c[i-1]);
```


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
const int P=18;
int vis[N],prime[N],cnt,son[N];
void sieve(){
	for(int i=2;i<N;i++){
		if(!vis[i]){
			prime[cnt++]=i;
			son[i]=i;
		}
		for(int j=0;j<cnt&&1LL*i*prime[j]<N;j++){
			int t=i*prime[j]; vis[t]=1;
			if(i%prime[j]==0){
				son[t]=son[i];
				break;
			}
			son[t]=prime[j];
		}
	}
}

std::vector<int> at[N];
int n,m,a[N],tag[N];
int trans[N][18];

int main(){
	sieve();
	n=read(); m=read();
	for(int i=1;i<=n;i++){
		a[i]=read(); tag[i]=n;

		int x=a[i];
		while(x>1){
			int p=son[x];
			while(x%p==0) x/=p;
			at[p].push_back(i);
		}
	}


	for(int i=0;i<cnt;i++){
		auto &v=at[prime[i]];
		int sz=int(v.size());
		for(int i=1;i<sz;i++){
			int lim=v[i-1],pos=v[i];
			tag[lim]=std::min(tag[lim],pos-1);
		}
	}
	for(int i=n;i>1;i--) tag[i-1]=std::min(tag[i-1],tag[i]);


	for(int i=1;i<=n;i++) trans[i][0]=tag[i]+1;
	for(int j=0;j<P;j++) trans[n+1][j]=n+1;
	for(int j=1;j<P;j++){
		for(int i=1;i<=n;i++) trans[i][j]=trans[trans[i][j-1]][j-1];
	}


	while(m--){
		int l=read(),r=read();
		int ans=0;
		for(int i=P-1;i>=0;i--){
			int v=trans[l][i];
			if(v<=r){ l=v; ans+=(1<<i); }
		}
		printf("%d\n",ans+1);
	}

	return 0;
}
```

