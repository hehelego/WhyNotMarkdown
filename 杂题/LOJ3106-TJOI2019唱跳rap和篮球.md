## [TJOI2019]唱跳rap和篮球


### problem statement

输入$a,b,c,d,n\in \mathbb{N}$,满足$n\geq a+b+c+d$

表示给出$S=\{a\times 1,b\times 2, c\times 3, d\times 4\}$其中  
求$S$的$n$-permutation $p=p_1p_2\ldots p_n$  
满足$\forall i\in[n]\quad (p_{i+0}p_{i+1}p_{i+2}p_{i+4})\neq (1234)$  
的计数,模`998244353`


- [link:luogu P5339](https://www.luogu.com.cn/problem/P5339) 
- [link:loj 3106](https://loj.ac/p/3106)

### solution

考虑容斥,  


计算选定序列中的$k$个位置,(至少)以这些位置开始,出现了`1234`的排列计数.  
设选中$\{i_a\times 1,i_b\times 2,i_c\times 3,i_d\times 4\}$,其中$i_a+i_b+i_c+i_d=n$.  
我们分别取$k$个$1,2,3,4$按顺序组合固定在一起,可转化为求  
$T=\{k\times 0, (i_a-k)\times 1,(i_b-k)\times 2,(i_c-k)\times 3,(i_d-k)\times 4\}$的排列,  
方案数为$\frac{(n-3k)!}{k!(i_a-k)!(i_b-k)!(i_c-k)!(i_d-k)!}$

固定$k$,枚举$n$,得到一个序列,其生成函数为

$$
\begin{aligned}
F_k(x)&=\sum_{n=0}^\infty x^n \sum_{\begin{subarray}{c}
\end{subarray}}
\frac{(n-3k)!}{k!(i_a-k)!(i_b-k)!(i_c-k)!(i_d-k)!}\\
&=\frac{(n-3k)!}{k!}\sum_{n=0}^\infty \sum_{\begin{subarray}{c}
i_a+i_b+i_c+i_d=n\\ k\leq i_a\leq a\, k\leq i_b\leq b\,k\leq i_c\leq c\, k\leq i_d\leq d
\end{subarray}}
\frac{x^{i_a}}{(i_a-k)!} \frac{x^{i_b}}{(i_b-k)!} \frac{x^{i_c}}{(i_c-k)!} \frac{x^{i_d}}{(i_d-k)!}\\
&=\frac{(n-3k)!}{k!}
\left(\sum_{i_a=k}^a \frac{x^{i_a}}{(i_a-k)!}\right)
\left(\sum_{i_b=k}^b \frac{x^{i_b}}{(i_b-k)!}\right)
\left(\sum_{i_c=k}^c \frac{x^{i_c}}{(i_c-k)!}\right)
\left(\sum_{i_d=k}^d \frac{x^{i_d}}{(i_d-k)!}\right)\\
&=\frac{(n-3k)!}{k!}x^{4k}
\left(\sum_{i_a=0}^{a-k} \frac{x^{i_a}}{i_a!}\right)
\left(\sum_{i_b=0}^{b-k} \frac{x^{i_b}}{i_b!}\right)
\left(\sum_{i_c=0}^{c-k} \frac{x^{i_c}}{i_c!}\right)
\left(\sum_{i_d=0}^{d-k} \frac{x^{i_d}}{i_d!}\right)\\
\end{aligned}
$$

再考虑子集反演,以获得容斥系数

> 令$f(S),g(S)$分别表示
> - $i\in S\iff (p_{i+0}p_{i+1}p_{i+2}p_{i+3})=(1234)$的排列计数.
> - $i\in S\implies (p_{i+0}p_{i+1}p_{i+2}p_{i+3})=(1234)$的排列计数.
> 
> 有$g(S)=\sum_{S\subseteq T}f(T)$,于是$f(S)=\sum_{S\subseteq T}{(-1)}^{|T|-|S|}f(T)$  
> 所求即$f(\varnothing)=\sum_{S}{(-1)}^{|S|}g(S)$.  
> 而之前求得的$[x^n]F_k(x)=\sum_{|S|=k}g(S)$,于是$f(\varnothing)=\sum_{k=0}^n \binom{n}{k} {(-1)}^k [x^n]F_k(x)$

所以应该带上${(-1)}^k$的系数.

### code

```cpp
#include <bits/stdc++.h>
using I64=signed long long int;
const I64 mod=998244353LL;
I64 qpow(I64 a, I64 b){
	a%=mod; I64 r=1;
	while(b){
		if(b&1) r=r*a%mod;
		a=a*a%mod; b>>=1;
	}
	return r;
}
const int N=1000;

int n,a,b,c,d;
I64 fac[N],ifac[N];

static inline I64 binom(int n,int k){
	if(k<0||n<k) return 0;
	return fac[n]*ifac[k]%mod*ifac[n-k]%mod;
}

struct Poly{
	I64 a[N];
	Poly(){ memset(a,0,sizeof(a)); }
	I64 operator[](int i)const{ return a[i];}
	I64& operator[](int i){ return a[i];}
	Poly operator*(const Poly &b)const{
		Poly c;
		for(int i=0;i<N;i++) for(int j=0;i+j<N;j++){
			I64 &t=c[i+j]; t=(t+a[i]*b[j])%mod;
		}
		return c;
	}
}pa,pb,pc,pd;
static I64 solve(int k){
	if(n-4*k<0) return 0;
	Poly prod=pa*pb*pc*pd;
	return prod[n-4*k]*fac[n-3*k]%mod*ifac[k]%mod;
}
static inline int minval(int a,int b,int c,int d){
	a=std::min(a,b);
	a=std::min(a,c);
	a=std::min(a,d);
	return a;
}

int main(){
	fac[0]=ifac[0]=1;
	for(int i=1;i<N;i++){
		fac[i]=fac[i-1]*i%mod;
		ifac[i]=qpow(fac[i],mod-2);
	}

	std::cin>>n>>a>>b>>c>>d;
	for(int i=0;i<=a;i++) pa[i]=ifac[i];
	for(int i=0;i<=b;i++) pb[i]=ifac[i];
	for(int i=0;i<=c;i++) pc[i]=ifac[i];
	for(int i=0;i<=d;i++) pd[i]=ifac[i];

	I64 ans=0; int lim=minval(a,b,c,d);
	for(int k=0;k<=lim;k++){
		if(k&1) ans=(ans-solve(k)+mod)%mod;
		else ans=(ans+solve(k))%mod;
		pa[a-k]=pb[b-k]=pc[c-k]=pd[d-k]=0;
	}
	std::cout<<ans<<std::endl;
	return 0;
}
```
