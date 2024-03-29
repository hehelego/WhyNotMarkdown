[TOC]

## ODE 初步

### ODE入门解法

- fisrt-order ODE
  - 可分离变量: 一阶微分形式不变性,直接积分
  - 齐次方程: 换元$u=\frac{y}{x},\mathrm{d}(y)=\mathrm{d}(ux)=u\mathrm{d}x+x\mathrm{d}u$之后可以分离变量
  - 一阶线性微分方程: (积分因子法:构造出可分离变量的微分方程;常数变易法:线性齐次方程的解构造出线性非齐次的方程的解)  
  $y'+p(x)y$类似乘法求导即$(uy)'=uy'+u'y$,给原方程乘上一个$v$以构造$(uy)'$有  
  $vy'+vp(x)y=uy'+u'y$于是$v=u,vp(x)=u'=v'$解出一个$v$即可,比如$v=e^{\int p(x)\mathrm{d}x}$  
  得到$\left(ye^{\int p(x)\mathrm{d}x}\right)'=-q(x)e^{\int p(x)\mathrm{d}x}$.
- second-order linear ODE
  - $y''+p(x)y'+q(x)y=f(x)$,和对应的齐次(homogeneous)方程$y''+p(x)y'+q(x)y=0$
  - 解存在性条件,解唯一性条件,解空间结构: 引入Wronskian(朗斯基行列式).
    - the set of all solution of a $n$-th order linear homogeneous ODE forms a $n$-dimensional vector space.
    - the set of all solution of a $n$-th order linear ODE forms a affine spcae.
    - if $y_1,y_2,y_3\ldots y_n$ is linearly dependent, then
      $$W(x)=\begin{vmatrix}y_1^{(0)}&y_2^{(0)}&\ldots &y_n^{(0)}\\ y_1^{(1)}&y_2^{(1)}&\ldots &y_n^{(1)}\\ \vdots&\vdots &\ldots &\vdots\\ y_1^{(n-1)}&y_2^{(n-1)}&\ldots &y_n^{(n-1)}\\ \end{vmatrix}\equiv 0(x)$$
    - **However**, $W(x)\equiv 0(x)$ on interval $I$ doesn't mean that $y_1,y_2\ldots y_n$ are linearly dependent.
  - Liouville公式: $y''+p(x)y'+q(x)y=0$两个解$y_1(x),y_2(x)$的Wronskian有一定特殊性(一点为0,全局为0; 一点非0,全局非0)  
    $$\begin{aligned} W(x)&=y_1y_2'-y_1'y_2\\ W'(x)&=(y_1'y_2'+y_1y_2'')-(y_1''y_2+y_1'y_2')=y_1y_2''-y_1''y_2\\ &=-y_1\left(p(x)y_2'+q(x)y_2\right)+(p(x)y_1'+q(x)y_1)y_2\\ &=-(y_1y_2'-y_1'y_2)p(x)+(-y_1y_2+y_1y_2)q(x)\\ &=-W(x)\\ \implies &W(x)=W(x_0)e^{\int_{x_0}^{x}-p(t)\mathrm{d}t} \end{aligned}$$
  - 求$y''+p(x)y'+q(x)=f(x)$的解空间,  
    需要$y''+p(x)y'+q(x)y=0$的解空间(由两个线性无关解$y_1,y_2$张成)  
    和一个非齐次方程的特解.
    - 常数变易法(求特解):  
      1. 线性齐次方程的解为$C_1y_1+C_2y_2$.
      2. 假设将常数用$x$的函数替换可以得到线性非齐次方程的解
      即$y=C_1(x)y_1+C_2(x)y_2$为线性非齐次方程的解
      3. 计算$y',y''$有  
      $y'=(C_1'y_1+C_2'y_2)+(C_1y_1'+C_2y_2')$  
      为了防止$y''$中出现$C''$(那样的话,我们会得到关于$C$的二阶ODE,无法规约为更简单的情况),  
      我们假设$C_1'y_1+C_2'y_2=0$于是$y'=C_1y_1'+C_2y_2'$  
      $y''=C_1'y_1'+C_1y_1''+C_2'y_2'+C_2y_2''$
      4. 将上述导数带入原来的线性非齐次方程,利用$y_1,y_2$为齐次方程的解,  
      即$y_1''+p(x)y_1'+q(x)y_1=y_2''+p(x)y_2'+q(x)y_2=0$化简方程,  
      得到$C_1'y_1'+C_2'y_2'=f(x)$
      5. 下式中$x_0$为区间上任意一点.  
      $$\begin{aligned} &\begin{cases} C_1'y_1+C_2'y_2&=0\\ C_1'y_1'+C_2'y_2'&=f(x) \end{cases} \implies \begin{cases} C_1(x)=-&\int_{x_0}^{x}\frac{y_2(t)f(t)}{W(t)}\mathrm{d}{t}\\ C_2(x)=&\int_{x_0}^{x}\frac{y_1(t)f(t)}{W(t)}\mathrm{d}{t}\\ \end{cases}\\ &\implies y(x)=\int_{x_0}^{x} \frac{y_1(t)y_2(x)-y_2(t)y_1(x)}{W(t)}f(t)\mathrm{d}t \end{aligned}$$
    - 已知线性齐次ODE的一个non-trival solution,构造出另一个与之线性无关的解:  
      1. 已知$y_1''+p(x)y_1'+q(x)y_1=0$,求$y_2$满足线性齐次ODE,且与$y_1$线性无关.
      2. Wronskian的两种表达  
      $$W(x)=W(x_0)e^{\int_{x_0}^x -p(t)\mathrm{d}t}={(y_1)}^2\ \frac{y_1y_2'-y_2y_1'}{{(y_1)}^2}={(y_1)}^2\left(\frac{y_2}{y_1}\right)'$$
      线性齐次方程,解乘上一个常数仍然是解,所以我们可以丢弃$W(x_0)$和$\int_{x_0}^x -p(t)\mathrm{d}t$的积分下限.  
      $$e^{\int -p(x)\mathrm{d}x}={(y_1)}^2\left(\frac{y_2}{y_1}\right)' \qquad \left(\frac{y_2}{y_1}\right)' = \frac{\exp\left(\int -p(x)\mathrm{d}x\right)}{{(y_1)}^2}$$  
      同样地,舍弃常数,得到任意一个满足上述方程的$y_2$即可.
    - 求线性齐次ODE的解: 利用微分算子;观察形式待定系数;各种玄学.
- reduction
  - 经典的降次
    - Bernoulli方程: $y'+p(x)y=q(x)y^n$, 除掉$y^n$有  
      $y^{-n}y'+p(x)y^{n-1}=\left(y^{n-1}\right)'+p(x)\left(y^{n-1}\right)=q(x)$
    - $F(x,y',y'')=0$换$u=y'$有$F(x,u,\frac{\mathrm d u}{\mathrm d x})=0$
    - $F(y,y',y'')=0$换$p=\frac{\mathrm dy}{\mathrm d x},\frac{\mathrm{d}^2 y}{\mathrm{d} x^2}=\frac{\mathrm d p}{\mathrm d x}=\frac{\mathrm d p}{\mathrm dy}\frac{\mathrm d y}{\mathrm dx}=p\frac{\mathrm d p}{\mathrm d y}$有$F(y,p,p\frac{\mathrm d p}{\mathrm d y})$
  - 其他方法...整体换元,三角换元,玄妙降阶.


(Homogeneous equation with constant coefficients)    
求常系数(有理数/实数/复数都可以)线性齐次ODE的解 $y^{(n)}+\sum_{i=0}^{n-1} a_i y^{(i)}=0$  
特征方程法(求形如$y=e^{\lambda x}$的解,寻找解空间的基),设$y=e^{\lambda x}$有$y^{(n)}=\lambda^n y$代入  
$$\lambda^n e^{\lambda x}+\sum_{i=0}^{n-1} \lambda^i a_i e^{\lambda x}=0\iff \lambda^n+\sum_{i=0}^{n-1} a_i \lambda^i =0$$  
由代数学基本定理,该方程有$n$个根,对应原方程的$n$个解.  
- 不相等的根对应的函数,显然线性无关.
- (实系数情况)对于共轭根$\lambda ,\overline{\lambda}$,线性组合可以得到两个$\mathbb{R}\to\mathbb{R}$的函数  
$$\begin{aligned} &e^{(a+bi)x}=e^a(\cos bx+i\sin bx)\quad e^{(a-bi)x}e^a(\cos bx-i\sin bx)\\ &\frac{e^{(a+bi)x}+e^{(a-bi)x}}{2}=e^a\cos bx\quad \frac{e^{(a+bi)x}-e^{(a-bi)x}}{2i}=e^a\sin bx \end{aligned}$$
- 出现$k$重根,有$0=(\lambda-\lambda_0)^k P_{n-k}(\lambda )$形式的特征方程,  
做常数变易,设$C(x)e^{\lambda_0 x}$根,带入原方程,可以得到  
$e^{\lambda_0 x},\, xe^{\lambda_0 x},\ x^2e^{\lambda_0 x}\ldots x^{k-1}e^{\lambda_0 x}$
这样一组$k$个线性无关的解.
- 于是我们找的了$n$个线性无关的解,它们的span就是原线性齐次ODE的解.

更进一步地,配合使用常数变易法,可以解出任意的$n$阶常系数线性非齐次ODE.

> reminder,对于整系数多项式方程,其有理数根的最简形式满足: 分子是常数项的约数而分母是最高次项的系数.  
> 这对于求解高次常系数线性齐次ODE的特征方程很有帮助  
> Given that $P(x)=\sum_{i=0}^n a_i x^i\in \mathbb{Z}[x]$ and $P(\frac{p}{q})=0\ \mathrm{gcd}(p,q)=1$ we can show that $p\mid a_0\land q\mid a_n$  

$$
\begin{aligned}
&P(\frac{p}{q})=0\land (p,q)=1\\
\implies & P(\frac{p}{q})\equiv \sum_{i=0}^n a_i p^i {(q^{-1})}^i\equiv a_0 \equiv 0 \pmod p\implies p\mid a_0\\
&q^n P(\frac{p}{q})\equiv \sum_{i=0}^n a_i p^i q^{n-i}\equiv a_n\equiv 0\pmod q\implies q\mid a_n
\end{aligned}
$$




## 多元函数微分学

### Lagrange乘子法-条件极值

- 求$F(x,y)$的极值, 其中$G(x,y)=0$  
  对于约束$G(x,y)=0$,用隐函数定理确定$y=y(x)$和$\frac{\mathrm{d}y}{\mathrm{d}x}$.  
  对$G(x,y)=0$求全微分$\mathrm{d}G=G_x\mathrm{d}x+G_y\mathrm{d}y=(G_x+G_y\frac{\mathrm{d}y}{\mathrm{d}x})\mathrm{d}x=0$即$\frac{\mathrm{d}y}{\mathrm{d}x}=-\frac{G_x}{G_y}$.  
  回代$F(x,y)=F(x,y(x))$,求驻点 $F_x+F_y\frac{\mathrm{d}y}{\mathrm{d}x}=0\implies \frac{F_x}{F_y}=\frac{\mathrm{d}y}{\mathrm{d}{x}}=-\frac{G_x}{G_y}\iff \frac{F_x}{G_x}=-\frac{F_y}{G_y}$  
  设这个比值为$\lambda$
  $$
  \begin{cases}
  F_x+\lambda G_x=0\\
  F_y+\lambda G_y=0\\
  G(x,y)=0\\
  \end{cases}
  $$
  就是希望乐见的$\nabla (F+\lambda G)=\vec 0$了.
- 求$F(x,y,z)$的极值, 其中$\mu(x,y,z)=\varphi(x,y,z)=0$
  用隐函数定理确定$z=z(x,y)$
  $$
  \begin{aligned}
  &\begin{bmatrix} 0\\ 0 \end{bmatrix}
  =\begin{bmatrix} \mu(x,y,z(x,y))\\ \varphi(x,y,z(x,y)) \end{bmatrix}\\
  &\begin{bmatrix} 0&0\\ 0&0 \end{bmatrix}
  =\begin{bmatrix}
    \mu_x+\mu_z z_x & \mu_y+\mu_z z_y\\
    \varphi_x+\varphi_z z_x & \varphi_y+\varphi_z z_y
  \end{bmatrix}\\
  &-\begin{bmatrix}
  \mu_x & \mu_y\\
  \varphi_x & \varphi_y
  \end{bmatrix}
  =\begin{bmatrix}
    \mu_z & \mu_z \\
    \varphi_z & \varphi_z
  \end{bmatrix}
  \begin{bmatrix} z_x\\ z_y \end{bmatrix}\\
  \end{aligned}
  $$
  类似上面的操作,有$\nabla (F+a\mu+b\varphi)=0$


### 空间解析几何: 曲面/曲线 的 切/法向

空间解析几何中,我们用一般方程和参数方程表示曲面和曲线.  
这里仅仅是辅助记忆和提供套路,不会关心严谨性.

- 曲线有一个自由度, 是一个$R\to R^n$的参数方程,$\vec r(t)=[x_i(t)]$.  
  由定义,$\vec r'(t)=[x_i'(t)]$为曲线在$\vec r(t)$处的切向.
- 曲面有$n-1$个自由度, 是一个方程 $F(\vec x)=0$  
  考察$F$确定的曲面上的任意曲线$\vec r(t)=[r_i(t)]$,有$F(\vec r(t))=0$,两边对$t$求导,  
  $0=\sum_{i=1}^n \frac{\partial F}{\partial x_i}(\vec r(t))\frac{\mathrm{d} r_i}{\mathrm{d} t}(t)=\nabla F(\vec r(t)) \cdot \vec r'(t)$  
  对于曲面上任意一点$P$,考虑所有$\vec r(t_0)=P$的曲线,有$\nabla F\left(\overrightarrow{OP}\right) \cdot \vec r'(t_0)=0$  
  即$\nabla F$为所有过该点的曲线的法向.  
  所以,对于一个满足$F(\vec x_0)=0$的点$x_0$(即曲面上一点),我们有$\nabla F(\vec x_0)$是曲面在$\vec x_0$的法向.

- 多个曲面相交得到的曲线,  
  $\begin{cases}
  F_1(x_1,x_2\ldots x_n)=0\\
  F_2(x_1,x_2\ldots x_n)=0\\
  \vdots\\
  F_m(x_1,x_2\ldots x_n)=0\\
  \end{cases}$  
  对于一个满足上述方程组,即曲线上一点$\vec x_0$,  
  有$\mathop{span}(\nabla F_1(x_0),\nabla F_2(x_0)\ldots \nabla F_m(x_0))$为曲线法向.  
  而这个空间的orthogonal completement为曲线切向(在三维空间中,可以通过cross product计算).
- 多个曲线张成的曲面,即参数曲面.  
  $\begin{cases}
  x_1=x_1(t_1,t_2\ldots t_n)\\
  x_2=x_2(t_1,t_2\ldots t_n)\\
  \vdots\\
  x_n=x_n(t_1,t_2\ldots t_n)\\
  \end{cases}$  
  对于一个参量$t_k$,我们可以求${\left[\frac{\partial x_i}{\partial t_k}\right]}_{i}$是曲面的一个切向, 它们张成了曲面切面,  
  在三维空间中,可以由两个切向cross product求出法向.


### Jacobian matrix

> 对于$F:R^n\to R^m$,或写为分量形式$y_k=f_k(x_1,x_2\ldots x_n)$  
> 其Jacobi矩阵${\mathbf{J}}_{f}={\left[ \frac{\partial f_i}{\partial x_j} \right]}_{i,j}$  
> 可以看作一个$\mathop{span}(\mathrm d x_1,\mathrm d x_2 \ldots x_n) \to \mathop{span}(\mathrm d y_1,\mathrm d y_2 \ldots \mathrm d y_m)$的linear mapping.  
> 而Jacobi矩阵的乘法,就是多元函数复合的chain rule.

已知一些函数的关系, 根据这些关系, 写出关于Jacobi矩阵的方程, 解方程,可以做不少有趣的结论.  

- 隐函数定理(描述隐函数存在的充分不必要条件,并给出隐函数的微分计算方式)
- 反函数/逆映射定理(描述逆映射存在的必要不充分条件,并给出原函数和反函数的微分的关系)

### Taylor of multi-var

以二元函数为例,$(x,y)\to (x+h,y+k)$假设偏导都是连续(推出可以换序)  
令$g(t)=f(x+th,y+tk)\quad t\in [0,1]$在$0$处展开,求$1$处的值(收敛性之类的先不做讨论,暂且只考虑形式)

$$
\begin{aligned}
g(1)
&=f(x+h,y+k)\\
&=\sum_{k=0}^n \frac{g^{k}(0)}{k!}{(1-0)}^k + R_n\\
&=R_n+\sum_{k=0}^n \frac{1}{k!}\sum_{i=0}^k
  \binom{k}{i}\frac{\partial^{k} f}{\partial x^{i}\partial y^{k-i}}(x+0h,y+0k)
  {\left(\frac{\mathrm{d} (x+th)}{t}\right)}^{i}
  {\left(\frac{\mathrm{d} (y+tk)}{t}\right)}^{k-i}\\
&=R_n+\sum_{k=0}^n \frac{1}{k!}\sum_{i=0}^k
  \binom{k}{i}h^{i} k^{k-i}\frac{\partial^{k} f}{\partial x^{i}\partial y^{k-i}}(x,y)
\end{aligned}
$$

其中余项
- Peaon: $R_n=o({(1-0)}^n)=o(1)$ 这个太弱,没有什么使用意义.
- Lagrange: $\exists \xi \in (0,1)\quad R_n=\frac{1}{(n+1)!}\sum_{i=0}^{n+1}\binom{n+1}{i}h^i k^{n+1-i} \frac{\partial^{n+1}f}{\partial x^{i}\partial y^{n+1-i}}(x+\xi h,y+\xi k)$

Lagrange余项比较有用,但是形式过于复杂,不易估计其大小,我们会尝试寻找类似一元函数中Peaon余项的$o\left({\left(\sqrt{h^2+k^2}\right)}^n\right)$  

令$\displaystyle L=\max_{0\leq i\leq n+1}\left\{\frac{\partial^{n+1}f}{\partial x^{i}\partial y^{n+1-i}}(x+\xi h,y+\xi k)\right\}\quad u=|h|,v=|k|$我们估算Lagrange余项的大小.

$$
\begin{aligned}
\left\vert R_n\right\vert 
&=
\frac{1}{(n+1)!}\sum_{i=0}^{n+1}\binom{n+1}{i}h^i k^{n+1-i} \frac{\partial^{n+1}f}{\partial x^{i}\partial y^{n+1-i}}(x+\xi h,y+\xi k)\\
&\leqslant 
\frac{L}{(n+1)!}\sum_{i=0}^{n+1}\binom{n+1}{i}u^i v^{n+1-i}\\
&=\frac{L}{(n+1)!}{(u+v)}^{n+1}\\
\implies
\frac{|R_n|}{{\left(\sqrt{h^2+k^2}\right)}^n}
&=\frac{L}{(n+1)!}(u+v) \cdot {\left(\frac{u+v}{\sqrt{h^2+k^2}}\right)}^n\\
&=\frac{L}{(n+1)!}(u+v) \cdot {\left(\frac{u+v}{\sqrt{u^2+v^2}}\right)}^n\\
\end{aligned}
$$

做一下直角座标道极座标的变换,有$r=\sqrt{u^2+v^2}\quad \exists \theta\in \left[0,\frac{\pi}{4}\right]\ u=r\sin \theta,v=r\cos\theta$

$$
\begin{aligned}
\frac{|R_n|}{{\left(\sqrt{h^2+k^2}\right)}^n}
&=\frac{Lr}{(n+1)!}(\cos\theta+\sin\theta) \cdot {\left(\frac{r(\cos\theta+\sin\theta)}{r}\right)}^n\\
&=\frac{Lr}{(n+1)!}(\cos\theta+\sin\theta) \cdot {(\cos\theta+\sin\theta)}^n\\
&=\frac{Lr}{(n+1)!}\sin^{n+1}(\theta+\frac{\pi}{4})\\
&\to 0\qquad (\text{when }r\to 0)
\end{aligned}
$$


于是二元函数的Taylor展开中的Lagrange余项,类似一元中的情况,是$O({\left[\sqrt{h^2+k^2}\right]}^n)$的,  

- 余项大小估计的结论可以类似地进行推广,得到$R^d\to R$的函数的Taylor展开,
给出差异被${||\Delta \vec x||}^{n}$控制的估计.
- 多元函数的taylor展开,也一样是有"唯一性"的,
即$f$在$\vec{x}_0$附近的一个$n$次多项式近似,
如果差异是$o({||\Delta \vec x||}^{n})$的,
那么这个多项式一定是$f$在该点的$n$阶泰勒多项式.
- 多元函数也可以有Taylor series.
- 这种形式,对其进行抽象,可以搞出多元形式幂级数.

## 多元函数积分学

> - 找换元,  
> 可以看被积函数的形式,尝试找可以化简它的参数方程,  
> 也可以看积分区域
>
> - 画图 / 固定某个量求截面 大致了解积分区域的信息.
>
> - 对称性化简

> - 记得乘上Determinant of the Jacobian matrix, 把$(x,y)$换为$(u,v)$就乘上$\mathrm{abs}\ \frac{\partial(x,y)}{\partial(u,v)}$  
>   可以写出explicit-form,然后求偏导计算行列式,也可以用逆映射定理,计算$\frac{\partial(u,v)}{\partial(x,y)}$取倒数并置换变量.

### 区域并非关于原点中心对称的极座标/球座标换元


$$
\int_{0}^{2}\int_{0}^{\sqrt{2x-x^2}}\sqrt{x^2+y^2}\mathrm{d}x\mathrm{d}y
$$

积分区域即$0\leq x\leq 2\land 0\leq y\leq \sqrt{2x-x^2}$,化个图发现是以$(1,0)$为圆心的圆盘在$x$轴上半部分的区域.  
改写为$x^2+y^2 = 2x$  

被积函数形式太差,极座标换元,确定参数范围.  
$x=r\cos \theta,y=r\sin\theta$  

- 画图,在图形上面找,固定了$\theta$后,作出一条原点开始的射线  
  $r$最大取到交出来的弦的弦长.  
  弦的两端和圆心连接,得到一个底角为$\theta$,腰长为$r$的等腰三角形, 于是弦长为$2r\cos \theta$
- 直接带入两个边界的方程, $x^2+y^2=2x\implies r^2=2r\cos \theta$于是夹一下范围得到$0\leq r\leq 2\cos\theta$

$$
\int_{0}^{\pi/2}\theta
\int_{0}^{2\cos\theta}
r\cdot r\mathrm{d}r
$$


## 曲线积分和曲面积分

> 奇怪的地方在于,$\mathrm{d}x \mathrm{d}y$为何换元之后不能直接把全微分展开,而需要手动补上$\frac{\partial (x,y)}{\partial (u,v)}$得到$\frac{\partial (x,y)}{\partial (u,v)}\mathrm{d}u \mathrm{d}v$  
> 但是$\mathrm{d}x\wedge \mathrm{d}y$直接带入$\mathrm{d}x=x_u\mathrm{d}u+x_v\mathrm{d}v,\ \mathrm{d}y=y_u\mathrm{d}u+y_v\mathrm{d}v$进行外积运算即可自然出现$\mathrm{d}x\wedge \mathrm{d}y=\frac{\partial (x,y)}{\partial (u,v)}\mathrm{d}u\wedge \mathrm{d}v$

### 曲面积分/曲线积分中的换元

> 这里仅仅是记录符号上的变换,用于辅助记忆,  
> 并非正确且完整的推导或证明.  
>
> 引入了微分形式(differential form)以便推导更自然.

以下推导的依据为.
- 逆映射定理(描述逆映射的存在性和可微性)  
  $\vec y=f(\vec x)$是可微且偏导连续的  
  在一点$\vec{x}_0$出,若$\begin{Vmatrix}J_f(x_0)\end{Vmatrix}\neq 0$  
  令$\vec y_0=f(\vec x_0)$则在$\vec y_0$的某个邻域内,存在局部逆映射$\vec y=g(\vec x)$,  
  并且$J_y(y)J_x(x)=I$.其中$I$为单位矩阵.  
- 链式法则/一阶微分形式不变性
- $$\vec y=F(\vec x)\implies \mathrm{d}y_1\wedge \mathrm{d}y_2\ldots \mathrm{d}y_n=\frac{\partial (y_1,y_2\ldots y_n)}{\partial (x_1,x_2\ldots x_n)}\mathrm{d}x_1\wedge \mathrm{d}x_2\ldots \mathrm{d}x_n$$

还可以推广到 _3-form,4-form_ 的积分,做法和结论是一致的.

#### $\mathbb{R}^3$中第一类曲线积分中的换元/座标系变换

已知$\vec r(t)=\left(x(t),y(t),z(t)\right)$为正则曲线$L$的参数化.  
引入参数$\theta$并$t=\varphi(\theta)$,
设$x(\varphi(\theta))=u(\theta), y(\varphi(\theta))=v(\theta), z(\varphi(\theta))=w(\theta)$  
和$f(x(t),y(t),z(t))=g(t)=g(\varphi(\theta))=h(\theta)$,其中$h=g\circ \varphi$  
则有

$$
\begin{aligned}
\int_L f(\vec r)\mathrm ds
&=\int_a^b f(x,y,z)
\left\vert \left\vert
\overrightarrow{r'}(t)
\right\vert \right\vert
  \mathrm{d}t \\
&=\int_a^b f(x(t),y(t),z(t))
  \sqrt{
     {\left(\frac{\mathrm dx}{\mathrm dt}\right)}^2
    +{\left(\frac{\mathrm dy}{\mathrm dt}\right)}^2
    +{\left(\frac{\mathrm dz}{\mathrm dt}\right)}^2
  }
  \mathrm{d}t \\
&=\int_{\alpha}^{\beta} f( x(\varphi(\theta)), y(\varphi(\theta)), z(\varphi(\theta)))
  \sqrt{
     {\left(\frac{\mathrm dx}{\mathrm dt}\right)}^2
    +{\left(\frac{\mathrm dy}{\mathrm dt}\right)}^2
    +{\left(\frac{\mathrm dz}{\mathrm dt}\right)}^2
  }\varphi'(\theta)\mathrm{d}\theta\\
&=\int_{\alpha}^{\beta} h(\theta)
  \sqrt{
    {\left(x'(t)\varphi'(\theta)\right)}^2
    +{\left(y'(t)\varphi'(\theta)\right)}^2
    +{\left(z'(t)\varphi'(\theta)\right)}^2
  }\mathrm{d}\theta\\
&=\int_{\alpha}^{\beta} h(\theta)
  \sqrt{
    {\left( u'(\theta) \right)}^2
    +{\left( v'(\theta) \right)}^2
    +{\left( w'(\theta) \right)}^2
  }\mathrm{d}\theta\\
\end{aligned}
$$


可以看到,如我们所预期的那样,  
对被积函数重新参数化,对方程重新参数化,之后一切自然.  
说明第一类曲线积分的结果与选取的参数化方式无关.


#### $\mathbb{R}^3$中第一类曲面积分中的换元/座标系变换


已知一个(简单+正则)曲面$S$的一种表示  
$\vec r(u,v)={\left(x(u,v),y(u,v),z(u,v)\right)}^{T}$其中$(u,v)$取遍$D$, $D$为一${\mathbb{R}}^2$的子集.  
和定义在其上的函数$f(\vec r)=f(x,y,z)$.  

则有第一类曲面积分

$$
\begin{aligned}
\iint_{\vec r\in S}f(\vec r)\mathrm{d}S
&=\iint_{(u,v)\in D} f(x(u,v),y(u,v),z(u,v))
  \left\vert \left\vert
  \overrightarrow{r_u} \times \overrightarrow{r_v}
  \right\vert \right\vert\mathrm{d}u\mathrm{d}v\\
&=\iint_{D}f(x,y,z)
  \left\vert \left\vert
  \overrightarrow{r_u} \times \overrightarrow{r_v}
  \right\vert \right\vert
  \mathrm{d}u\mathrm{d}v\\
\end{aligned}
$$


进行变换$u=u(p,q),v=v(p,q)$引入新的参数$p,q$,其中$(p,q)\in \Delta$  
并且设$\vec d(p,q)=\vec r(u(p,q),v(p,q))$,  
考察面积元

$$
\mathrm{d}S=\left\vert \left\vert
\overrightarrow{r_u}\times \overrightarrow{r_v}
\right\vert \right\vert
\mathrm{d}u \mathrm{d}v
$$

的变化,有.

$$
\begin{aligned}
\overrightarrow{r_u}
&=\dfrac{\partial \vec r(u,v)}{\partial u}
=\dfrac{\partial \vec d(p,q)}{\partial u}\\
&=\dfrac{\partial \vec d(p,q)}{\partial p}\frac{\partial p}{\partial u}
 +\dfrac{\partial \vec d(p,q)}{\partial q}\frac{\partial q}{\partial u}
\\
\overrightarrow{r_v}
&=\dfrac{\partial \vec d(p,q)}{\partial p}\frac{\partial p}{\partial v}
 +\dfrac{\partial \vec d(p,q)}{\partial q}\frac{\partial q}{\partial v}
\\
\mathrm{d}S
&=\left\vert \left\vert
  \overrightarrow{r_u}
  \times
  \overrightarrow{r_v}
  \right\vert \right\vert
  \mathrm{d}u\mathrm{d}v\\
&=\left\vert \left\vert
    (\vec d_p p_u+ \vec d_q q_u)
    \times
    (\vec d_p p_v+ \vec d_q q_v)
  \right\vert \right\vert
  \frac{\partial (u,v)}{\partial (p,q)}
  \mathrm{d}p\mathrm{d}q\\
&=\left\vert \left\vert
   p_u q_v \vec d_p\times \vec d_q
  +q_u p_v \vec d_q\times \vec d_p
  \right\vert \right\vert
  \frac{\partial (u,v)}{\partial (p,q)}
  \mathrm{d}p\mathrm{d}q\\
&=\left\vert \left\vert
   \vec d_p\times \vec d_q
  \right\vert \right\vert
  (p_u q_v-q_u p_v)
  \frac{\partial (u,v)}{\partial (p,q)}
  \mathrm{d}p\mathrm{d}q\\
&=\left\vert \left\vert
   \vec d_p\times \vec d_q
  \right\vert \right\vert
  \frac{\partial (p,q)}{\partial (u,v)}
  \frac{\partial (u,v)}{\partial (p,q)}
  \mathrm{d}p\mathrm{d}q\\
&=\left\vert \left\vert
   \vec d_p\times \vec d_q
  \right\vert \right\vert
  \mathrm{d}p\mathrm{d}q\\
\end{aligned}
$$

于是返回曲面积分,

$$
\begin{aligned}
\iint_S f(\vec r)\mathrm{d}S
&=
\iint_D f(\vec r(u,v))
\left\vert \left\vert
\overrightarrow{r_u}\times \overrightarrow{r_v}
\right\vert \right\vert
\mathrm{d}u \mathrm{d}v\\
&=\iint_{\Delta}f(\vec d(p,q))
\left\vert \left\vert
\overrightarrow{d_u}\times \overrightarrow{d_v}
\right\vert \right\vert
\mathrm{d}p \mathrm{d}q\\
\end{aligned}
$$

如预期的那样,第一类曲面积分和参数选取是无关的.  


## Fourier分析

## 广义积分和参变量的积分


## MISC

### Cantor's intersection theorem

> Given a sequence of compact,non-empty,cloesd set $S_0\supset S_1\supset S_2\ldots \text{ s.t. } \lim_{n\to \infty} \mathrm{diam}(S_n)=0$  
> Show that $\cap_{n=0}^{\infty} S_n=\{x\}$
>
> where
> $$\mathrm{diam}(S)=\sup_{\vec{x}_0,\vec{x}_1\in S} \begin{Vmatrix}\vec{x}_0-\vec{x}_1 \end{Vmatrix}$$


Let $T_k=S_{k+1}\setminus S_k\text{ and }T=\{T_0,T_1\ldots\}$.  
By axiom-of-choice, we can select a series $a_n=\{a_0,a_1\ldots\}\text{ s.t. }\forall n\ a_n\in T_n,a_n\in S_{k+1}$  
We can see that $i\neq j\implies T_i\cap T_j=\emptyset$. Thus $a_i\neq a_j$   

Consider the convergency of $\{a_n\}$.

Since $\mathrm{diam}(S_n)\to 0$, $\forall \epsilon>0\ \exists N\text{ s.t. }\forall n>N\ \mathrm{diam}(S_n)<\epsilon$  
$\forall n>m>N\quad ||a_n-a_m||\leq \mathrm{diam}(S_{m+1})<\epsilon$.  
By Cauchy's theorem, the series converges. Let $x=\lim_{n\to \infty} a_i$


$\forall m,\text{let }b=\{a_m,a_{m+1},a_{m+2}\ldots \}\to x$ and $\forall i\geq m\  a_i\in S_m$. Since $S_m$ is a cloesd set and there is no duplicate elements in $b$, the limit $x$ is in $S_m$.  
Therefor $\forall m\ x\in S_m$, which is exactly $x\in \cap_{n=0}^{\infty} S_n$.  

Finally, we can prove that $x$ is the unique element in $\cap_{n=0}^{\infty} S_n$ by using $\mathrm{diam}(S_n)\to 0$ again.


> 要点
>
> - A.C.
> - 选点避免重复. 闭集对于这种不重复的序列,取极限后,极限仍然在该闭集中.



### 连续映射一定将闭集映射到闭集吗?

$S=\{(\frac{1}{n},n)\mid n\in \mathbb{N}^+\}$,和$f(x,y)=x$.  

- 考察$T=\overline{S}$,显然有$\partial T\cap T=0$即$T$开,故$S$闭.  
- 考虑$f$,这是个连续映射

但是$f(S)=\{\frac{1}{n}\mid n\in\mathbb{N}^+\}$它有一个聚点$0$是其本身的元素.  
这并非一个闭集. 


但可以强化条件: 有界开集在连续映射下一定得到闭集.




### 张江理工-数学分析2-Spring2021-midterm 某个题

> 定义在$D=\{(x,y)\in \mathbb{R}^2 \mid x^2+y^2\leq 4\}$上的可微函数$z=f(x,y)$,  
> 满足$\forall (x,y)\in D\ |f(x,y)|\leq 1$,求证, 存在一个$D$的内点$(x_0,y_0)$使得  
> $${\left(\frac{\partial z}{\partial x}(x_0,y_0)\right)}^2+{\left( \frac{\partial z}{\partial y}(x_0,y_0) \right)}^2 < 1$$


#### 直观的做法

这个$f_x^2+f_y^2$是$\nabla (f_x,f_y)$的模的平方.
假设原命题不成立, 有$\forall x_0\in D^0\ ||\nabla f(x_0)||\geq 1$, 看到这种东西,应该是要做梯度下降.  

找一条跟着梯度方向走的连续曲线$L$, 两端的函数值之差就是$\int_L \nabla f\cdot \mathrm{d}\vec r$,这里曲线切向量和$f$梯度平行,于是这噶改变量就是$\int_L ||\nabla f||\mathrm{d}s\geq |L|\cdot 1$  

然而$|L|$是不能容易地确定的.  
选定$L$的起点为$P$之后, 这条曲线就已经被梯度场确定了,
会有以下的情况.

- 我们可以一直沿着梯度方向走不离开$D$.  
  这是不可能的, 因为$f$有界, 不允许任意大的函数值差值.  
  $|f(B)-f(A)|\leq |1-(-1)|=2$
- 我们会走有限长度到达边界$\partial D$.  
  最快的情况是沿着$\overrightarrow{OP}$走出去, 长度为$2-|\overline{OP}|$

所以应该选从原点出发,最短可以走$2$长度,而最长也可以走$2$长度,  
所以$L$会是一条连接原点和区域边界上某点的线段.
并且两端函数值分别为$-1,+1$.
于是原点$(0,0)$是$f$的最值点, 又由于$f$在$(0,0)$可微的,于是$\mathrm d f(0,0)=0\mathrm{d} x+0\mathrm{d} y$  
于是得到原点处有$\nabla f=\vec 0$这和$||\nabla f||\geq 1$矛盾.  


#### 正经做法

考察$g(x,y)=f(x,y)-\frac{1}{4}(x^2+y^2)$

$$
\begin{aligned}
\frac{\partial g}{\partial x}
&=f_x-\frac{1}{2}x\\
\frac{\partial g}{\partial y}
&=f_y-\frac{1}{2}y
\end{aligned}
$$

如果在$D$内部,存在一个驻点$Q(x_0,y_0)$,有  
$f_x(x_0,y_0)=\frac{1}{2}x_0\ f_y(x_0,y_0)=\frac{1}{2}y_0$  
于是${(f_x)}^2+{(f_y)}^2=\frac{1}{4}(x_0^2+y_0^2) < 1$

1. 若原点处$g(0,0)=f(0,0)\geq 0$  
   边界上$g=f-1\leq 0$  
   最大值在内部取到, 可以找到内部驻点.
2. 若原点处$f(0,0)<0$  
   令$h(x,y)=f(x,y)+\frac{1}{4}(x^2+y^2)$  
   那么在边界上有$h=f+1\geq 0$  
   于是最小值在内部取到, 可以找到$h$的驻点,类似操作也可以说明.



### harmonic function

$$
\nabla\cdot (\nabla f)
=\sum_{i=1}^n \frac{\partial (\frac{\partial f}{\partial x_i})}{\partial x_i}
=\sum_{i=1}^n \frac{\partial^2 f}{\partial x_i^2}
$$

记它为Laplace算子(Laplacian)即$\Delta f=\nabla \cdot (\nabla f)$  
满足$\Delta f=0$的函数$f$称调和函数(harmonic function)


一个有用的性质

$$
\nabla \cdot (f\nabla f)
=\sum_{i=1}^n
  \frac{
    \partial \left(
    f\frac{\partial f}{\partial x_i}
    \right)
  }
  {\partial x_i}
=\sum_{i=1}^n \left(\frac{\partial f}{\partial x_i}\right)^2+f\left(\frac{\partial^2 f}{\partial x_i^2}\right)
$$

如果$f$是调和函数,那么后面一部分的和是$0$于是$\nabla \cdot (f\nabla f)=\sum_{i=1}^n \left(\frac{\partial f}{\partial x_i}\right)^2\geq 0$


#### zero flux property


#### mean value property


- 二维:  
  一点$P$处.取任意以$P$为圆心,$r$为半径的圆,记其正向(逆时针)为$L$.有:
  $$f(P)=\frac{1}{2\pi r}\oint_L f(x,y)\mathrm{d}s$$
- 三维:  
  一点$P$处.取任意以$P$为球心,$r$为半径的,记其正向(外侧)为$S$.有:
  $$f(P)=\frac{1}{4\pi r^2}\oiint_S f(x,y,z)\mathrm{d}S$$

> 事实上,均值性质和邻域的形状关系不是太大.  

reference: `https://web.math.ucsb.edu/~cmart07/Harmonic functions.pdf`

**TODO**: proof


这里以三维空间中的情况为例子说明.  

0. 平移$P$到原点
1. 极坐标(polar-coordinate)换元
2. 得到一个含有参数$r$的积分
3. 对$r$求导(验证积分的一致可积性)
4. 整理出  曲面法向量-点乘-函数梯度  的第一形曲面积分
5. 上一步中的式子中的曲面法向量与曲面积分面积微元结合, 改写为第二类曲面积分
6. 使用高斯定理(散度定理), 被积函数为梯度的散度, 对于调和函数来说,恒为零.
7. 表明积分是关于$r$是常函数
8. 第一积分中值定理,求解$r\to 0$时的积分结果.

换元

$$
\vec r={(x,y,z)}^T=\vec r(\theta,\varphi)=\begin{bmatrix}
r\sin\theta\cos\varphi
r\sin\theta\sin\varphi
r\cos\theta
\end{bmatrix}
$$

面积元

$$
\begin{aligned}
\mathrm{d}S
&=
\left\vert
\frac{\partial \vec r}{\partial \theta}
\times \frac{\partial \vec r}{\partial \theta}
\right\vert\\
&=
\left\vert
{\left(r \cos\left(\varphi\right) \cos\left(\theta\right),\,r \cos\left(\theta\right) \sin\left(\varphi\right),\,-r \sin\left(\theta\right)\right)}^T
\times 
{\left(-r \sin\left(\phi\right) \sin\left(\theta\right),\,r \cos\left(\phi\right) \sin\left(\theta\right),\,0\right)}^T
\right\vert\\
&=
\left\vert
{\left(r^{2} \cos\left(\phi\right) \sin\left(\theta\right)^{2},\,r^{2} \sin\left(\phi\right) \sin\left(\theta\right)^{2},\,r^{2} \cos\left(\phi\right)^{2} \cos\left(\theta\right) \sin\left(\theta\right) + r^{2} \cos\left(\theta\right) \sin\left(\phi\right)^{2} \sin\left(\theta\right)\right)}^T
\right\vert\\
&=\left\vert\begin{bmatrix}
r^{2} \cos\left(\phi\right) \sin\left(\theta\right)^{2}\\
r^{2} \sin\left(\phi\right) \sin\left(\theta\right)^{2}\\
r^{2} \cos\left(\phi\right)^{2} \cos\left(\theta\right) \sin\left(\theta\right) + r^{2} \cos\left(\theta\right) \sin\left(\phi\right)^{2} \sin\left(\theta\right)
\end{bmatrix}\right\vert\\
&=r^2\sin\theta
\end{aligned}
$$

含参变量积分求导.

$$
\begin{aligned}
g(r)
&=\frac{1}{4\pi r^2}\oiint_S f(x,y,z)\mathrm{d}S
  \quad (S=\{Q\in \mathbb{R}^3\mid |QR|=r\})\\
&=\frac{1}{4\pi r^2}\iint_{D}
  f(r\sin\theta\cos\varphi,r\sin\theta\sin\varphi,r\cos\theta) r^2\sin\theta\,
  \mathrm{d}\theta\mathrm{d}\varphi
  \quad (\theta,\varphi)\!\in\![0,\pi]\!\times\! [0,2\pi]\\
&=\frac{1}{4\pi} \iint_{D}
  f(r\sin\theta\cos\varphi,r\sin\theta\sin\varphi,r\cos\theta) \sin\theta\,
  \mathrm{d}\theta\mathrm{d}\varphi\\
g^\prime(r)
&=\frac{1}{4\pi}\iint_{D}
  \frac
  {\partial f(r\sin\theta\cos\varphi,r\sin\theta\sin\varphi,r\cos\theta)}
  {\partial r}
  \sin\theta \mathrm{d}\theta\mathrm{d}\varphi\\
g^\prime(r)
&=\frac{1}{4\pi}\iint_{D}
  \left(
     \sin\theta\cos\varphi f_x
    +\sin\theta\sin\varphi f_y
    +\cos\theta            f_z
  \right)
  \sin\theta \mathrm{d}\theta\mathrm{d}\varphi\\
g^\prime(r)
&=\frac{1}{4\pi}\iint_{D}
  \left(
  f_x,
  f_y,
  f_z
  \right)
  \cdot
  \left(
  \sin^2\theta \cos\varphi,
  \sin^2\theta \sin\varphi,
  \sin\theta\cos\theta
  \right)
  \mathrm{d}\theta\mathrm{d}\varphi\\
&=\frac{1}{4\pi}\iint_{D}
\nabla f\cdot \mathrm{d}{\vec S}\\
&=\frac{1}{4\pi}\iiint_V\nabla\cdot(\nabla f)\,\mathrm{d}V=0
\end{aligned}
$$

最后求极限

任意取允许误差$\forall \epsilon>0$,  
由$f$连续性,$\exists R_\epsilon>0\ \forall 0\leq r < R_\epsilon$  
满足下面的估计

$$
\begin{aligned}
&\frac{1}{4\pi r^2}4\pi r^2 (f(P)-\epsilon)
\leq \frac{1}{4\pi r^2} \oiint_S f\mathrm{d}S
\leq \frac{1}{4\pi r^2}4\pi r^2 (f(P)+\epsilon)\\
&f(P)-\epsilon \leq \frac{1}{4\pi r^2} \oiint_S f\mathrm{d}S \leq f(P)+\epsilon
\end{aligned}
$$

于是$\lim_{r\to 0^+}g(r)=f(P)$  
综合上面的$g'(r)=0$就有$g(r)\equiv f(P)$了.


