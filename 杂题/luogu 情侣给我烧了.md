## luogu 情侣?给我烧了

### statement

[link](https://www.luogu.com.cn/problem/P4921)

### solution

设$F(S)$为$x\in S\iff (a_x,b_x)\in R\or (b_x,a_x)\in R$的方案$R$计数(其中$S$是$1..n$的子集).
设$G(S)$为$x\in S\implies (a_x,b_x)\in R\or (b_x,a_x)\in R$的方案$R$计数.
有$G(S)=\sum_{S\subseteq T}F(T)$反演有$F(S)=\sum_{S\subseteq T}(-1)^{|T-S|}G(T)$.

对于一个$S$设$k=|S|$有$G(S)=\binom{n}{k}k!2^k\times (2n-2k)!$有
$$
F(S)=\sum_{i=k}^n(-1)^{i-k}\binom{n-k}{i-k}\ \left(\binom{n}{i}i!2^i\times (2n-2i)!\right)\\
=n!(n-k)!\sum_{i=k}^n\frac{(-1)^{i-k}}{(i-k)!}\times \frac{2^i(2n-2i)!}{((n-i)!)^2}\\
\text{let }a_i=\frac{(-1)^i}{i!},\ b_{n-i}=2^i\frac{(2n-2i)!}{((n-i)!)^2},\ b_i=2^{n-i}\frac{(2i)!}{(i!)^2}\\
F(S)=n!(n-k)!\sum_{i=k}^na_{i-k}b_{n-i}=n!(n-k)!\sum_{i=0}^{n-k}a_{n-k-i}b_{i}
$$




最后对于$k$的答案就是$|S|=k$的$S$计算$\binom{n}{k}F(S)$.



### code

懒得写,咕咕咕.