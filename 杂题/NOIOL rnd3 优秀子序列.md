# NOIOL rnd3:优秀子序列

## statement

目前似乎只在luogu有[link](https://www.luogu.com.cn/problem/P6570),官方数据没有公布,测试数据是网友造的.



给一个非负整数序列$(a_1,a_2,a_3\dots a_n)$求
$$
\sum_{k=0}^{n}\sum_{1\leq b_1\lt b_2\lt b_3\dots b_k\leq n}[\forall (i,j),(i\neq j)\implies a_{b_i}\and a_{b_j}=0]\varphi(1+\sum a_{b_i})
$$
其中$a_i\and a_j$是二进制下的按位与操作,$\varphi(n)=\sum_{i=1}^n[\gcd(i,n)=1]$即欧拉函数.
即对于所有满足任意两个元素按位与结果为0的子序列,1加上元素和的欧拉函数值求和.

$n\leq 10^6,0\leq a_i\leq 2\times 10^5$.

## solution

**下文中,对于这些对象不做区分:一个元素本身,一个元素的二进制表示,一个大小不超过ceil(log max a)的集合**

首先这个$\varphi(1+\sum a_{b_i})$中的$\sum a_i$如果是自由的,那么我们可能要求出$\varphi(i)\ (0\lt i\leq n\max  a_i)$在这个数据范围上目前(这个题是2020年的OI题目,大概是CPU 2.5GHz,2s时间,256MB存储,不允许并行)是不可做的.于是我们非常自然的猜想满足$[\forall (i,j),(i\neq j)\implies a_{b_i}\and a_{b_j}=0]$时$\sum a_{b_i}$是$O(\max a_i)$,而不是$O(\sum a_i)$的.
这个猜想是正确的,考虑$a_i\and a_j=0$的意义,即二进制表示下$a_i,a_j$的,不存在某一位都是$1$,于是它们相加的时候不会出现进位,有$0,0\to 0;0,1\to 1$这正好符合异或的规则,不同的位是独立的,所以$(a_i\and a_j=0)\implies (a_i+a_j=a_i\oplus a_j)$其中$\oplus$是二进制下按位异或操作.而这可以从2个元素的子序列推广到任意多个元素的子序列上面,$(\forall (i,j)\ (i\neq j)\implies a_{b_i}\and a_{b_j}=0)\implies \sum a_{b_i}=\oplus a_{b_i}$所以$\sum a_{b_i}$最大就是$\lceil \log_2\max a_i\rceil$位全是$1$,它不超过$2\max a_i$.

这下我们放心了,只需要求$[0..2\max a_i]$的$\varphi$,这个时间是可以接受的.
另一方面,由于$\sum a_{b_i}$是$O(\max a_i)$的,我们找不出什么$\varphi$的特殊性质帮助我们计算,不妨尝试对$1,2\dots 2\max a_i$分别求$f(d)$表示满足任意两元素and为0,且$\sum a_{b_i}=\oplus a_{b_i}=d$的子序列计数.
$$
f(d)=\sum_{k=0}^{n}\sum_{1\leq b_1\lt b_2\dots b_k\leq n}[\forall (i,j),(i\neq j)\implies a_{b_i}\and a_{b_j}=0][\sum a_{b_i}=d]\\
=\sum_{k=0}^{n}\sum_{1\leq b_1\lt b_2\dots b_k\leq n}[\forall (i,j),(i\neq j)\implies a_{b_i}\and a_{b_j}=0][\oplus a_{b_i}=d]\\
$$
这个还是非常套路,非常可做的,我们定义$g(i,S)$表示选$(a_1,a_2\dots a_i)$的子序列,满足任意两元素and为0,且和/异或和为$S$的方案计数.可以有$g(i+1,S)=g(i,S)+g(i,S\setminus a_{i+1})$和初始条件$g(0,\phi)=1$以及终止条件$f(d)=g(n,\text{binary}(d))$
还是不太够,考虑目前选了一个异或和为$T$的子序列,保证满足约束的情况下加入一个新的元素,异或和一定是单调不减的,这告诉我们可以对于$d$从小到大,依次求出$f(d)$.
这里我们令$c_k=\sum [a_i=k]$初始的$f(0)=c_0$,递推式$(S\gt 0)\implies f(S)=\sum_{T\subseteq S}f(S\setminus T)c_{T}$

到这里已经是可做的了,需要一些实现上的技巧,可以做到$O(\max a_i+3^m)$其中$m=\lceil\log_2\max a_i\rceil$.还可以用FWT处理转移(是个子集卷积,大概找找集合幂级数 沃尔什变换 子集卷积等关键词就会有,我不清楚它的英文叫什么)做到更好的复杂度.

## code

暂时不太会写…也不是不好写吧,大概比较懒.