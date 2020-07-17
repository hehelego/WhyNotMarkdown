## statement

求$\prod_{i=1}^n\prod_{j=1}^n(\frac{i}{(i,j)}\frac{j}{(i,j)})$模大(远大于$n$)质数$p$.



## solution

常规题...


$$
\prod_{i=1}^n\prod_{j=1}^n(\frac{i}{(i,j)}\frac{j}{(i,j)})
=\frac{\prod_{i=1}^n\prod_{j=1}^n ij}{\prod_{i=1}^n\prod_{j=1}^n (i,j)^2}=\frac{A(n)}{B(n)}\\

A(n)=\prod_{i=1}^n\prod_{j=1}^nij=\prod_{i=1}^n i^n\prod_{j=1}^n j=\prod_{i=1}^n i^n n!
=(n!)^n\prod_{i=1}^n i^n=(n!)^n(\prod_{i=1}^n i)^n=(n!)^{2n}\\
B(n)=\prod_{i=1}^n\prod_{j=1}^n (i,j)^2
=\prod_{d=1}^n\text{power}(d^2,\sum_{i=1}^n\sum_{j=1}^n[(i,j)=d])\\

\sum_{i=1}^n\sum_{j=1}^n[(i,j)=d]
=\sum_{id\leq n}\sum_{jd\leq n}[(i,j)=1]\\
=\sum_{id\leq n}\sum_{jd\leq n}\sum_{p\mid i\and p\mid j}\mu(p)
=\sum_{dp\leq n}\mu(p)\lfloor\frac{n}{pd}\rfloor\lfloor\frac{n}{pd}\rfloor\\
=\sum_{i=1}^{\lfloor\frac{n}{d}\rfloor} \mu(i){\lfloor\frac{n}{id}\rfloor}^2\\

B(n)=\prod_{d=1}^n\text{power}(d^2,\sum_{i=1}^{\lfloor\frac{n}{d}\rfloor}\mu(i){\lfloor\frac{n}{id}\rfloor}^2)\\
$$


对于$B$我们按照$\lfloor\frac{n}{d}\rfloor$对$1..n$分段,每一段都是$\prod_{i=l}^r\text{power}(i^2,k)=(\prod_{i=l}^ri)^{2k}$其中$k=\sum_{i=1}^{m}\mu(i)\lfloor\frac{m}{i}\rfloor^2,m=\lfloor\frac{n}{d}\rfloor$



### notice

- 对于$k$的计算,考察$B(n)$,$k$是位于指数位置,所以$k$应该在$\bmod \varphi(p)$意义下进行计算而非$\bmod p$
- 复杂度分析$\sum_{i=1}^{\sqrt n} \sqrt{i}+\sqrt{\frac{n}{i}}$用积分代替求和估计,是$O(n^{\frac34})$的.



## code

```cpp
#include <bits/stdc++.h>
typedef long long Int;
const Int mod=19260817LL;
Int fix(Int x,Int m){ return (x%m+m)%m; }
Int qpow(Int a,Int b=mod-2){
	Int r=1;
	a=fix(a,mod); b=fix(b,mod-1);
	while(b){
		if(b&1) r=r*a%mod;
		a=a*a%mod; b>>=1;
	} return r;
}

const int N=1000000+10;
int vis[N],prime[N],cnt,mu[N];
Int inv[N],fac[N],ifc[N],smu[N];
void init(){
	fac[0]=fac[1]=1;
	ifc[0]=ifc[1]=1;
	smu[1]=inv[1]=mu[1]=1;
	for(int i=2;i<N;i++){
		if(vis[i]==0){ prime[cnt++]=i; mu[i]=-1; }
		for(int j=0;j<cnt&&i*prime[j]<N;j++){
			int t=i*prime[j]; vis[t]=1;
			if(i%prime[j]==0){ mu[t]=0; break; }
			mu[t]=-mu[i];
		}
		inv[i]=fix(-(mod/i)*inv[mod%i],mod);
		smu[i]=smu[i-1]+mu[i];
		fac[i]=i*fac[i-1]%mod;
		ifc[i]=ifc[i-1]*inv[i]%mod;
		assert(fac[i]*ifc[i]%mod==1);
	}
}

Int prod(int l,int r){ return fac[r]*ifc[l-1]%mod; }
Int g(int n){
	Int ret=0; int l=1,r=n,q=0;
	while(l<=n){
		q=n/l; r=n/q;
		Int tmp=fix(smu[r]-smu[l-1],mod-1)*q%(mod-1)*q%(mod-1);
		ret=(ret+tmp)%(mod-1);
		l=r+1;
	}
	return ret;
}
Int solve(int n){
	Int A=qpow(fac[n],2*n),B=1;
	int l=1,r=n,q=0; while(l<=n){
		q=n/l; r=n/q;
		Int tmp=prod(l,r); tmp=tmp*tmp%mod;
		B=B*qpow(tmp,g(q))%mod;
		l=r+1;
	}
	return A*qpow(B)%mod;;
}
int main(){
	init();
	std::ios::sync_with_stdio(false);
	int T;std::cin>>T;
	while(T--){
		int n; std::cin>>n;
		std::cout<<solve(n)<<std::endl;
	}
	return 0;
}
```



