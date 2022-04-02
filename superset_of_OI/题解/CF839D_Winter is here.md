# CF839D Winter is here

## statement

给一个正整数序列$(a_1,a_2,a_3\dots a_n)$.
定义$H(S)=\gcd_{i\in S}(a_i)=\max\{d\mid \forall i\in S,d\mid a_i\}$.
所有满足元素最大公因子大于$1$的子序列的 gcd 乘元素数量的求和,即

$$
\sum_{S\subseteq\{1,2,3\dots n\}}|S|[H(S)\neq 1]H(S)
$$

## solution

挺正常的莫比乌斯反演...

令$\text{eq}(i)=\sum_{j=1}^n [a_j=i],\text{div}(i)=\sum_{j=1}^n[i\mid a_j],m=\max_i a_i$
设

$$
f(d)=\sum_{S\subseteq \{1,2,3\dots n\}}[H(S)=d]|S|\\
g(d)=\sum_{S\subseteq \{1,2,3\dots n\}}[d\mid H(S)]|S|
$$

有

$$
g(d)=\sum_{1\leq i}f(id)\\
f(d)=\sum_{1\leq i}\mu(i)g(id)\\
\text{proof: }\sum_{1\leq i}\mu(i)g(in)=\sum_{1\leq i}\mu(i)\sum_{1\leq j} f(j\times in)\\
\text{let }T=ij\\
\sum_{1\leq T}\sum_{d\mid T}\mu(d)f(Tn)=\sum_{1\leq T}f(Tn)\sum_{d\mid T}\mu(d)=\sum_{1\leq T}f(Tn)[T=1]=f(n)
$$

我们要求的答案是

$$
\text{ans: }\sum_{2\leq i}if(i)=\sum_{2\leq i}i\sum_{1\leq j}\mu(j)g(ij)\\
=\sum_{2\leq T}g(T)\sum_{d\mid T,d> 1}d\mu(\frac{T}{d})\\
=\sum_{2\leq T}g(T)(\sum_{d\mid T}d\mu(\frac{T}{d})-1\mu(\frac{T}{1}))\\
=\sum_{2\leq T}g(T)(\varphi(T)-\mu(T))
$$

其中

$$
g(d)=\sum_{i=1}^{\text{div(d)}}\binom{\text{div}(d)}{i}i\\
F(n)=\sum_{i=1}^n\binom{n}{i}i=\sum_{i=1}^n\frac{n!}{i!(n-i)!}i
=n\sum_{i=1}^n\frac{(n-1)!}{(i-1)!(n-i)!}\\
=n\sum_{i=1}^n\binom{n-1}{i-1}
=n\sum_{i=0}^{n-1}\binom{n-1}{i}
=n2^{n-1}
$$

## code

```cpp
#include <bits/stdc++.h>
// div这个标识符被用过了...套个namespace解决命名冲突.
namespace spinach{
	int read(){
		int x=0;char c;
		do{c=getchar();}while(!isdigit(c));
		do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
		return x;
	}
	typedef long long Int;
	const Int mod=1000000007LL;
	const int M=1000000+1;
	int n,eq[M],div[M];

	int vis[M],prime[M],cnt,mu[M],phi[M],pw2[M];
	void sieve(){
		phi[1]=mu[1]=1;
		pw2[0]=1; pw2[1]=2;
		for(int i=2;i<M;i++){
			pw2[i]=2LL*pw2[i-1]%mod;
			if(!vis[i]){
				prime[cnt++]=i;
				mu[i]=-1; phi[i]=i-1;
			}
			for(int j=0;j<cnt&&i*prime[j]<M;j++){
				int t=i*prime[j]; vis[t]=1;
				if(i%prime[j]==0){
					mu[t]=0;
					phi[t]=phi[i]*prime[j];
					break;
				}
				mu[t]=-mu[i];
				phi[t]=phi[i]*(prime[j]-1);
			}
		}
	}

	Int g(Int d){ d=div[d];
		return d>0?1LL*d*pw2[d-1]%mod:0LL;
	}
	Int fix(Int x){ return (x%mod+mod)%mod; }

	int main(){
		sieve();
		n=read(); for(int i=0;i<n;i++) eq[read()]++;
		for(int i=1;i<M;i++) for(int j=1;i*j<M;j++) div[i]+=eq[i*j];

		Int ans=0,tmp=0;
		for(int k=2;k<M;k++){
			tmp=fix(phi[k]-mu[k])*g(k)%mod;
			ans=(ans+tmp)%mod;
		}
		std::cout<<ans<<std::endl;
		return 0;
	}
}
int main(){ return spinach::main(); }
```
