# part1 (数学分析1)

[TOC]

## 极限

> 指导思想.  
>
> - 近似: $\lim_{n\to\infty}\frac{a_n}{b_n}=c$表明只要$n$充分大,$a_n,b_n$可以任意接近,于是可以进行各种等价替换或者放缩.
> - 控制: 级数比较判别法,夹逼定理(三明治定理)
>
> 要善于使用的工具
>
> - 定义
> - Cauchy准则判定收敛性
> - 换元(复合)
> - 海涅-博雷尔定理(离散的数列极限与连续的函数极限间的转换)
> - stolz定理和L'H法则

### 几个trick

- 单调有界+不动点

使用归纳法.  
判定收敛到哪个不动点.  
$$
\begin{aligned}
&\text{given }a_0,c\\ &a_{n+1}=\frac{1}{2}(a_n+\frac{c}{a_n})\\
&\lim_{n\to\infty} a_n
\end{aligned}
$$

- 误差法

$\lim_{n\to\infty} \sqrt[n]{n}$,当$n>1$时,有.$2^n>n>1\implies 2>\sqrt[n]{n}>1$  
设$\sqrt[n]{n}=1+a_n$其中$0<a_n<1$有.

$$
\begin{aligned}
&n=(1+a_n)^n=\sum_{i=0}^n\binom{n}{i}(a_n)^i>1+na_n+\frac{n(n-1)}{2}a_n\\
&(n+\frac{n(n-1)}{2})a_n<n-1<n\\
&(1+\frac{n-1}{2})a_n=\frac{n+1}{2}a_n<1\\
&a_n<\frac{2}{n+1}\\
\newline
&0<a_n<\frac{2}{n+1},\lim_{n\to\infty }0=\lim_{n\to\infty}\frac{2}{n+1}=0\implies \lim_{n\to\infty} a_n=0\\
&\implies \lim_{n\to\infty} \sqrt[n]{n}=\lim_{n\to\infty}(1+a_n)=1+0=1
\end{aligned}
$$

- 放缩(基于经典不等式,基于极限定义) | 夹逼

- `stolz` $\frac{0}{0},\frac{*}{\infty}$

  $\{b_n\}$严格递增到$+\infty$则$\lim_{n\to\infty}\frac{a_{n+1}-a_n}{b_{n+1}-b_n}=A\implies \lim_{n\to\infty}\frac{a_n}{b_n}=A$其中$A\in \mathbb R,+\infty ,-\infty$不可以是$\infty$.  

  $\{a_n\}\to 0,\{b_n\}\to 0$且$\{b_n\}$严格递减,则$\lim_{n\to\infty}\frac{a_{n+1}-a_n}{b_{n+1}-b_n}=A\implies \lim_{n\to\infty}\frac{a_n}{b_n}=A$其中$A\in \mathbb R,+\infty ,-\infty$

- `L'H` $\frac{0}{0},\frac{*}{\infty}$  
	$f,g$在$U_0(x_0,\delta)$可导,且在其中$g'(x)\neq 0$则.
	1. $\lim f(x)=\lim g(x)=0$,此时$\lim\frac{f'(x)}{g'(x)}=l\implies \lim\frac{f(x)}{g(x)}=l$其中$l$可以是实数或者infty.  
	2. $\lim f(x)=\lim g(x)=\infty$,此时$\lim \frac{f'(x)}{g'(x)}=l\implies \frac{f(x)}{g(x)}=l$

## 经典反例

### 001

$\{a_n\}$收敛,是否有$\lim_{n\to\infty}\frac{a_{n+1}}{a_n}=1$.  
问题出在收敛于$0$的情况,给出反例.  

$$
\begin{aligned}
&a_n=\begin{cases}
\frac{1}{n}&(2\mid n)\\
\frac{1}{n^2}&(2\not\mid n)
\end{cases}\\
&\frac{a_{n+1}}{a_n}=\begin{cases}
\frac{(\frac{1}{(n+1)^2})}{(\frac{1}{n})}&(2\mid n)\\
\newline
\frac{(\frac{1}{n+1})}{(\frac{1}{n^2})}&(2\not\mid n)
\end{cases}
\end{aligned}
$$

这里下标奇数/偶数的子列收敛性不同,于是$b_n=\frac{a_{n+1}}{a_n}$不收敛.

### 002

## 经典习题

### 001

$$
\begin{aligned}
&\lim_{x\to +\infty}\frac{\ln x}{x}=\lim_{t\to+\infty} \frac{t}{e^t}\\
&\frac{n}{e^n}<\frac{n}{2^n}=\frac{n}{\sum_{i=0}^n\binom{n}{i}}<\frac{n}{1+n+\frac{n(n-1)}{2}}=\frac{1}{\frac{1}{n}+1+\frac{(n-1)}{2}}\\
\end{aligned}
$$

右边收敛于$0$.

### 002

对于$0<k<1$,求$\lim_{n\to\infty}(n+1)^k-n^k$  
直观上,它肯定是$0$,比如看看$k=\frac12,\frac13,\frac23$.  

这里要用上幂函数单调性,可以参考$x^\alpha\ (x\geq 0)$对于$\alpha<0,\alpha>0$的图像.

$$
\begin{aligned}
&(n+1)^k> n^k\implies (n+1)^k-n^k>0\\
&(n+1)^k-n^k=n^k((1+\frac{1}{n})^k-1)<n^k(1+\frac{1}{n}-1)=n^{k-1}\\
&0<(n+1)^k-n^k<n^{k-1}
\end{aligned}
$$

其中$-1<k-1<0$于是$n^{k-1}$收敛于$0$,控制住了$(n+1)^k-n^k$.  

另一个做法,看起来更自然些(可以由$k=\frac23$推广得到).

$$
\begin{aligned}
&\text{let }r=1-k\quad (0<r<1)\\
&(n+1)^k-n^k=\frac{(n+1)}{(n+1)^r}-\frac{n}{n^r}\\
=&\frac{(n+1)n^r-n(n+1)^r}{(n(n+1))^r}<\frac{(n+1)^{1+r}-n(n+1)^r}{(n(n+1))^r}\\
=&\frac{(n+1)-n}{n^r}=\frac{1}{n^r}
\end{aligned}
$$

### 003

$$
\begin{aligned}
&\lim_{n\to\infty} \prod_{i=1}^{n} \frac{2i-1}{2i}\\[2ex]
&\forall n,\ a_n>0\\
&a_{n}=\prod_{i=1}^{n} \frac{2i-1}{2i}\\
&a_{n+1}=a_{n}\times \frac{2(n+1)-1}{2(n+1)}<a_{n}
\end{aligned}
$$

单调有界收敛准则,判定$\{a_n\}$收敛,设其极限为$a$有.  

$$
\begin{aligned}
&\lim_{n\to\infty} a_{n+1}=\lim_{n\to\infty}a_{n}\times \frac{2(n+1)-1}{2(n+1)}<a_{n}\\
&\implies a=a\lim_{n\to\infty}\frac{2n+1}{2n+2}=a\times 0=0
\end{aligned}
$$



### 004

$$
\begin{aligned}
&\lim_{x\to+\infty}(\frac{x+1}{2x-1})^x=\lim_{x\to+\infty}(\frac{1}{2})^x(2\frac{x+1}{2x-1})^x=0\lim_{x\to+\infty}(\frac{2x+2}{2x-1})^x\\
&\lim_{x\to+\infty}(1+\frac{3}{2x-1})^x\\
=&\lim_{x\to+\infty}(1+\frac{1}{\frac{2x}{3}-\frac{1}{3}})^x\\
&\text{let  }t=\frac{2x-1}{3},x=\frac{3t+1}{2}\\
=&\lim_{t\to+\infty}(1+\frac{1}{t})^\frac{3t+1}{2}\\
=&\lim_{t\to+\infty}\sqrt{((1+\frac{1}{t})^t)^3\times (1+\frac{1}{t})}\\
=&\sqrt{\lim_{t\to+\infty}e^3\times 1}=e^\frac{3}{2}
\end{aligned}
$$



### 005 数列不动点极限

$$
a>0,a_0>0\quad a_n=\frac{1}{2}(a_{n-1}+\frac{a}{a_{n-1}})
$$

这个是$a_n\to\sqrt a$

$$
a_1=1,a_{n+1}=a_n+\frac{1}{a_n}
$$

这个是严格单调发散到$+\infty$

### 006关于e的极限

取倒数,分解指数

$$
\begin{aligned}
\lim_{n\to\infty}(1-\frac{1}{n})^n
&=\lim_{n\to \infty}(\frac{n-1}{n})^n
=\frac{1}{\lim_{n\to\infty}(\frac{n}{n-1})^n}\\
&=\frac{1}{\lim_{n\to \infty}(1+\frac{1}{n-1})^{n-1}\times (1+\frac{1}{n-1})}\\
&=\frac{1}{e\times 1}=e^{-1}\\
\lim_{n\to \infty}(1-\frac{1}{2n})^{n}
&=\lim_{n\to \infty}(1-(\frac{n}{2})^{-1})^{\frac{n}{2}}\times (1-(\frac{n}{2})^{-1})^{\frac{n}{2}}\\
&=e^{-1}\times e^{-1}=e^{-2}
\end{aligned}
$$





## 函数连续性


### 反例函数.

$$
\sin(x^2)
\quad
\sin(x^{-1})
\quad
D(x)=[x\in \mathbb{Q}]
\quad
R(x)=\begin{cases}
x=\frac{p}{q}\ \text{where}\ (p,q)=1
&\to \frac{1}{q}\\
\text{otherwise}
&\to 0
\end{cases}
$$


### 连续函数的换元

对于 $f(g(x))$  
有

$$
\begin{cases}
\displaystyle \lim_{x\to x_0}g(x)=t\\
\displaystyle \lim_{y\to t}f(y)=A\\
\displaystyle \exists \delta>0\,\text{s.t.}\forall x\in U_0(x_0,\delta)\ g(x)\neq t\\
\end{cases}
\implies
\lim_{x\to x_0} f(g(x))=A
$$

这里有 _内层函数在邻域内不等于极限值_ 的约束, 因为$f(t)$与$\lim_{y\to t} f(y)$是无关的
缺少这个条件, $f(g(x))$ 在邻域内可能由于取到 $f(t)$ 而破坏极限.  
此外,若外层函数$f$是连续函数时, 我们不需要这一约束条件.

### 连续函数的海涅归结原理

类似上面极限换元规则.


## 一元函数微分学  



### 中值定理

> 从费马定理开始,证明罗尔定理.再证明其他强化版本.  
> 证明罗尔定理的时候,会有最值点落在了区间端点情况,所以最后$\xi$只能在闭区间里面取.

- 闭区间上连续
- 开区间上可导
- 在开区间上存在(至少)一点满足切线斜率等于端点斜率

#### 单调性

> 分析函数但调性时,在$[a,b]$连续,$(a,b)$可导且符号恒定即可得到$[a,b]$上的单调性,不必关心端点处的导数

#### 凸凹性 

> 凸凹性等价与三点斜率不等式.


#### 导函数介值性

> 若$\lim_{x\to r^{+}} f'(x)=l$存在,则$f'_{+}(r)=l$.  
> 使用拉格朗日中值定理,$\xi\in (x,r)$在$x\to r^{+}$时也有$\xi\to r^{+}$.即可证明.  
> 这可以推出区间$I$上可导的函数$f$的导函数$g$不能有第一类间断点.  


> Darboux's Theorem:  
> $f(x)$在$[a,b]$可导,介于$f'_{-}(a),f'_{+}(b)$之间的值,$f'(x)$在$[a,b]$上都能取到.  


> 上面两个性质可以用作不定积分时原函数存在的必要条件检验.  

## MISC

#### 关于 $x^{x^x}$

这应当设$x^{(x^x)}$,否则$(x^x)^x=x^{(x^2)}$


#### 隐函数求导\&偏数

隐函数求导,是方程$F(x,y)$在局部确定了函数$x=f(y),y=g(x)$,  
这里的$x,y$并不是独立的,所以$x=f(y)$对$x$求微分应该得到$dx=d(f(y))=f'(y)dy$.

偏导数是二元函数$f(x,y)$仅仅考虑其中一个量变换,其他的参量都固定时,$\Delta f(x,y)$与$\Delta x$的关系.


#### 高阶导数的一些公式

$$
(uv)^n=\sum_{i=0}^n \binom{n}{i} u^{(i)}v^{(n-i)}
$$

#### 构造

关于导数的构造, (详见ODE求解章节)

- $e^x f(x)\to e^x(f(x)+f'(x))$
- $e^{-x} f(x)\to e^{-x}(f'(x)-f(x))$
- $xf(x)\to f(x)+f'(x)$
- $\frac{f(x)}{x}\to \frac{1}{x^2}(f'(x)-xf(x))$

有时还需要乘上一个常数或者加上一个低次多项式进行修正.

#### 一个有趣的构造

> 在$[0,1]$二阶可微的函数$f(x)$满足$f(0)=f'(0),f(1)=f'(1)$,  
> 求证$\exists \xi\in (0,1)\quad f(\xi)=f''(\xi)$.  

这肯定要构造$g(x)$满足$g(0)=g(1)=0$然后$\exists \xi\in(0,1)\ g'(\xi)=0$.  
自然想法是$g(x)=f(x)-f'(x)$但是这样$g'(x)=f'(x)-f''(x)$差了一阶导数.  
另一个构造更好用,它是$g(x)=e^x(f(x)-f'(x))\quad g'(x)=e^x(f-f'+f'-f'')=e^x(f-f'')$  



#### 一些一致连续证明

> 证明$y=\ln x$在$(0,1)$并非一致连续.  
>
> 就是要找$x_1,x_2$足够接近,但是$|f(x_1)-f(x_2)|$有非0下界.  
> 在这里$y'=\frac{1}{x}$在$x\to 0$时,$y'$远大于$x$,于是$\Delta y\sim f'(x)\Delta x$可以很大.

考虑$a_n=e^{-n}$与$b_n=e^{-(n+1)}$这两个序列的间距

$$
|e^{-n}-e^{-(n+1)}|< |e^{-n}|+|e^{-(n+1)}|<2|e^{-n}|=\frac{2}{e^n}
$$

这是可以任意小的(形式化地讲是 $\forall\epsilon >0,\exists N\ \text{s.t.}\ \forall n>N\quad |a_n-b_n|<\epsilon$)

然而

$$
\ln(e^{-n})-\ln(e^{-(n+1)})=1
$$

并不能任意小,所以$y=\ln x$在$(0,1)$并非一致连续.

另一个想法更简,考虑$a_n=\frac{1}{n},b_n=\frac{1}{2n}$



#### p级数收敛性

- 首先是$H_n=\sum_{i=1}^n \frac{1}{n}$

$$
\begin{aligned}
&\text{let }I_n=[2^n+1,2^{n+1}],T_n=\sum_{i\in I_n} \frac{1}{i}>\frac{1}{2^{n+1}}\times 2^n=\frac{1}{2}\\
&\text{where }I_i\cap I_j=\phi,\cup_{k\geq 0} I_k=N^{+}\\
&\sum_{i=1}^{2^{n+1}}\frac{1}{i}=\sum_{i=1}^nT_i> \frac{n}{2}\\
\end{aligned}
$$

无界,故不收敛.



- 然后是$p>1,p\in \mathbb N$的情况,类似地,进行区间划分,不过这次有.

$$
\sum_{i\in I_N}\frac{1}{i^p}<\frac{2^n}{(2^n)^p}=(2^{(1-p)})^n\quad 2^{1-p}\leq 2^{1-2}=\frac{1}{2}<1
$$

放大到一个公比小于$1$的几何级数,故收敛.

- $p\in (0,+\infty)$由$f(p)=\frac{1}{n^p}=(\frac{1}{n})^p\quad \frac{1}{n}<1$的单调性,进行比较判别,即可证明收敛性.



> 此外注意一下$\sum_{n=1}^\infty \frac{1}{n\ln n}$这里$\displaystyle \forall \epsilon >0,\lim_{x\to \infty}\frac{\ln x}{x^\epsilon}=0$  
> $$
> \begin{aligned}
> &\int \frac{\mathrm dx}{x\ln x}=\int \frac{\mathrm d(\ln x)}{\ln x}=\ln|\ln x|+1\\
> &\sum_{n=1}^\infty \frac{1}{n\ln n}\sim \int_1^\infty \frac{\mathrm dx}{x\ln x}\sim \ln\ln x\to \infty 
> \end{aligned}
> $$
> 所以这东西是发散的.  
> 也可以类似上面的做法$2^i\ (i=0,1,2\dots )$项放到一起考虑,段和是大于$\frac{2^n}{2^{n+1}\times (n+1)\ln2}=\frac{1}{2\ln 2}\times \frac{1}{n+1}$也可看出发散



#### 张江理工midterm: 2020fall 数学分析1,第八题

> 函数$f(x)$定义在$(0,+\infty)$上,可微,满足$\sqrt x\ f'(x)$有界.  
> 证明$f(x)$一致连续.

考虑$f'(x)\sqrt x$怎么构造出来,其中有一种是$\frac{f'(x)}{2(\sqrt x)'}$,提示我们使用Cauchy中值定理.  

设$M$为$|\sqrt x\ f'(x)|$的一个上界.  


$$
\begin{aligned}
&\forall 1< x_1 < x_2\quad\exists \xi\in(x_1,x_2)\\
&\frac{f(x_2)-f(x_1)}{\sqrt{x_2}-\sqrt{x_1}}=\frac{f'(\xi)}{\frac{1}{2\sqrt{\xi}}}=2\sqrt{\xi}f'(\xi)\\
&f(x_2)-f(x_1)=2(\sqrt{x_2}-\sqrt{x_1})\sqrt{\xi}f'(\xi)\\
\end{aligned}
$$


这里考虑一下$\sqrt{x_2}-\sqrt{x_1}$,由于$y=\sqrt x$是上凸的,  
有$\sqrt{x_1+(x_2-x_1)}-\sqrt{x_1}\leq \sqrt{0+(x_2-x_1)}-\sqrt{0}$  


$$
\begin{aligned}
&\forall \epsilon>0,\text{ let }\delta=(\frac{\epsilon}{2M})^2\\
&\forall x_1,x_2>0\text{ s.t. }|x_2-x_1|<\delta\quad \exists\xi\in(x_1,x_2)\\
&|f(x_2)-f(x_1)|=|2(\sqrt{x_2}-\sqrt{x_1})\sqrt{\xi}f'(\xi)|\\
&<|2\sqrt{x_2-x_1}\sqrt\xi f'(\xi)|\\
&\leq |2M\sqrt{\delta}|=\epsilon
\end{aligned}
$$

于是一致连续.  

#### "形式一致,拉格朗日"

> 出现形式一致的式子的变化量时,可以使用拉格朗日中值定理

$$
\begin{aligned}
&k>1\quad \lim_{n\to\infty}(n+k)^\frac{1}{k}-n^\frac{1}{k}\\
&\text{let }f_k(x)=x^\frac{1}{k}\quad \text{Lagrange's mean value theorem}\\
&\exists \xi_n\in(n,n+k)\quad (n+k)^\frac{1}{k}-n^\frac{1}{k}=((n+k)-n)\times \frac{1}{k}\xi^{\frac{1}{k}-1}=\xi^{\frac{1}{k}-1}\\
&\lim_{n\to\infty}(n+k)^\frac{1}{k}-n^\frac{1}{k}=\lim_{n\to\infty} {\xi_n}^{\frac{1}{k}-1}=\lim_{x\to+\infty} x^{\frac{1}{k}-1}=0
\end{aligned}
$$


#### 三角和差化积/积化和差裂项

> 除了$e^{ix}=\cos x+i\sin x$这种东西,还可以试试常规的变换.  


- 等差数列的正弦,乘上公差一半的正弦,积化和差. 

$$
\begin{aligned}
S_1&=\sum_{i=0}^n \sin(a+ix)\\
2\sin(\frac{x}{2})S_1&=\sum_{i=0}^n 2\sin(a+ix)\sin(\frac{x}{2})\\
&=\sum_{i=0}^n \cos(a+ix+\frac{x}{2})-\cos(a+ix-\frac{x}{2})\\
&=\sum_{i=1}^{n+1} \cos(a+ix-\frac{x}{2})-\sum_{i=0}^n \cos(a+ix-\frac{x}{2})\\
&=\cos(a+\frac{x}{2}(2n+1))-\cos(a-\frac{x}{2})
\end{aligned}
$$


#### 三角函数积分

- 万能代换$t=\tan \frac{x}{2},\sin x=\frac{2t}{1+t^2},\cos x=\frac{1-t^2}{1+t^2},\tan x=\frac{2t}{1-t^2}$
- 和差化积,积化和差
- $f(a+b),f(2a),f(\frac{a}{2})$
- 平方和变换,换$1=\sin^2 x+\cos^2 x,1+\tan^2 = \sec^2 x$
- 还可以试试$e^{ix}=\cos x+i\sin x$

$\int\frac{\mathrm dx}{a^2\sin^2 x+b^2\cos^2 x}\quad (a,b>0)$  
同时出现$\sin ,\cos$两个正交的量,难以处理也不是常见的$a\sin x+b\cos x$.  
一个可行的做法是除掉$\cos^2 x$,分子得到$\sec^2 x\mathrm dx=\mathrm d(\tan x)$,分母正好也化为$\tan x$的函数.换元之后可以轻松解决. 


万能代换在三角函数的有理函数时比较好用,可以轻松转化成常规有理函数积分,然后就是分解分母,待定系数拆开,一次式对应$\ln$二次式对应$\arctan$的常规流程.


#### 由变上限积分的定义函数的导数


> - 由闭区间$[a,b]$上的可积函数,做变上限积分定义的函数一定连续.  
> - 如果被积函数在某处是连续的,那么变上限积分在此处可导且导数为被积函数的函数值.  


$F(x)=\int_a^{r(x)} f(g(t))\mathrm dt$

$r(x)$,对$r(x)$求导,再乘上$r(x)$对$x$求导.  

$$
\frac{\mathrm d(F(x))}{\mathrm dx}
=\frac{\mathrm d(F(x))}{\mathrm d(r(x))}\cdot \frac{\mathrm d(r(x))}{\mathrm dx}
=f(g(\,r(x)\,)\ r'(x)
$$

对于$\int_{l(x)}^{r(x)}$的东西,差分一下$\int_a^{r(x)}-\int_a^{l(x)}$即可.  


我们来看些例子,一层一层的做就行了..

$$
\begin{aligned}
(1)\quad f(x)&=\int_0^{x^2}\sin(t^2) \mathrm dt\\
\frac{\mathrm df(x)}{\mathrm dx}&=\frac{\mathrm d f(x)}{\mathrm d(x^2)}\,\frac{\mathrm d(x^2)}{\mathrm dx}=\sin(x^4)\cdot 2x=2x\sin(x^4)\\
\newline\\
(2)\quad f(x)&=\int_x^1\frac{\mathrm dt}{1+t^2+\cos^2 t}=-\int_1^x \frac{\mathrm dt}{1+t^2+\cos^2 t}\\
\frac{\mathrm  d }{\mathrm dx}f(x)&=-\frac{\mathrm d}{\mathrm dx}\int_1^x \frac{\mathrm dt}{1+t^2+\cos^2 t}=-\frac{1}{1+x^2+\cos^2 x}\\
\newline\\
(3)\quad f(x)&=\int_x^{x^2}e^{-t^2}\mathrm dt=\int_0^{x^2}e^{-t^2}\mathrm dt-\int_0^x e^{-t^2}\mathrm dt\\
f'(x)&=2xe^{-x^4}-e^{-x^2}\\
\newline\\
(4)\quad f(x)&=\sin(\int_0^x\sin(\int_0^y\sin^2 t\mathrm dt)\mathrm dy)\\
f'(x)&=\cos(\int_0^x\sin(\int_0^y\sin^2 t\mathrm dt)\mathrm dy)\cdot (\int_0^x\sin(\int_0^y\sin^2 t\mathrm dt)\mathrm dy))'\\
&=\cos(\int_0^x\sin(\int_0^y\sin^2 t\mathrm dt)\mathrm dy)\cdot \sin(\int_0^x\sin^2 t\mathrm dt)\\
&=\cos(\int_0^x\sin(\frac{y}{2}-\frac{\sin2y}{4})\mathrm dy)\cdot \sin(\frac{x}{2}-\frac{\sin 2x}{4})\\
\end{aligned}
$$



#### 可以使用积分计算的和式

$$
\begin{aligned}
(p>1)&\lim_{n\to \infty}\frac{\sum_{i=1}^n i^p}{n^{p+1}}
=\lim_{n\to \infty}\sum_{i=1}^n {(\frac{1}{n})}\cdot \frac{1}{n}\\
&\lim_{n\to \infty}\sum_{i=0}^{n-1}\frac{1}{\sqrt{n^2 - i^2}}
=\lim_{n\to \infty}\sum_{i=0}^{n-1}\frac{1}{\sqrt{1 - {(\frac{1}{n})}^2}}\cdot \frac{1}{n}
\end{aligned}
$$

考察$T_n=(\frac{1}{n},\frac{2}{n},\frac{3}{n}\ldots \frac{n}{n})$有$||T_n||\to 0(\forall \delta,\exists N \text{ s.t. }\forall n>N,||T_n||<\delta)$,而$S(T)=\sum_{i=1}^n (\frac{i}{n}-\frac{i-1}{n})f(\frac{i}{n})=\sum_{i=1}^n \frac{1}{n}f(\frac{i}{n})$.  
如果$I=\int_0^1 f(x)\mathrm dx$存在,那么根据黎曼积分的定义,可以推出$\sum\to I$.

#### 一个简单的,非常松的不等式.  

> $[0,1]$上可积,单调减的函数$f(x)$,证明$\int_0^\alpha f(x)\mathrm dx\leq \alpha\int_0^1 f(x)\mathrm dx$  


$$
\begin{aligned}
\int_0^\alpha f(x)\mathrm dx-\alpha\int_0^1 f(x)\mathrm dx
&=\int_0^\alpha f(x)\mathrm dx-\alpha(\int_0^\alpha f(x)\mathrm dx+\int_\alpha^1 f(x)\mathrm dx)\\
&=(1-\alpha)\int_0^\alpha f(x)\mathrm dx-\alpha\int_\alpha^1 f(x)\mathrm dx\\
&\geq (1-\alpha)\alpha f(\alpha)-\alpha (1-\alpha)f(\alpha)\\
&=0\\
\newline\\
\implies \mathrm{LHS}\leq \mathrm{RHS}&
\end{aligned}
$$

remark: 上下限不一样的时候,除了换元,还可以试试差分一下.

#### 非常经典的积分计算

$$\int_0^1 \frac{\ln (x+1)}{1+x^2}\mathrm dx$$

$$
\begin{aligned}
I=&\int_0^1 \frac{\ln (x+1)}{1+x^2}\mathrm dx\quad \text{let }x=\tan t,\mathrm dx=\sec^2 x\,\mathrm dx\\
I=&\int_0^\frac{\pi}{4} \frac{\ln(\tan t+1)}{1+\tan^2 t}\sec^2\mathrm dt
=\int_0^\frac{\pi}{4} \ln(\tan t+1)\mathrm dt\\
=&\int_\frac{\pi}{4}^0\ln(\tan(\frac{\pi}{4}-x)+1)\mathrm d(\frac{\pi}{4}-x)\\
=&\int_0^\frac{\pi}{4}\left[\ln 2-\ln(1+\tan x)\right]\mathrm dx=\frac{\pi}{4}\ln 2-I\\
&\implies I=\frac{\pi}{8}\ln 2\\
\end{aligned}
$$

其中

$$
\tan(\frac{\pi}{4}-x)
=\frac{1-\tan x}{1+\tan x}
\quad
\tan(\frac{\pi}{4})+1=\frac{2}{1+\tan x}  
$$


- 看到$a+x^2,a-x^2$都可以试试进行三角换元,除了非常套路的$\sqrt{a^2-x^2}$,  
以及$\mathrm d(\arctan x)=\frac{\mathrm dx}{1+x^2},\mathrm d(\tan x)=(1+\tan^2 x)\mathrm dx=\sec^2 x\, \mathrm dx$
- 对于很好的对称性/周期性,可以试试换元得原积分的方程($[0,a]\mathrm d(f\,x)\to [a,0]\mathrm d(f\, (a-x))$或者$[0,a]x\to \frac{1}{2}([0,a]\mathrm d(f\,x)+[a,0]\mathrm d(f\, (a-x))$).  


再来看个题目$\int_0^{2\pi}\frac{\mathrm dx}{1+\tan^3 x}$  

$$
\begin{aligned}
I&=\int_0^{\pi/2}\frac{\cos^3 x}{\cos^3 x+\sin^3 x}\mathrm dx
=\int_{\pi/2}^0 \frac{\cos^3(\frac{\pi}{2}-x)}{\sin^3 x+\cos^3 x}\mathrm d(\frac{\pi}{2}-x)\\
&=\int_0^{\pi/2}\frac{\sin^3 x}{\cos^3 x+\sin^3 x}\mathrm dx\\
2I&=\int_0^{\pi/2}\frac{\sin^3 x+\cos^3 x}{\sin^3 x+\cos^3 x}\mathrm dx =\int_0^{\pi/2} 1\mathrm dx=\frac{\pi}{2}\\
I&=\frac{\pi}{4}
\end{aligned}
$$


#### 一个无穷级数收敛性问题的小套路

> 判定$S=\sum_{n=1}^\infty \frac{\sin(n)}{n}$的收敛性.  
> 我在 中科大数学分析讲义 中看到的这个题目.

这里$\{\sum \sin(n)\}$有界,而$\{\frac{1}{n}\}$单调且收敛于$0$,于是级数收敛(Dirichlet 判别法).  
再考虑$S'=\sum_{n=1}^\infty \left\vert \frac{\sin n}{n}\right\vert$的收敛性.  

难以直接判断,但是$0\leq \sin^2 x\leq \left\vert\sin x\right\vert$我们可以考察$T=\sum_{n=1}^\infty \frac{\sin^2 n}{n}$.  

$$
T=\sum_{n=1}^\infty \frac{\sin^2 n}{n}
=\sum_{n=1}^\infty \frac{1-\cos(2n)}{2}\cdot \frac{1}{n}=\frac{1}{2}\sum_{n=1}^\infty(\frac{1}{n}-\frac{\cos(2n)}{n})
$$

此处$\sum_n \frac{\cos(2n)}{n}$也可以用Dirichlet判别法说明是收敛的.  
如果$T$收敛,那么$\sum_n \frac{1}{n}$也会收敛.  
于是$T$不能收敛,而$S'$比$T$增长快,于是也不收敛.  



#### 分部积分的基础套路

> 对于 $\ln,\exp$ 总可以通过分部积分和多项式互相消除

第一个例子是 $\ln^k x$

$$
I_k=\int \ln^k x\mathrm{d}x
=x\ln^k x-\int x\, k\ln^{k-1}x\frac{1}{x}\mathrm{d}x
=x\ln^k x-k\int \ln^{k-1}\mathrm{d}x=x\ln^k x - k I_{k-1}
$$

下一个例子是 $x^k e^x$

$$
I_k=\int x^k e^x\mathrm{d}x
=\int x^k \mathrm{d}(e^x)
=x^k e^x -k\int x^{k-1}e^x \mathrm{d}x
=x^k e^x -k I_{k-1}
$$

最后是 非常经典的 $\sin^n x$

$$
\begin{aligned}
I_n
&=\int_{0}^{\pi/2}\sin^n x\ \mathrm{d} x\\
&=-\int_{0}^{\pi/2}\sin^{n-1}x\ \mathrm{d}(\cos x)\\
&=-\left(\sin^{n-1}x\cos x\right)\vert_{0}^{\pi/2}+(n-1)\int_0^{\pi/2}\sin^{n-2}\cos^2 x\mathrm{d}x\\
&=0+(n-1)\int_0^{\pi/2}\sin^{n-2}(1-\sin^2 x)\mathrm{d}x\\
&=(n-1)I_{n-2}-(n-1)I_n\\
nI_n
&=\frac{n-1}{n}I_{n-2}
\end{aligned}
$$
