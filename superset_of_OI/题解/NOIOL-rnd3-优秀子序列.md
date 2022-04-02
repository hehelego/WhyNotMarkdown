# NOIOL rnd3:优秀子序列

## statement

目前似乎只在 luogu 有[link](https://www.luogu.com.cn/problem/P6570),官方数据没有公布,测试数据是网友造的.

给一个非负整数序列$(a_1,a_2,a_3\dots a_n)$求

$$
\sum_{k=0}^{n}\sum_{1\leq b_1< b_2< b_3\dots b_k\leq n}[\forall (i,j),(i\neq j)\implies a_{b_i}\land a_{b_j}=0]\varphi(1+\sum a_{b_i})
$$

其中$a_i\land a_j$是二进制下的按位与操作,$\varphi(n)=\sum_{i=1}^n[\gcd(i,n)=1]$即欧拉函数.
即对于所有满足任意两个元素按位与结果为 0 的子序列,1 加上元素和的欧拉函数值求和.

$n\leq 10^6,0\leq a_i\leq 2\times 10^5$.

## solution

**note** 下文中,对于这些对象不做区分:一个元素本身,一个元素的二进制表示,一个大小不超过 ceil(log max a)的集合

首先这个$\varphi(1+\sum a_{b_i})$中的$\sum a_i$如果是自由的,那么我们可能要求出$\varphi(i)\ (0< i\leq n\max  a_i)$在这个数据范围上目前(这个题是 2020 年的 OI 题目,大概是 CPU 2.5GHz,2s 时间,256MB 存储,不允许并行)是不可做的.于是我们非常自然的猜想满足$[\forall (i,j),(i\neq j)\implies a_{b_i}\land a_{b_j}=0]$时$\sum a_{b_i}$是$O(\max a_i)$,而不是$O(\sum a_i)$的.
这个猜想是正确的,考虑$a_i\land a_j=0$的意义,即二进制表示下$a_i,a_j$的,不存在某一位都是$1$,于是它们相加的时候不会出现进位,有$0,0\to 0;0,1\to 1$这正好符合异或的规则,不同的位是独立的,所以$(a_i\land a_j=0)\implies (a_i+a_j=a_i\oplus a_j)$其中$\oplus$是二进制下按位异或操作.而这可以从 2 个元素的子序列推广到任意多个元素的子序列上面,$(\forall (i,j)\ (i\neq j)\implies a_{b_i}\land a_{b_j}=0)\implies \sum a_{b_i}=\oplus a_{b_i}$所以$\sum a_{b_i}$最大就是$\lceil \log_2\max a_i\rceil$位全是$1$,它不超过$2\max a_i$.

这下我们放心了,只需要求$[0..2\max a_i]$的$\varphi$,这个时间是可以接受的.
另一方面,由于$\sum a_{b_i}$是$O(\max a_i)$的,我们找不出什么$\varphi$的特殊性质帮助我们计算,不妨尝试对$1,2\dots 2\max a_i$分别求$f(d)$表示满足任意两元素 and 为 0,且$\sum a_{b_i}=\oplus a_{b_i}=d$的子序列计数.

$$
f(d)=\sum_{k=0}^{n}\sum_{1\leq b_1< b_2\dots b_k\leq n}[\forall (i,j),(i\neq j)\implies a_{b_i}\land a_{b_j}=0][\sum a_{b_i}=d]\\
=\sum_{k=0}^{n}\sum_{1\leq b_1< b_2\dots b_k\leq n}[\forall (i,j),(i\neq j)\implies a_{b_i}\land a_{b_j}=0][\oplus a_{b_i}=d]\\
$$

我们令$c_k=\sum [a_i=k]$初始的$f(0)=1$,递推式$f(S)=\sum_{\phi\subsetneq T\subseteq S}f(S\setminus T)c_{T}$不过这样有点小问题,就是$\{1,2\}$和$\{2,1\}$会被认为是不同方案,我们可以强制$T$是选中子序列中的最大元素(强制是选最小也行),因为这个 and 为 0 的约束所以这个子序列没有相等元素,于是$T> T-S$.
最后$f(S)\to 2^{c_0}f(S)$把最特殊可以随便选的$0$考虑进来.

到这里已经可以做到$O(\max a_i+3^m)$其中$m=\lceil\log_2\max a_i\rceil$.还可以用 FWT 处理转移(是个子集卷积,大概找找集合幂级数 沃尔什变换 子集卷积等关键词就会有,我不清楚它的英文叫什么)做到更好的复杂度.

## code

强制$T$是凑出异或和为$S$的子序列中的最大值,可以更方便一点,考虑$T,S$的二进制表示,其最高的非 0 位置应当相同.
这可以用 gcc 提供的`__builtin_clz`来判定,它求的是 32 位二进制表示下的前导零数量.

```cpp
#include <bits/stdc++.h>
int read(){
  int x=0;char c;
  do{c=getchar();}while(!isdigit(c));
  do{x=x*10+c-'0';c=getchar();}while(isdigit(c));
  return x;
}
const int N=400000+10;
const int M=18; // ceil(ln(N) / ln(2))
const int mod=1000000007;
int n,c[N],f[N];

int vis[N],prime[N],cnt,phi[N];
void sieve(){
  phi[1]=1; for(int i=2;i<N;i++){
    if(!vis[i]){
      prime[cnt++]=i;
      phi[i]=i-1;
    }
    for(int j=0;j<cnt&&i*prime[j]<N;j++){
      int t=i*prime[j]; vis[t]=1;
      if(i%prime[j]==0){phi[t]=phi[i]*prime[j]; break;}
      phi[t]=phi[i]*(prime[j]-1);
    }
  }
}

#define clz __builtin_clz

int main(){
  sieve(); n=read();
  for(int i=0;i<n;i++) c[read()]++;
  int pw2=1; for(int i=0;i<c[0];i++) pw2=2LL*pw2%mod;

  c[0]=0; f[0]=1;
  for(int s=1;s<(1<<M);s++){
    for(int i=s;i>0;i=(i-1)&s){
      if(clz(i)==clz(s)) f[s]=(f[s]+1LL*f[s^i]*c[i])%mod;
    }
  }

  int ans=0;
  for(int i=1;i<N;i++){
    f[i-1]=1LL*f[i-1]*pw2%mod;
    ans=(ans+1LL*phi[i]*f[i-1]%mod)%mod;
  }
  std::cout<<ans<<std::endl;

  return 0;
}
```
