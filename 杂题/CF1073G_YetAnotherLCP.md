#CF1073G Yet Another LCP Problem

## statement

[link: codeforces](https://codeforces.com/contest/1073/problem/G)

给一个字符串$S$.用$S_i$以位置$i$开始的后缀.  
多次给定集合$A_k,B_k$,求解$\sum_{i\in A_k}\sum_{j\in B_k}\mathop{LCP}(S_i,S_j)$.  
其中$\sum |A_k|=O(|S|),\sum |B_k|=O(|S|)$.

## solution

首先反转$S$,建立SAM.  
两个后缀的最长公共前缀 反转之后就是 两个前缀的最长公共后缀.  
对于$S$的两个子串$T_1,T_2$(不妨$|T_1|\leq |T_2|$),设$q_1=tr(q_s,T_1),q_2=tr(q_s,T_2)$.如果$T_1$不是$T_2$的后缀,那么$LCS(T_1,T_2)=len(LCA(q_1,q_2))$. 如果有后缀关系,那么最长公共后缀就是较短者.

这个题目还比较好处理,因为这里要取$LCS$的串,都是$S$的前缀,所以消掉了一些特殊情况($T_x\to x,T_y\to y\quad LCA(x,y)=x$,但$len(x)\not =|T_x|$的尴尬情况)  

### part1

考虑单次查询的做法,在parent树上面分别标记$A,B$中元素对应串所属的状态,即$\forall x\in A,q=tr(q_s,S[1:x])\to \text{add_tag_on }\ q$.  
	
枚举$k=LCA$,分两种情况

- $k$的两个不同子树$u,v$中分别取出一个$A$标记的点$x$,$B$标记的点$y$有$LCA(x,y)=k$,贡献$len(k)$. 记录一下子树中A,B的数量就很好统计.
- $k$上面有$A/B$的标记,考虑子树中有多少$B/A$的点,每个给出贡献$len(k)$贡献



### part2

加上虚树,就AC啦.

- [OI-wiki 虚树](https://oi-wiki.org/graph/virtual-tree/)
- 这个技术的英文叫什么,从什么地方来,目前不清楚.  
  大概来源于`compress trie`(关键点是单词节点,只要保留单词节点,和单词两两间LCA,就能正常使用这个trie不丢失任何信息),被推广到其他仅与树上关键点及其LCA有关的问题.


