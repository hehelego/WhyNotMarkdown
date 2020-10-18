# SAM经典应用:多串LCS

## statement

[LOJ171](https://loj.ac/problem/171) [SPOJ 1812](https://www.spoj.com/problems/LCS2/en/)  

给出$n$个字符串$S_i$,求一个串$T$使得$T$是$S_1,S_2\dots S_n$的公共子串,最大化$T$的长度.



## solution

构造$SAM(S_1)$,枚举其前缀$T_i=S_1[1:i]$,考虑取$T_i$的一个尽量长的后缀,使得它是$S_2,S_3\dots S_n$的子串.  
对于串$S_k$,可以二分出一个最大长度$L(i,k)$.我们取$\min_{k}\ L(k,i)$即可,记它为$L_i$.  
那么答案就是$\max_{i}\ L_i$.  

考虑如何实现它,我们其实是在做$S_1,S_k$的匹配,把$S_k$放到$SAM(S_1)$上面. 走trans转移边进行匹配,失配时跳到parent(舍弃匹配部分的部分前缀,保留一个尽量大的匹配部分的后缀,继续匹配).  
这样就求出$S_k$的每个前缀的最长后缀,使得它在$S_1$中出现过.假设$S_k[1:i]$的后缀中$S_k[j:i]$是最长的出现在$S_1$中的那个,且$q=tr(q_s,S_k[j:i])$,那么我们有$\forall r\in R_q\ L(k,r)\geq (i-j+1)$.  
在$q$处做一个$(k,i-j+1)$的标记,匹配过程结束后dfs,取子树标记最大值即可,注意还要和$len(q)$取较小值.  
最后在每个状态$q$上,求它表示的串与$S_2,S_3\dots S_n$的最长匹配长度的最小值.这就是所有满足$tr(q_s,T)=q$且$T$是公共子串的最大长度.

## code

```cpp
#include <bits/stdc++.h>
const int N=100000+10;
struct T{
	int len,par,tr[26];
	T(int l=0){len=l;par=0; memset(tr,0,sizeof(tr));}
}t[N];int cnt,root,last;
inline int newnode(int ln){
	t[++cnt]=T(ln);
	return cnt;
}
inline int clone(int old,int ln){
	t[++cnt]=t[old]; t[cnt].len=ln;
	return cnt;
}
void init(){ root=last=++cnt; }
int& len(int q){ return t[q].len; }
int& par(int q){ return t[q].par; }
int& tr(int q,int c){ return t[q].tr[c]; }
void append(int c){
	int np=newnode(len(last)+1),p=last; last=np;
	while(p&&tr(p,c)==0){ tr(p,c)=np; p=par(p); }
	if(p==0){ par(np)=root; return; }
	int q=tr(p,c);
	if(len(q)==len(p)+1) par(np)=q;
	else{
		int nq=clone(q,len(p)+1);
		par(q)=par(np)=nq;
		while(p&&tr(p,c)==q){ tr(p,c)=nq; p=par(p); }
	}
}

int n,lim[N][11]; std::string S;
std::vector<int> son[N];
void dfs(int q){
	for(int v:son[q]){
		dfs(v);
		for(int i=1;i<n;i++) lim[q][i]=std::max(lim[q][i],lim[v][i]);
	}
	int tmp=lim[q][1];
	for(int i=1;i<n;i++) tmp=std::min(tmp,lim[q][i]);
	lim[q][0]=tmp;
}
void solve(){
	for(int i=1;i<=cnt;i++) son[par(i)].push_back(i);
	dfs(root);
}
int main(){
	std::ios::sync_with_stdio(0);

	std::cin>>n; std::cin>>S;
	init(); for(char c:S) append(c-'a');
	for(int i=1;i<n;i++){
		std::cin>>S; int q=root,ln=0;
		for(char x:S){ int c=x-'a';
			while(q&&tr(q,c)==0){ q=par(q); ln=len(q); }
			if(q==0){ q=root; ln=0; }
			else{ q=tr(q,c); ln++; }
			lim[q][i]=std::max(lim[q][i],ln);
		}
	}

	solve();
	int ans=0;
	for(int i=1;i<=cnt;i++)
		ans=std::max(ans,
				std::min(len(i),lim[i][0]));
	std::cout<<ans<<std::endl;
	return 0;
}
```

