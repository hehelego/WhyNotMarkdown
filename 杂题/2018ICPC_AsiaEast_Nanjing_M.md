# 2018 ACM ICPC Asia East Nanjing Regional Contest, problem M

## statement

M: Mediocre String Problem  
[link:cf-gym](https://codeforces.com/gym/101981)

给定两个串$S,T$在$S$中选取一个子串$A$,选取一个$T$的前缀$B$.  
求满足以下约束的选取方案计数(不要求串本质不同).  

- $|A| > |B|$
- $A\,+\!+\,B$ is a palindrome.



## solution

### insight

考虑一个可行解的样子.  
选一个$T$的前缀$B$,将它反转得到$B^R$,与$A$进行匹配,在每个匹配位置,向后走取出一段回文.

```plaintext
S     |<----|abcba|
T |---->|
```

我们枚举那个匹配位置为$i$,  
- $i$左侧选一个点$j$使得$(S[j,i])^R$是$T$的前缀.
- 右侧选一个以$S[i+1]$开始的回文子串.  

这两部分是独立的,分别求出可行方案,乘起来.将乘积贡献求和即为答案.  

### part1

> 反转$S$之后,就是$S$的每个后缀与$T$求$LCP$  
> 任意数据结构SAM,ST,SA都可以.  
> 
> 这个其实就是 `扩展kmp`或者`z-algorithm` 要做的事情...可以直接写.


这个东西是具有一定单调性的,如果$(S[j,i])^R$是$T$的前缀,那么$(S[j+1,i])^R$一定也是$T$的前缀.  
我们可以二分LCP,使用`hash`进行判断.  


### part2

对于$i$,求出以$S[i]$开头的回文串数量,考虑向右走到$j$,如果以$j$为中心的回文串的最大回文半径$r_j$不小于$i-j+1$. 那么将$i$关于$j$对称,可取出一个$S[i]$开头的回文串.

枚举回文中心,考虑最大回文半径.  

- length of the palindrome is a odd number $S[i-r+1,i]=S[i,i+r-1]$,这种情况以$[i-r+1,i]$中任意位置开头都可以取出一个回文串.
- length of the palindrome is a even number $S[i-r+1,i]=S[i+1,i+r]$,这种情况以$[i-r+1,i]$中任意位置开头都可以取出一个回文串.  

我们只需要枚举回文中心,考虑最大可行奇数/偶数长度,给一个区间`+1`.  


## code

```cpp
#include <bits/stdc++.h>
const int N=1000000+10;
using Int = unsigned long long int;


int qpow(int a,int b,int mod){
	if(a==0) return b==0;
	int r=1; while(b){
		if(b&1) r=1LL*r*a%mod;
		a=a*a%mod; b>>=1;
	}
	return r;
}
int sub(int a,int b,int mod){
	int c=(a-b);
	return c<0?c+mod:c;
}

//#define DoubleHash
#define OverflowHash

#ifdef DoubleHash
const int mod0=998244353;
const int mod1=int(1e9)+7;
const int base=97;
const int MOD[]={mod0,mod1};
int pw[2][N];
#endif
#ifdef OverflowHash
const Int base=137;
Int pw[N];
#endif


struct String{
#ifdef DoubleHash
	int n; char S[N];
	int h[2][N],rh[2][N];

	void init(int rev){
		scanf("%s",S+1); n=strlen(S+1);
		if(rev) std::reverse(S+1,S+n+1);

		for(int k=0;k<2;k++){
			int mod=MOD[k];
			for(int i=1;i<=n;i++) h[k][i]=(h[k][i-1]*base+(S[i]-'a'+1))%mod;
			for(int i=n;i>=0;i--) rh[k][i]=(rh[k][i+1]*base+(S[i]-'a'+1))%mod;
		}
	}
	int hash(int rev,int l,int r,int k){
		int mod=MOD[k];
		if(rev) return sub(rh[k][l],rh[k][r+1]*pw[k][r+1-l]%mod,mod);
		return sub(h[k][r],h[k][l-1]*pw[k][r-l+1]%mod,mod);

	}
	std::pair<int,int> hash(int rev,int l,int r){
		return std::make_pair(hash(rev,l,r,0),hash(rev,l,r,1));
	}
#endif
#ifdef OverflowHash
	int n; char S[N];
	Int h[N],rh[N];

	void init(int rev){
		scanf("%s",S+1); n=strlen(S+1);
		if(rev) std::reverse(S+1,S+n+1);

		for(int k=0;k<2;k++){
			for(int i=1;i<=n;i++) h[i]=h[i-1]*base+(S[i]-'a'+1);
			for(int i=n;i>=0;i--) rh[i]=rh[i+1]*base+(S[i]-'a'+1);
		}
	}
	int hash(int rev,int l,int r){
		if(rev) return rh[l]-rh[r+1]*pw[r+1-l];
		return h[r]-h[l-1]*pw[r-l+1];
	}
#endif
}S,T;

int lcp[N],cnt[N];
void add(int l,int r,int n){
	if(l>r) return ;

	cnt[l]++; if(r<n)cnt[r+1]--;
}
void palindrome(){
	int n=S.n;
	for(int i=1;i<=n;i++){
		int l=1,r=std::min(i,n-i+1),ans=1;
		while(l<=r){ int mid=(l+r)>>1;
			if(S.hash(0,i-mid+1,i)==S.hash(1,i,i+mid-1)){
				ans=mid; l=mid+1;
			}else r=mid-1;
		}
		add(i,i+ans-1,n);
	}
	for(int i=1;i<n;i++){
		int l=1,r=std::min(i,n-i),ans=0;
		while(l<=r){ int mid=(l+r)>>1;
			if(S.hash(0,i-mid+1,i)==S.hash(1,i+1,i+mid)){
				ans=mid; l=mid+1;
			}else r=mid-1;
		}
		add(i+1,i+ans,n);
	}
	for(int i=1;i<=n;i++) cnt[i]=cnt[i-1]+cnt[i];
}
void LCP(){
	for(int i=1;i<=S.n;i++){
		int l=1,r=std::min(T.n,S.n-i+1),ans=0;
		while(l<=r){ int mid=(l+r)>>1;
			if(S.hash(0,i,i+mid-1)==T.hash(0,1,mid)){
				ans=mid; l=mid+1;
			}else r=mid-1;
		}
		lcp[i]=ans;
	}
}


int main(){
#ifdef DoubleHash
	for(int k=0;k<2;k++){
		int mod=MOD[k]; pw[k][0]=1;
		for(int i=1;i<N;i++) pw[k][i]=pw[k][i-1]*base%mod;
	}
#endif
#ifdef OverflowHash
	for(int k=0;k<2;k++){
	 	pw[0]=1;
		for(int i=1;i<N;i++) pw[i]=pw[i-1]*base;
	}
#endif

	S.init(1); T.init(0);

	palindrome(); LCP();
	Int ans=0;
	for(int i=2;i<=S.n;i++){
		ans=ans+1ULL*cnt[i-1]*lcp[i];
	}
	std::cout<<ans<<std::endl;
	return 0;
}
```

