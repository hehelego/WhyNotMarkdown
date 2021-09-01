# geekpie 2021 recruit

~~陈年老社员来做招新题了~~  
**note** (评测机性能相当于公元2021年的main stream desktop PC)  

## 去年(2020年)的题目

原题是 `SCOI2018 D2T1 Pipi酱的日常`, 题意如下.

> 给出一个整数序列$(a_1,a_2\ldots a_n)$,一个整数$k$,支持以下操作.  
>
> - $\text{update}(p,v)$ 单点更新操作 $a_p\leftarrow v$
> - $\text{query}(l,r,v)$ 查询操作,计算  $\displaystyle \max_{l\leqslant i\leqslant r-k+1} \left\{ \sum_{i=0}^{k-1} \left\vert a_i+v \right\vert \right\}$
>
> 其中$1\leq k\leq 4, n\leq 10^5$,询问次数$m$和序列长度$n$同阶.

绝对值相关的最优化问题有个经典套路,用max替换abs,具体而言,是利用以下性质

- $\mathrm{abs}(x)=\max(x,-x)$ 以及反向的 $\max(a,b)=\frac{a+b}{2}+\mathrm{abs}(\frac{a-b}{2})$
- $\max_i a_i+\max_j b_j=\max_{i,j} (a_i+b_j)$

我们以$k=3$为例,令$x=a_i,y=a_{i+1},z=a_{i+2}$有

$$
\begin{aligned}
&\mathrm{abs}(x+v)+ \mathrm{abs}(y+v)+ \mathrm{abs}(z+v)\\
=& \max(x+v,-x-v)+ \max(y+v,-y-v)+ \max(z+v,-z-v)\\
=& \max
  \begin{Bmatrix}
    x+y+z&+3v\\
    x+y-z&+v\\
    x-y+z&+v\\
    x-y-z&-v\\
    -x+y+z&+v\\
    -x+y-z&-v\\
    -x-y+z&-v\\
    -x-y-z&-3v\\
  \end{Bmatrix}
\end{aligned}
$$

这里max还要继续拆,前面的一部分仅与序列元素相关,后面的一部分和查询参数相关.  

我们在每个位置$i$维护一个长度为$2^k$的数组,表示给$a_i,a_{i+1}\ldots a_{i+k-1}$带上正或负贡献的所有可能性下所有元素的和.  
用线段树来做RMQ, 每次询问取出$[l,r-k+1]$的每种加符号可能性下的最大值, 如果这种可能下下有$i$个$+$(有$k-i$个$-$)则$v$前的系数为$i-(k-i)=2i-k$.

更近一步,我们发现只用算$2^{k-1}$种可能性,另外的$2^{k-1}$种可能性,分别是前面的某种可能性的相反数.  
再优化一步,我们计算最终答案时,只关系加了多少个正号(或者加了多少个负号),可以做出 **leafy** ranger-tree, 在叶子节点计算$2^{k-1}$种可能性, 而在非叶子处合并为$k-1$种可能性(所有$0$个正号的组合,所有$1$个正号的组合...所有$k-1$个正号的组合)的最大值.

这样,单点更新的复杂度为 $O(2^{k-1}+k\log n)$,而查询的复杂度为$O(k\log n)$.

## A题

> 01背包问题中, 有$n$个物品.  
> $(v_i,w_i)$描述一个价格$w_i$,价值$v_i$的物品.  
>
> 进行$q$次查询, 每次给定$l_i,r_i,m_i$, 表示考虑编号在$[l_i,r_i]$中的物品, 购买价格不超过$m_i$的删品, 最大化价值. 输出这个价值,以及能够达到这个价值的购买方案(一个方案即为$[l_i,r_i]$内的商品的子集)
>
> 数据范围 $1\leq n\leq 2\times 10^4,\ 1\leq q\leq 10^5,\ 1\leq m_i\leq 500$  
> 时间限制 2s, 空间限制 512MiB

先考虑朴素做法, 对于每次查询,
我们设$f(i,j)$表示考虑了前$i$个物品,目前选择了共计价格为$j$的物品子集,最大化的价值和,
以及$g(i,j)$表示考虑了前$i$个物品,目前选择了共计价格为$j$的物品,使得价值总和为$f(i,j)$的物品子集计数.
有转移

$$
\begin{aligned}
&f(i,j-w_i)+v_i\quad \mathrm{compare}\quad f(i-1,j)\\
&\begin{cases}
f(i,j)\leftarrow f(i-1,j)         & g(i,j)\leftarrow g(i-1,j)              & (<)\\
f(i,j)\leftarrow f(i-1,j)         & g(i,j)\leftarrow g(i-1,j)+g(i-1,j-w_i) & (=)\\
f(i,j)\leftarrow f(i-1,j-w_i)+v_i & g(i,j)\leftarrow g(i-1,j-w_i)          & (>)\\
\end{cases}
\end{aligned}
$$

使用背包问题DP中常见的空间优化技巧, 可以把$i$对应的状态维度压缩掉.  
最后遍历一下$f(-,j),g(-,j)$其中$0\leq j\leq m$即可算出答案.  
这样暴力做复杂度是$O(nmq)$的.

### 线段树"快速"合并

区间查询最常见的技巧就是利用"结合律",使用"线段树"等数据结构快速批量合并.  
假设我们对于物品$[l,p],[p,r]$分别算出了$f,g$,我们可以在$O(m^2)$内合并出物品$[l,r]$的$f,g$具体而言

$$
\begin{aligned}
f(j) &= \max_{0\leq k\leq j} \{ f_L(k)+f_R(j-k) \}\\
g(j) &= \sum_{
  \begin{array}{c}
  0\leq k\leq j\\
  [f_L(k)+f_R(j-k)=f(j)]
  \end{array}
} g_L(k)g_R(j-k)
\end{aligned}
$$

这样可以得到复杂度为$O((q+n)m^2\log n)$的做法(空间是$O(n m)$的).

### (对查询)分块

另一个序列问题的常见处理, 就是分块了  

1. 每$B$个物品分一块, 总共$\lfloor \frac{n}{B} \rfloor$块, 物品$i$位于块$\lfloor i/B \rfloor$
2. 对于所有询问$Q(l_i,r_i,m_i)$, 我们按照$l_i$所在的块分类, 每一类内部按照$r_i$升序排列. (即按照$(\lfloor l_i / B \rfloor,r_i)$排序)
3. 按照$k=1,2,3\ldots \lfloor n/B\rfloor$的顺序, 处理查询左端点$l_i$落在$[(k-1)B+1,\min(kB,n)]$的询问
4. 对于$[kB+1,r_i]$计算$f,g$. 复制$f,g$,加入$[l_i,kB]$中的物品. 这样就计算了$[l_i,r_i]$对应的$f,g$, 回答询问.

对于某个$k$  

1. 其对应的块之中的询问, $r_i$是升序排列的,所以这里只有插入没有撤销或者删除.  
  于是扩展$[kB+1,r_i]$的总计的操作数量是$m(n-kB)$
2. 复制的复杂度为$O(m)$
3. 暴力加入左边的$[l_i,kB]$最多是加入$B$个物品,对于每个询问而言开销是$O(Bm)$

于是总体的复杂度为

$$
O(mqB+\sum_{i=1}^{\lfloor n/B\rfloor}m(n-iB))
=O\left(m\left(
qB+\frac{n^2}{B}
\right)\right)
$$

可以用均值不等式来最小化它.
这里$n,q$同阶,就取$B=\sqrt n$,得到$O(mq\sqrt n+mn\sqrt n)$

> 这个技巧被称为 "不删除/带撤销 莫队".  
> 这种对询问分块的操作称为莫队算法.  
> 而撤销操作会发生在step4. 有些数据结构无法高效复制,无法高效删除,但能快速依次撤销更改操作,返回之前的状态. 使用这样的数据结构就会搞出"带撤销莫队".
>
> 空间允许的情况下, 我们可以把这个做法扩展,使得它支持在线查询.

## 正经做法

分治  
`solve(l,r,{q})` 表示处理物品$[l,r]$,询问集合为$\{q\}$.  
区间中点为$p=\frac{l+r}{2}$, 将询问分为三类.

- 询问区间完全落在左侧,即$[l,p]$中的,为`{qL}`, 递归调用`solve(l,p,{qL})`
- 询问区间完全落在右侧,即$[p+1,r]$中的,为`{qR}`, 递归调用`solve(p+1,r,{qR})`
- 询问区间跨过中点$p$的,为`{q0}`

我们计算出$f_L(i,j),g_L(i,j)$表示从中点向左考虑$i$个物品,总价格为$j$时最大价值和,取道最大值的方案计数,
类似地,对于右侧的物品,计算$f_R(i,j),g_R(i,j)$. 这部分的时间复杂度为 $O((r-l)m)$  
对于询问`Query{l,r,m}`我们假设在左侧选择了价格恰好为`i`的物品,那么在右侧可以选择价格不超过`m-i`的物品,对右侧的$f_R,g_R$做一个前缀最大值/前缀中最大值计数,即可$O(m)$复杂度完成单次查询.  

复杂度分析比较简单,总计$O(mq+mn\log n)$:  
计算询问答案部分的是$O(mq)$  
递归计算$f,g$的复杂度是,有递归式 $T(n)=2T(n/2)+mn$ (设$a_k=T(2^k)$构造一阶常系数线性递推,之后可以使用微分方程或者生成函数求解) 是$O(mn\log n)$的.

## B题

> A,B 两人进行扔骰子比大小游戏.  
> 两个人都有$n$个$k$面骰子, 每个骰子可以独立地均匀地给出$1,2,3\ldots k$中的一个数.  
>
> 在比赛中,  
>
> 1. 双方分别掷出骰子, 比较两边的点数之和
> 2. 若不相等,较大的一方获胜.
> 3. 相等, 回到 step 1 重新进行, 最多进行 $r$ 次投掷操作.
>
> 求A的胜利概率
> 数据范围$1\leq n\leq 10^7,\ 1\leq k\leq 5\times 10^7,\ 1\leq n\times k\leq 5\times 10^7,\ 1\leq r\leq 10^7$  
> 时间限制 2s, 空间限制 428MiB

两边对等, 算出单次操作平局概率为 $p$ , 则胜利/失败概率均为 $q=\frac{1-p}{2}$  
于是答案为 $\sum_{i=1}^r p^{i-1} q=q\frac{p^r-1}{p-1}$  
所以, 只要快速求出 $p$ 即可.

设 $P(i,j)$ 表示扔了 $i$ 个骰子, 目前的和是 $j$ 的概率, 那么有 $p=\sum_{i} {P^2(n,i)}$  
这里 $P(n,i)$ 对应的生成函数为.

$$
\begin{aligned}
{\left(
\frac{1}{k}\sum_{i=1}^k x^i
\right)}^n
=\frac{x^n}{k^n}
{\left(
\frac{x^k-1}{x-1}
\right)}^n
\end{aligned}
$$

我们实际上就是要求它的各项系数平方和,
前面的 $x^n$ 是无用的,
$\frac{1}{k^n}$ 可以题取出来, 最后乘上去
于是转为求这个多项式的展开式.

$$
\begin{aligned}
{\left(
\frac{x^k-1}{x-1}
\right)}^n
&=
  {\left(
  \frac{1-x^k}{1-x}
  \right)}^n\\
&=
  \sum_{i=0}^n\binom{n}{i}{(-1)}^i x^{ki}
  \sum_{j=0}^\infty\binom{-n}{j}{(-1)}^j x^j\\
&=
  \sum_{i=0}^n\binom{n}{i}{(-1)}^i x^{ki}
  \sum_{j=0}^\infty\binom{n+j-1}{j} x^j\\
&=
  \sum_{r=0}^{n(k-1)} x^r
  \sum_{i=0}^{\lfloor\frac{r}{k}\rfloor}\binom{n}{i}{(-1)}^i\binom{n+(r-ik)-1}{r-ik}
\end{aligned}
$$

### 找规律

我们固定 $k$ 打表看看情况, 然后丢进OEIS.

```python
x = var('x')

k=2
for n in range(15):
  F = sum(x^i for i in range(k))
  F = F.expand()^n
  ret = sum(a^2 for (a,b) in F.coefficients())
  show(ret)
```

```plaintext
# k=1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
```

```plaintext
# k=2
1
2
6
20
70
252
924
3432
12870
48620
184756
705432
2704156
10400600
40116600

Central binomial coefficients: binomial(2*n,n) = (2*n)!/(n!)^2.
[x^n] (1+x)^{2n}
```

```plaintext
# k=3
1
3
19
141
1107
8953
73789
616227
5196627
44152809
377379369
3241135527
27948336381
241813226151
2098240353907

a(n) = T(2*n, 2*n)
where T is the trinomial triangle A027907;
the coefficient of x^(2*n) in (1+x+x^2)^(2*n)

[x^{2n}] (1+x+x^2)^{2n}
```

```plaintext
# k=4
1
4
44
580
8092
116304
1703636
25288120
379061020
5724954544
86981744944
1327977811076
20356299454276
313095240079600
4829571309488760

Central coefficients in triangle A008287 ((1 + x + x^2 + x^3)^n), see link. - Zagros Lalo, Sep 25 2018
[x^3n] (1+x+x^2+x^3)^(2n)
```

### 快速计算答案

我们发现, 这个系数平方和是以下东西

$$
\left[x^{(k-1)n}\right] {\left(\sum_{i=0}^{k-1} x^i\right)}^{2n}
=\left[x^{(k-1)n}\right] {\left(\frac{1-x^k}{1-x}\right)}^{2n}
$$

这个生成函数可以这样计算

$$
\begin{aligned}
&\left( \sum_{i=0}^{2n} \binom{2n}{i}{(-1)}^i x^{ik} \right)
\left( \sum_{j=0}^{\infty} \binom{-2n}{j}{(-1)}^j x^j \right)\\
=&\left( \sum_{i=0}^{2n} \binom{2n}{i}{(-1)}^i x^{ik} \right)
\left( \sum_{j=0}^{\infty} \binom{2n+j-1}{j} x^j \right)\\
\end{aligned}
$$

对于分母, 我们用一个常见技巧来找递推式, 以便做到线性.

$$
\begin{aligned}
a(x)&={(1-x)}^{-2n}=\sum_{i=0}^\infty a_i x^i\\
\frac{\mathrm{d} a(x)}{\mathrm{d} x}&={(1-x)}^{-2n-1}(-2n)(-1)=2n\frac{a(x)}{1-x}\\
(1-x)a'(x)&=2n a(x)\\
[x^k] (1-x)a'(x)&=[x^k] 2n a(x)\\
(k+1)a_{k+1} - k a_k &= 2n a_k\\
a_{k+1}&=\frac{2n+k}{k+1} a_k\quad a_0=1
\end{aligned}
$$

预处理出阶乘,逆元,阶乘的逆元,以便快速求出二项式系数.  
枚举分母中的项 $\binom{2n+j-1}{j}x^j$, 找 $n(k-1)=ik+j$ 的$i$乘上对应的分子中的项 $\binom{2n}{i}{(-1)}^{i} x^{ik}$.
求和, 最后乘上$k^{-2n}$即可得到$p$  
最后,按照之前的公式 $q\frac{p^k-1}{p-1}$ 计算答案即可.

这样的做法复杂度是 $o(nk)$ 的, 可以拿到 `100/100` 的分数.

### 另一个推导

注意到这里 $k^n P(n,m)$ 实际上是 (其中$[k]=\{1,2,3\ldots k\}$)

$$
\left\vert
\left\{
(x_1,x_2\ldots x_n)\in {[k]}^n
\mid \sum_{i=1}^n x_i = m
\right\}
\right\vert
$$

这个可以容斥计算.
对于$S\subseteq [n]$,设

$$
\begin{aligned}
R(i)&=[x_i > k]\\
f(S)&=
\left\vert
\left\{
  (x_1,x_2\ldots x_n)
  :\quad
  \left( \sum_{i=1}^n x_i = m \right )
  \land
  \left( \forall i \left(i\!\in\! S\leftrightarrow R(i)\right)\right)
\right\}
\right\vert\\
g(S)&=
\left\vert
\left\{
  (x_1,x_2\ldots x_n)
  :\quad
  \left( \sum_{i=1}^n x_i = m \right )
  \land
  \left( \forall i \left(i\!\in\! S\rightarrow R(i)\right)\right)
\right\}
\right\vert\\
\end{aligned}
$$

我们有以下的子集反演,和对于$g$的快速计算方法(可以用那个隔板法的组合意义或者OGF来推导)

$$
\begin{aligned}
g(S)&=\sum_{S\subseteq T}f(T)\\
f(S)&=\sum_{S\subseteq T}{(-1)}^{|T|-|S|}g(T)\\
g(S)&=
\left\vert
\left\{
  (x_1,x_2\ldots x_n)
  :\quad
  \left( \sum_{i=1}^n x_i = m-|S|k \right )
\right\}
\right\vert
=\binom{m-|S|k-1}{n-1}\\
\end{aligned}
$$

于是可以计算出$P(n,m)$, 以及其平方和即$p$.

$$
\begin{aligned}
k^n P(n,m) = f(\varnothing)
&=\sum_{i=0}^n \binom{n}{i}{(-1)}^i \binom{m-ik-1}{n-1}\\
\end{aligned}
$$

**TODO** 推出来这个式子

## C题

> 有$n$个连续型随机变量${x_n}$, $x_i$在$[0,a_i]$的实数中等概率选取, $a_i$是一系列给定的整数. 在模$998244353$意义下,求解
> $${\left(\sum_{i=1}^n x_i\right)}^m$$
>
> 数据范围: $1\leq n,m\leq 10^5\ 0\leq a_i <998244353$  
> 时间限制 2s, 空间限制 512mib

### 一点概率论知识

> 参考资料:
>
> - pdf(probability density function) and cdf(cumulative distribution function)
> - moment generating function

- $x\leftarrow u[a,b]$ 的 mgf 是 $m_x(t)=\frac{e^{tb}-e^{ta}}{t(b-a)}$
- 独立随机变量 $x,y$ 之和 $x+y$ 的 mgf 是 $m_{x+y}(t)=m_x(t)m_y(t)$
- $\mathrm{e}(x^m)={\left.\frac{\mathrm{d}^m m_x(t)}{\mathrm{d} t^n}\right\vert}_{t=0}$

### 解答

有了前面的知识,我们知道答案是这样的

$$
\begin{aligned}
{\left.
  \frac{\mathrm{d}^m}{\mathrm{d} t^n}
  \left( \prod_{i=1}^n\frac{e^{a_i t}-1}{a_i t} \right)
\right\vert}_{t=0}
\end{aligned}
$$

对于两个函数乘积的高阶导数,我们有${(uv)}^{(n)}=\sum_{i=0}^n \binom{n}{i}u^{(i)}v^{(n-i)}$  
归纳一下, 我们对于$n$个函数乘积的$m$阶导数, 有:

$$
\begin{aligned}
f(x)&=\prod_{i=1}^n f_i(x)\\
f^{(m)}(x)&=\sum_{
\begin{array}{c}
  \sum_{i=1}^n r_i=m\\
  0\leq r_i\leq m
  \end{array}
}
\frac{m!}{\prod_{i=1}^n r_i!}
\prod_{i=1}^n f_{i}^{(r_i)}(x)\\
\end{aligned}
$$

我们关注这样一个形式

$$
\sum_{
  \begin{array}{c}
  \sum_{i=1}^n r_i=m\\
  0\leq r_i\leq m
  \end{array}
}
\prod_{i=1}^n \frac{f_{i}^{(r_i)}(x)}{r_i!}
$$

可以用一系列多项式乘积,取$x^m$前系数得到. 其中,

$$
{\left.
  \frac{\mathrm{d}^k }{\mathrm{d} t^k}
  \left( \frac{e^{a t}-1}{a t} \right)
\right\vert}_{t=0}
$$

利用在$t=0$处的taylor series求解, 即maclaurin series.

$$
\begin{aligned}
e^{a t}&=\sum_{i=0}^\infty \frac{{(at)}^i}{i!}\\
f(t)&=\frac{e^{a t}-1}{at}=\sum_{i=0}^\infty \frac{{(at)^i}}{(i+1)!}\\
&=\sum_{i=0}^\infty \frac{f^{(i)}(0)}{i!} t^i\\
f^{(k)}(0)&=\frac{a^k}{k+1}
\end{aligned}
$$

带入,得到

$$
\begin{aligned}
&\sum_{
  \begin{array}{c}
  \sum_{i=1}^n r_i=m\\
  0\leq r_i\leq m
  \end{array}
}
\prod_{i=1}^n \frac{{(a_i)}^{r_i}}{(r_i+1)!}\\
=&[x^m]\prod_{i=1}^n \left(
\sum_{j=0}^m \frac{a_i^j}{(j+1)!} x^j
\right)\\
=&[x^m]\prod_{i=1}^n \left(
\sum_{j=0}^\infty \frac{a_i^j}{(j+1)!} x^j
\right)\\
\end{aligned}
$$

分治,用fft做多项式乘法来合并, 复杂度为 $o(nm\log n)$ 可以拿到 `60/100` 的分数.

其中

$$
\begin{aligned}
g_k(x)&=\sum_{i=0}^\infty \frac{k^i}{(i+1)!} x^i\\
kx\, g_k(x)&=\sum_{i=1}^\infty \frac{{(kx)}^i}{i!}=e^{kx}-1
\end{aligned}
$$

**todo** 加入C题的满分做法 (我暂时不会,等官方题解了)
