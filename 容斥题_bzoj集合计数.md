题目在[这里 BZOJ2839](<https://oi-archive.memset0.cn/problem/bzoj/2839>)
对于$\{1,2,3\dots n\}$的所有子集(共$2^n$个),选出其中一些$T=\{A_1,A_2\dots A_m\}$使得$|\cap_{i=1}^m A_i|=k$.
求满足这样约束的集合簇$T$的数量.

---



设$g(S)$为选出的$T=(A_1,A_2,A_3\dots A_m)$满足$S\subseteq (\cap A_i)$的$T$的计数,

设$f(S)$为选出的$T=(A_1,A_2,A_3\dots A_m)$满足$S=(\cap A_i)$的$T$的计数.



根据定义$g(S)=\sum_{S\subseteq T}f(T)$,子集反演,得到$f(S)=\sum_{S\subseteq T}(-1)^{|T|-|S|}g(T)$.



计算$g(S)$考虑$T^\prime=(A_1,A_2\dots A_m)$,其中$A_i\cap S=\phi$.则$T=(A_1\cup S,A_2\cup S\dots A_m\cup S)$为一个对$g(S)$有贡献$1$的方案,$T$与$T^\prime$是一一对应的.

考虑对$T^\prime$计数.$A_i\subseteq (all\setminus S)$,有$2^{n-|S|}$个子集,随便选其中一些(不能选出$T'=\{\}$)那就是$pow(2,2^{n-|S|})-1$.

于是$g(S)=pow(2,2^{n-|S|})-1$.我们发现这是个和$|S|$有关,而和$S$具体取值没有关系,于是我们设$k=|S|,g(S)=G(|S|)=G(k)=pow(2,2^{n-k})-1$.此外再设$f(S)=F(|S|)$.

于是有$F(k)=\sum_{i=k}^n\binom{n-k}{i-k}(-1)^{i-k}G(i)=\sum_{i=k}^n \binom{n-k}{i-k}(-1)^{i-k}(pow(2,2^{n-i})-1)$.

然后答案就是$\binom{n}{k}F(k)$



---

实现的时候有一个小问题,就是$pow(2,2^{n-i})\equiv pow(2,2^{n-i}\bmod \varphi(p))\pmod p$,其中$p$是一个质数,如果膜的不是质数(求解幂的时候不能保证底数和模数互质),按照扩展欧拉定理$a^b\equiv \begin{cases}a^b&(b\lt \varphi(p))\\a^{(b\bmod \varphi(p))+\varphi(p)}&(b\ge \varphi(p))\end{cases}\pmod p$进行计算,复杂度不变.

我写得复杂度多个$O(\log p)$,考虑$pow(2,2^k)=pow^2(2,2^{k-1})$递推求解它,就可以去掉这个求解幂所用的$O(\log p)$.

组合数的话,用到的$\binom{n}{m}=\frac{n!}{m!(n-m)!}$都满足$n,m\lt p$,而且又有$p$是质素,所以下面的逆元都是存在的,直接预处理阶乘算就行了…$n,m\geq p$的话使用$lucas$定理求解,同时复杂度多一个$O(\log n)$,模数不是质数,是square free的好做,拆开分别lucas求解,CRT合并,不然的话需要些奇特技巧(OI里面似乎叫扩展lucas…).



就瞎扯到这里吧,扔一个代码,窝写的复杂度是$O(n\log p)$的.

```cpp
#include <bits/stdc++.h>
typedef long long Int;
const Int mod=1000000007LL;
Int fix(Int x){ return (x%mod+mod)%mod; }
Int qpow(Int a,Int p=mod-2){
	Int r=1; a=fix(a); while(p){
		if(p&1) r=r*a%mod;
		a=a*a%mod; p>>=1;
	} return r;
}
const int N=1000000+10;
Int inv[N],fac[N],ifac[N],pw2[N];
inline Int binom(int n,int m){
	if(m>n||m<0) return 0;
	return fac[n]*ifac[n-m]%mod*ifac[m]%mod;
}
int main(){
	Int n,k; std::cin>>n>>k;
	fac[0]=ifac[0]=fac[1]=ifac[1]=inv[1]=1;
	pw2[0]=1; pw2[1]=2;
	for(int i=2;i<N;i++){
		pw2[i]=pw2[i-1]*2%(mod-1);
		inv[i]=fix(-(mod/i)*inv[mod%i]);
		fac[i]=fac[i-1]*i%mod;
		ifac[i]=ifac[i-1]*inv[i]%mod;
	}
	Int ans=0;
	for(int i=k;i<=n;i++){
		Int tmp=binom(n-k,i-k)*(qpow(2,pw2[n-i])-1)%mod;
		if((i-k)%2==1) ans=(ans-tmp+mod)%mod;
		else ans=(ans+tmp)%mod;
	}
	std::cout<<ans*binom(n,k)%mod<<std::endl;
	return 0;
}

```