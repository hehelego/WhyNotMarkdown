## CF449D Jzzhu and Numbers

### statement
[link](https://www.luogu.com.cn/problem/CF449D) 
给定$n$个$20$位二进制数.
$1..n$的非空子集$S$使得$(\&_{i\in S}a_i)=\phi$其中$\&$位按位与操作.
对这样的S进行计数.

### solution

设$F(S)$为$(\&a_i)=S$的计数
$G(S)$为$S\subseteq (\&a_i)$的计数.

根据定义$G(S)=\sum_{S\subseteq T}F(T),F(S)=\sum_{S\subseteq T}(-1)^{|T-S|}G(T)$
答案即为$F(\phi)$

若$S\subseteq a_i$的$a_i$数量为$k(S)$则$G(S)=2^{k(S)}-1$
先统计$cnt(x)=\sum [a_i=x]$
那么$k(S)=\sum_{S\subseteq T}cnt(T)$

所以瓶颈在于这样一个问题,给定$f(S)$求$g(S)=\sum_{S\subseteq T}f(T)$.
需要高维前缀和这个技巧(就是FMT).
不会的话也是可以做的,转成$20$维偏序,分治来做就行了(可能需要些玄学技巧,直接暴力分治的话对于$n$点的$k$维偏序问题是$O(n\log ^k n)$的,显然过不去…).

### code

#### 暴力子集和

复杂度$O(v^3)$其中$v=\max \lceil\log a_i\rceil$.

```cpp
#include <bits/stdc++.h>
typedef long long Int;
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}

const int M=20;
const int N=1<<M;
const int all=N-1;
const Int mod=1000000007LL;
int n,a[N],popcnt[N],b[N]; Int pw2[N];


inline Int g(int s){ return pw2[b[s]]-1; }
inline void gtm(){
	std::cerr<<"CURRENT TIME:"<<1.0*clock()/CLOCKS_PER_SEC<<std::endl;
}

void solve(){
}

int main(){
	pw2[0]=1; for(int i=1;i<N;i++) pw2[i]=2*pw2[i-1]%mod;
	for(int i=1;i<N;i++) popcnt[i]=popcnt[i>>1]+(i&1);

	n=read(); for(int i=0;i<n;i++) a[read()]++;
	gtm();
	for(int i=0;i<N;i++){
		for(int s=i;s;s=(s-1)&i) b[s]+=a[i];
		b[0]+=a[i];
	}

	Int ans=0;
	for(int s=0;s<N;s++){
		if(popcnt[s]&1) ans=(ans-g(s)+mod)%mod;
		else ans=(ans+g(s))%mod;
	}
	std::cout<<ans<<std::endl;
	gtm();
	return 0;
}
```

#### 高维偏序-分治

**notice:这个比上面的暴力更慢,毕竟有log^k(n)**

```cpp
#include <bits/stdc++.h>
typedef long long Int;
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}

const int M=20;
const int N=1<<M;
const Int mod=1000000007LL;
int n,a[N],popcnt[N],b[N]; Int pw2[N];


inline Int g(int s){ return pw2[b[s]]-1; }
inline void gtm(){ std::cerr<<"CURRENT TIME:"<<1.0*clock()/CLOCKS_PER_SEC<<std::endl; }


typedef std::vector<int> Vec;
void solve(int bit,const Vec&p,const Vec&q){
	if(p.size()==0||q.size()==0) return ;
	if(bit>=M){
		int s=0; for(int i:p)s+=a[i];
		for(int i:q) b[i]+=s;
		return ;
	}

	Vec p0,p1,q0,q1;
	for(int i:p){
		if((i>>bit)&1) p1.push_back(i);
		else p0.push_back(i);
	}
	for(int i:q){
		if((i>>bit)&1) q1.push_back(i);
		else q0.push_back(i);
	}
	solve(bit+1,p1,q0);
	solve(bit+1,p0,q0); solve(bit+1,p1,q1);
}

int tmp[N];
void cpy(int *s,int *t,int l,int r){ for(int i=l;i<=r;i++) t[i]=s[i]; }
void solve(int bit,int *p,int pl,int pr,int *q,int ql,int qr){
	if(pl>pr||ql>qr) return ;
	if(bit>=M){
		int s=0; for(int i=pl;i<=pr;i++)s+=a[p[i]];
		for(int i=ql;i<=qr;i++) b[q[i]]+=s;
		return ;
	}
	cpy(p,tmp,pl,pr);
	int p0=pl-1,p1=pr+1;
	for(int i=pl;i<=pr;i++){
		int j=tmp[i];
		if((j>>bit)&1) p[--p1]=j;
		else p[++p0]=j;
	}

	cpy(q,tmp,ql,qr);
	int q0=ql-1,q1=qr+1;
	for(int i=ql;i<=qr;i++){
		int j=tmp[i];
		if((j>>bit)&1) q[--q1]=j;
		else q[++q0]=j;
	}

	solve(bit+1,p,p1,pr,q,ql,q0);
	solve(bit+1,p,pl,p0,q,ql,q0); solve(bit+1,p,p1,pr,q,q1,qr);
}
int p[N],q[N];
void solve(){
	for(int i=0;i<N;i++) p[i]=q[i]=i;
	solve(0,p,0,N-1,q,0,N-1);
}

void DEBUG(){
	for(int i=0;i<8;i++) printf("b[%d]=%d\n",i,b[i]);
}

int main(){
	pw2[0]=1; for(int i=1;i<N;i++) pw2[i]=2*pw2[i-1]%mod;
	for(int i=1;i<N;i++) popcnt[i]=popcnt[i>>1]+(i&1);

	n=read(); for(int i=0;i<n;i++) a[read()]++;

	gtm();
	//Vec p; for(int i=0;i<N;i++) p.push_back(i); solve(0,p,p);
	solve();
	Int ans=0;
	for(int s=0;s<N;s++){
		if(popcnt[s]&1) ans=(ans-g(s)+mod)%mod;
		else ans=(ans+g(s))%mod;
	}
	std::cout<<ans<<std::endl;
	gtm();
	DEBUG();
	return 0;
}
```

#### FMT(高维前缀和)

```cpp
#include <bits/stdc++.h>
typedef long long Int;
int read(){
	int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}

const int M=20;
const int N=1<<M;
const Int mod=1000000007LL;
int n,a[N],popcnt[N]; Int pw2[N];


inline Int g(int s){ return pw2[a[s]]-1; }
inline void gtm(){ std::cerr<<"CURRENT TIME:"<<1.0*clock()/CLOCKS_PER_SEC<<std::endl; }



void solve(){
	for(int i=0;i<M;i++) for(int j=N-1;j>=0;j--){
		if((j&(1<<i))==0) a[j]=(a[j]+a[j|(1<<i)]);
	}
}

int main(){
	pw2[0]=1; for(int i=1;i<N;i++) pw2[i]=2*pw2[i-1]%mod;
	for(int i=1;i<N;i++) popcnt[i]=popcnt[i>>1]+(i&1);

	n=read(); for(int i=0;i<n;i++) a[read()]++;

	gtm();
	solve();
	Int ans=0;
	for(int s=0;s<N;s++){
		if(popcnt[s]&1) ans=(ans-g(s)+mod)%mod;
		else ans=(ans+g(s))%mod;
	}
	std::cout<<ans<<std::endl;
	gtm();
	return 0;
}
```

