## NOIOL rnd3 魔法值

### statement

[link](https://www.luogu.com.cn/problem/P6569)
给定一个无向图$G=(V,E)$,以及$f_{u,0}$(即点$x$带上$f_{x,0}$的权值)
定义$f_{u,i}=\oplus_{(u,v)\in E}f_{v,i-1)}$其中($\oplus$即异或运算)

$q$次查询,给定$k$求出$f(k,1)$.
其中$|V|\leq 100,\ q\leq 100,\ k< 2^{32},\ f_{x,0}< 2^{32}$.

### solution

显然二进制下不同位之间无关.于是考虑拆$2^0,2^1\dots 2^{31}$按位分别处理
一位二进制数字的$\oplus$运算相当于是模$2$意义下的$+$
对于每一位而言$f_{u,i}=(\sum_{v}[(u,v)\in E]f_{v,i-1})\bmod 2$.发现它可以写成矩阵乘法.
这里把加换回按位异或,乘用按位与代替,发现可以不用拆位而直接一起处理.即$(u,v)\in E\implies A_{u,v}=A_{v,u}=\sum_{0\leq i< 32}2^i$

然后搞个矩阵快速幂求出$A^k$再$f_{k,i}=\oplus\ ((A^k)_{i,j}\&f_{0,j})$,这样有了$O(qn^3\log k)$的算法了.
最后我们用上常规技巧,预处理$A^{2^i}\ (i=0,1,2\dots 31)$,然后用$\vec f$分别乘矩阵,这样每次乘是$O(n^2)$的最多乘$\log k$次.于是就是$O(qn^2\log k)$的做法了,可以过了.

### code

```cpp
#include <bits/stdc++.h>
typedef unsigned int Int;
Int read(){
	Int x=0;char c;
	do{c=getchar();}while(!isdigit(c));
	do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
	return x;
}
const int N=100;
const int M=32;
int n,m;
Int f[N],tmp[N],cpy[N];
struct Matrix{
	Int a[N][N];
	Matrix(){ memset(a,0,sizeof(a)); }
	Int *operator[](int x){ return a[x]; }
	const Int *operator[](int x)const{return a[x];}
}g[M];
Matrix operator*(const Matrix&a,const Matrix&b){
	Matrix c;
	for(int i=0;i<n;i++) for(int j=0;j<n;j++){
		Int r=0;
		for(int k=0;k<n;k++) r=r^(a[i][k]&b[k][j]);
		c[i][j]=r;
	}
	return c;
}
Matrix identity(){ Matrix c; for(int i=0;i<n;i++) c[i][i]=1; return c; }
Matrix qpow(Matrix a,Int p){
	Matrix c=identity();
	while(p){
		if(p&1) c=c*a;
		a=a*a; p>>=1;
	}
	return c;
}
void vec_mul(const Matrix& m,Int *vec){
	for(int i=0;i<n;i++) cpy[i]=tmp[i];
	for(int i=0;i<n;i++){ vec[i]=0;
		for(int j=0;j<n;j++) vec[i]=vec[i]^(m[i][j]&cpy[j]);
	}
}
Int solve(Int k){
	for(int i=0;i<n;i++) tmp[i]=f[i];
	for(Int i=0;i<M;i++) if(k&(1u<<i)) vec_mul(g[i],tmp);
	return tmp[0];
}

int main(){
	n=read();m=read();
	int q=read(),ai=0;
	for(int i=0;i<n;i++) f[i]=read();
	for(int i=0,a,b;i<m;i++){
		a=read()-1;b=read()-1;
		g[0][a][b]=g[0][b][a]=~(0u);
	}
	for(int i=1;i<M;i++) g[i]=g[i-1]*g[i-1];
	while(q--){
		ai=read();
		std::cout<<solve(ai)<<std::endl;
	}
	return 0;
}
```
