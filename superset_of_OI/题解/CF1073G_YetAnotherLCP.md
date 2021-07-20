#CF1073G Yet Another LCP Problem

## statement

[link: codeforces](https://codeforces.com/contest/1073/problem/G)

给定一个字符串$S$,并$n=|S|$,用$S[l,r]\ (1\leq l\leq r\leq n)$表示一个子串.  
多次给定$[n]=\{1,2,3\ldots n\}$的两个子集$A_k,B_k$,求解$\sum_{i\in A_k}\sum_{j\in B_k}\mathrm{LCP}(S[i,n],S[j,n])$.  
其中$\sum |A_k|,\sum |B_k|=O(|S|)$.

## solution

首先反转$S$(后缀变前缀,最长公共前缀LCP 变为 最长公共后缀LCS),建立SAM,在parent树上面操作.  

对于$S$的两个子串$T_1,T_2$(不妨$|T_1|\leq |T_2|$),设$q_1=tr(q_s,T_1),q_2=tr(q_s,T_2)$.  
- 如果$T_1$不是$T_2$的后缀,那么$LCS(T_1,T_2)=\mathrm{len}(\mathrm{LCA}(q_1,q_2))$. 
- 如果$T_1$是$T_2$的后缀,那么最长公共后缀就是$|T_1|$. 即使如此,最长公共后缀仍然是属于$\mathrm{LCA}(q_1,q_2)=q_1$的一个串.


这个题目还比较好处理,因为这里要取$LCS$的串,都是$S$的前缀.  

对于一个前缀$S[1:i]$和对应的状态$q_i=tr(q_s,S[1:i])$,我们有$\mathrm{len}(q_i)=i$ (首先$i\in \mathrm{right}(q_i)$,有$\mathrm{len}(q_i)\leq i$,而我们有有一个恰好长度为$i$的子串即$S[1,i]$是落在$q_i$的,所以有$\mathrm{len}(q_i)=i$)  
这样,对于$q_1=tr(q_s,S[1:i]),q_2=tr(q_s,S[1:j])$,如果出现上文中提到的$\mathrm{LCA}(q_1,q_2)=q_1$的情况,应该有$\mathrm{LCS}(S[1:i],S[1:j])=S[1:i]$,它的长度正好是$\mathrm{len}(\mathrm{LCA}(q_1,q_2))=\mathrm{len}(\mathrm{LCA}(q_1,q_2))$.  

于是,我们不需要分开处理是否有后缀关系的两种情况.  
找到前缀对应的状态,求LCA,给出LCA状态的len即可.


### part1

考虑单次查询的做法.  

首先在parent树上面分别标记$A,B$中元素对应串所属的状态.
```python
for i in A:
  qi = SAM.trans(SAM.root,S[1:i])
  qi.tagA += 1
for i in B:
  qi = SAM.trans(SAM.root,S[1:i])
  qi.tagB += 1
```

	
枚举parent树上的状态$k$ 考虑所有满足$k=\mathrm{LCA}(tr(q_s,S[1:a_i]),tr(q_s,S[1:b_j]))$的pair $(a_i,b_j)$的数量.  
这是个太经典的问题...随便搞就行了.
- $k$的两个子不同节点$u,v$所在的子树中, 分别取出一个有$A$标记的串$x$和一个有$B$标记的串$y$,贡献$1$.  
  在parent树上面dfs,求出`ca[x],cb[x]`表示`x`子树内有$A$标记和有$B$标记的串的数量,就很好求出.
- 落在$k$上的$A$串,落在子树中的$B$串. 或者反之.


```python
ans = 0

def dfs(u) -> Tuple[int,int]:
  ca, cb = u.tagA, u.tagB
  for i in u.son:
    a0,b0 = dfs(v,u)
    ans += u.len * (ca*b0 + cb*a0)
    ca,cb = ca+a0, cb+b0
  return (ca,cb)
```

### part2

加上虚树,就AC啦.

- [OI-wiki 虚树](https://oi-wiki.org/graph/virtual-tree/)
- 这个技术的英文叫什么,从什么地方来,目前不清楚.  
  大概来源于`compress trie`(关键点是单词节点,只要保留单词节点,和单词两两间LCA,就能正常使用这个trie不丢失任何信息),被推广到其他仅与树上关键点及其LCA有关的问题.


