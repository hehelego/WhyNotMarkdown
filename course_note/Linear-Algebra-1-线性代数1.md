# linear algebra

> - 这是我在2020年在张江理工修读`线性代数1`课程中的记录
> - 课程使用的教材是Howard Anton编写的Elementry Linear Algebra,以及北京大学版高等代数.  
> - 这门课程并不完整.还有线性代数2,会有更高层次的抽象以及无穷维线性空间的内容.  
>   由于我是CS学生而不是数学院的本科生,所以课程内容深度不会很大,广度也不是很足.

[TOC]

## Equivalent Statements

for a $n\times n$ square matrix $A$. the following equations

- $A$ is invertible($\iff$ A is left invertible $\iff$ A is right invertible)
- $A\vec{x}=\vec{0}$ has only the trivial solution($\vec x=\vec 0$)
- the reduced echelon form of A is $I_n$
- A can be expressed by product of some elementary matrices
- $\forall \vec{b},\ A\vec{x}=\vec{b}$ is consistent
- $\forall \vec{b},\ A\vec{x}=\vec{b}$ has unique solution
- $\det(A) \neq 0$
- row(column) vectors of $A$ are linearly independent
- $\lambda=0$ is not a eigenvalue of $A$, $p(\lambda)=\det(\lambda I-A),p(0)=\det(-A)={(-1)}^n \det(A)\neq 0$

## elimination & determinant & inversion

### 1

$$
\begin{aligned}
&\begin{array}{c:c}
\begin{pmatrix}
1&2&3&4&\dots &n\\
&1&2&3&\dots &n-1\\
&&1&2&\dots &n-2\\
\vdots&\vdots&\vdots&\vdots&\vdots&\vdots&\\
&&&&&1
\end{pmatrix}
&
\begin{pmatrix}
1\\
&1\\
&&1\\
&&&\dots\\
&&&&1\\
\end{pmatrix}
\end{array}\\
\implies&\begin{array}{c:c}
\begin{pmatrix}
1&1&1&1&\dots &1\\
&1&1&1&\dots &1\\
&&1&1&\dots &1\\
\vdots&\vdots&\vdots&\vdots&\vdots&\vdots&\\
&&&&&1
\end{pmatrix}
&
\begin{pmatrix}
1&-1\\
&1&-1\\
&&1&-1\\
&&&\dots\\
&&&&1\\
\end{pmatrix}
\end{array}\\
\newline
\implies &\begin{array}{c:c}
\begin{pmatrix}
1&0&0&0&\dots &0\\
&1&0&0&\dots &0\\
&&1&0&\dots &0\\
\vdots&\vdots&\vdots&\vdots&\vdots&\vdots&\\
&&&&&1
\end{pmatrix}
&
\begin{pmatrix}
1&-2&1\\
&1&-2&1\\
&&1&-2&1\\
&&&\dots\\
&&&&1\\
\end{pmatrix}
\end{array}\\
\end{aligned}
$$

### 2

$$
\begin{aligned}
&\det\begin{pmatrix}
a&b&b&b&b\\
b&a&b&b&b\\
b&b&a&b&b\\
b&b&b&a&b\\
b&b&b&b&a
\end{pmatrix}\\
&\det\begin{pmatrix}
a+4b&a+4b&a+4b&a+4b&a+4b\\
b&a&b&b&b\\
b&b&a&b&b\\
b&b&b&a&b\\
b&b&b&b&a
\end{pmatrix}\\
&(a+4b)\det\begin{pmatrix}
1&1&1&1&1\\
b&a&b&b&b\\
b&b&a&b&b\\
b&b&b&a&b\\
b&b&b&b&a
\end{pmatrix}\\
&(a+4b)\det\begin{pmatrix}
1&1&1&1&1\\
0&a-b&0&0&0\\
0&0&a-b&0&0\\
0&0&0&a-b&0\\
0&0&0&b&a-b
\end{pmatrix}\\
\end{aligned}
$$

### 3

$$
\begin{aligned}
&\det\begin{pmatrix}
1&1&1&1&1\\
1&1\\
1&&1\\
1&&&1\\
1&&&&1
\end{pmatrix}\\
&\det\begin{pmatrix}
-3&1&1&1&1\\
0&1\\
0&&1\\
0&&&1\\
0&&&&1
\end{pmatrix}\\
&\det\begin{pmatrix}
-3&0&0&0&0\\
&1\\
&&1\\
&&&1\\
&&&&1
\end{pmatrix}
\end{aligned}
$$

### 4

$$
\begin{aligned}
&D_n=\begin{pmatrix}
b&a\\
a&b&a\\
&a&b&a\\
&&a&b&a\\
&&\dots\\
&&&a&b&a\\
&&&&a&b
\end{pmatrix}\\
&\text{expand the first column}\\
&|D_n|=b\det\begin{pmatrix}
b&a\\
a&b&a\\
&a&b&a\\
&\dots\\
&&a&b&a\\
&&&a&b
\end{pmatrix}
-a\det\begin{pmatrix}
a&a\\
&b&a\\
&a&b&a\\
&\dots\\
&&a&b&a\\
&&&a&b
\end{pmatrix}\\
&|D_n|=b|D_{n-1}|-a^2\det\begin{pmatrix}
b&a\\
a&b&a\\
\dots\\
&a&b&a\\
&&a&b
\end{pmatrix}=b|D_{n-1}|-a^2|D_{n-2}|\\
\newline\\
&R_n=|D_n|\quad R_n=bR_{n-1}-a^2R_{n-2}\\
\end{aligned}
$$

### Vandermonde determinant

$$
\det\begin{pmatrix}
x_1^0 & x_2^0 & x_3^0&\dots& x_n^0\\
x_1^1 & x_2^1 & x_3^1&\dots& x_n^1\\
x_1^2 & x_2^2 & x_3^2&\dots& x_n^2\\
\vdots &\vdots & \vdots& \vdots &\vdots\\
x_1^n & x_2^n & x_3^n&\dots& x_n^n\\
\end{pmatrix}=\prod_{1\leq j< i\leq n}(x_i-x_j)
$$

## MISC

### 关于 $A\,adj(A)=\det(A) I$

对于任意方阵$A$,以及其代数余子式$C$,有$\sum_{k} a_{ik}C_{jk}=\begin{cases}\det(A)&(i=j)\\0&(i\neq j)\end{cases}$
$$
\begin{aligned}
&A=\begin{bmatrix}
    a_{11}&a_{12}&a_{13}&\dots &a_{1n}\\
    a_{21}&a_{22}&a_{23}&\dots &a_{2n}\\
    &&\dots \\
    a_{n1}&a_{n2}&a_{n3}&\dots &a_{nn}\\
\end{bmatrix}\\
&\text{its minors,cofactors } M_{ij},C_{ij}=(-1)^{i+j}M_{ij}\\
&\det(A)=\sum_{i} a_{ki}C_{ki}=\sum_{i} a_{ik}C_{ik}\\
\newline
&A^{\prime}=\text{(change the i-th row to the j-th row)}\\
&\text{expand along the j-th row}\\
&\det(A')=\sum_{k} (A^{\prime})_{jk}C_{jk}=\sum_{k} a_{ik}C_{jk}=0\\
\end{aligned}
$$

### 三角不等式

$$
\begin{aligned}
&|| \vec a+\vec b || \leq |\vec a|+|\vec b|\quad \text{(by Cauchy-Schwarz)}\\
&\newline\\
&|| \vec{a}-\vec{b}|| +|| \vec b || \geq ||(\vec{a}-\vec{b})+\vec{b}||=||\vec a||\\
&\iff || \vec a - \vec b ||  \geq ||\vec a|| - ||\vec b||\\
&\newline\\
&||\vec u-\vec x||+||\vec x-\vec v|| \geq ||(\vec u-\vec x)+(\vec x-\vec v)||=||\vec u-\vec v||
\end{aligned}
$$

> 补充,关于Cauchy-Schwarz inequality的proof  
>
> $$
> \begin{aligned}
> &\forall \vec a,\vec b \quad f(x)=||\, x\vec a-\vec b\,||\\
> &f(x)\geq 0,f^2(x)=|\vec a|^2\, x^2-2\vec a\cdot \vec b\, x+|\vec b|^2\geq 0\\
> \implies &|\vec a|^2 x^2+(-2\vec a\cdot \vec b) x+|\vec b|^2=0\quad \text{has no or only one solution,}\\
> &(-2\vec a\cdot \vec b)^2-4|\vec a|^2|\vec b|^2\leq 0\\
> \implies &(\vec a\cdot\vec b)\leq |\vec a|^2|\vec b|^2\implies \vec a\cdot \vec b\leq |\vec a||\vec b|
> \end{aligned}
> $$
>
> 当且仅当$\exists x,\vec b=x\vec a$时可以取等.

### 最小二乘法(least squares)

> $$A\in M_{m\times n}\quad \min_{\vec x\in \mathbb R^n} ||A\vec x-\vec b||$$
> 称为least square problem.解称为least squares solution.  
> 通常是$m\gg n$的情况

考虑$A\vec x$的意义,是$A$的列向量的线性组合.$\{A\vec x\mid x\in \mathbb R^n\}=span(\{\vec a_1,\vec a_2\dots \vec a_n\})$是一个$\mathbb R^m$的子空间(或者说,一个超平面).  
所以这个$||A\vec x-\vec b||$就是超平面上向量到$\vec b$的距离,取$\min$就是$\vec b$到平面的距离,我们要做投影.

我们考虑证明一下,做射影得到$x$使得目标函数被最小化.  
设$W=\text{column-space}(A)$  
投影之后得到$b=\mathrm{proj}_{W}(b)+\mathrm{proj}_{W\!\perp}(b)$.  

$$
\begin{aligned}
&\forall x\in W\quad b=x+(\mathrm{proj}_{W}(b)-x)+\mathrm{proj}_{W\!\perp}(b)\\
&b-x=(\mathrm{proj}_{W}(b)-x)+\mathrm{proj}_{W\!\perp}(b)\\
&\text{observation:}\quad \mathrm{proj}_{W}(b)-x\perp \mathrm{proj}_{W\!\perp}(b)\\
&||b-x||^2=||(\mathrm{proj}_{W}(b)-x)||^2+||\mathrm{proj}_{W\!\perp}(b)||^2
\geqslant ||\mathrm{proj}_{W\!\perp}(b)||^2
\end{aligned}
$$

### dim basis rank span

基本上是一回事...  
计算技巧上,利用高斯消元,$\det$相关结论

对于向量组$S$  

- 如果$S$是线性无关的,并且$v\not\in span(S)$那么$S+\{v\}$也是线性无关的.
- 如果$S$是线性相关的,$v\in S\land v\in span (S-\{v\})$那么$span(S-\{v\})=span(S)$.

这告诉我们$span(\{v_1,v_2\dots v_n\})$的basis可以有两个办法得到,第一种是不断加入不能被已有向量表示的新向量;另一种是不断从中删掉被其他向量表示的向量.

### PIE and dim

> if $U,V$ are subspace of finite-dimensional vector space $W$,  
> $U\cap V=\{v\in W\mid (v\in U)\land (v\in V)\}$and $U+V=\{x+y\mid x\in U,y\in V\}$  
> prove that $\dim(U+V)=\dim(U)+\dim(V)-\dim(U\cap V)$  

考虑$U\cap V$的basis,$S=\{v_1,v_2\dots v_n\}$,有$\dim(U\cap V)=n$.  
假设$S\cup A,S\cup B$分别是$U,V$的basis且$S\cap A=S\cap B=\phi$(即向S中添加向量,使得它张成U或者V).  

此时有$A\cap B=\phi$且$A\cup B\cup S$是$U+V$的basis.于是:  

$$
\begin{aligned}
&\dim(U+V)=|A\cup B\cup S|=|A|+|B|+|S|=\\
&\dim(U)-\dim(S)+\dim (V)-\dim (S)+\dim (S)=\dim(U)+\dim(V)-\dim(U\cap V)
\end{aligned}
$$

下面分别给出$A\cap B=\phi$和$A\cup B\cup S$是$V$的basis的证明.

- 如果$A\cap B=\{x_1,x_2\dots x_m\}\neq \phi$,那么$A\subset U,B\subset V$  
  故$(A\cap B)\subset (U\cap V)$即$x_i\in U\cap V$,因为$S$是$U\cap V$的basis,所以$x_i\in span(S)$于是$A\cup S$并非线性无关,  
  这与$A\cup S$是$U$的basis构成矛盾,故假设错误.
- 显然$span(A\cup S\cup B)=U+V$首先$(A\cup S\cup B)\subset U+V$于是$span(A\cup B\cup S)\subset U+V$,只需要证明$\forall y\in U+V,y\in span(A\cup S\cup B)$即可,  
  按照定义进行拆解$\exist u\in U,v\in V\ \text{ s.t. }\ u+v=y$有$u\in span(A\cup S)\to u\in span(A\cup S\cup B)$同理$v\in span(A\cup S\cup B)$.任意set of vectors的span都是个subspace,于是加法是封闭的,那么$u+v=y\in span(A\cup S\cup B)$.

这个性质还可以扩展$\dim(\sum W_i)\quad W_i\text{ is a subspace of }V$.

### change of basis

考虑$v=\sum_{i=1}^n x_i\vec{e_i}$其中$e$是standard basis.我们定义$v$的coordinate是$(x_1,x_2\dots x_n)$一个$n\times 1$的row vector.
这里记$(v)_{E}=(x_1,x_2\dots x_n)$即以$E$为basis意义下的coordinate.

假设$S=\{s_1,s_2\dots s_n\}$也是空间的basis,我们要求出$y=(v)_S=(y_1,y_2\dots y_n)$其中$v=\sum_{i=1}^n y_i\vec{s_i}$

$$
\begin{aligned}
&v=\begin{bmatrix}
x_1\\ x_2\\ \vdots\\ x_n \end{bmatrix}
=\begin{bmatrix}s_1&s_2&\dots &s_n\end{bmatrix}
\begin{bmatrix}y_1\\ y_2\\ \vdots\\ y_n\end{bmatrix}
\\
&\text{let }S=\begin{bmatrix}s_1&s_2&\dots &s_n\end{bmatrix}\\
&v=\vec{x}=S\vec{y}\implies y=S^{-1}x
\end{aligned}
$$

下面考虑change of basis,一个向量$x=(x_1,x_2\dots x_n)$分别在$A,B$表示为$a=(x)_A,b=(x)_B$.  
$$
\begin{aligned}
&x=A\ (x)\!_A=B\ (x)\!_B\\
&B^{-1}A\ (x)\!_A=B^{-1}B\ (x)\!_B\\
&(x)\!_B=B^{-1}A\ (x)\!_A
\end{aligned}
$$
称$B^{-1}A$为$P_{A\to B}$是A到B的transition matrix.  
简单一点的想法是向量$x$在$A$下表示为$y$,那么换到standard basis下面表示就是$Ay$. 一个standard matrix下的向量要转换到$B$为basis,那么就要左边乘一个$B^{-1}$于是就是$B^{-1}A\ y$了

### intersection of column space

> $$\mathrm{span}(v_1,v_2\dots v_n)=\mathrm{col}(\begin{bmatrix}v_1,v_2\dots v_n\end{bmatrix})$$

$$
\begin{aligned}
&A=\begin{bmatrix}a_1&a_2\dots &a_n\end{bmatrix}\quad B=\begin{bmatrix}b_1&b_2\dots &b_n\end{bmatrix}\\
&\mathrm{col}(A)\cap \mathrm{col}(B)\\
\newline\\
&x\in \mathrm{col}(A)\cap \mathrm{col}(B)\iff \exist y_1,y_2\text{ s.t. }x=Ay_1=By_2\\
&Ay_1-By_2=0\quad \begin{bmatrix}A\mid -B\end{bmatrix}\begin{bmatrix}y_1\\y_2\end{bmatrix}=0\\
\end{aligned}
$$

我们求出$\begin{bmatrix}A\mid -B\end{bmatrix}$的null space的basis,  
是一些$\mathbb{R}^{2n}$的vector,每个vector取前一半,再左乘上$A$,就是$\mathbb{col}(A)\cap \mathbb{col}(B)$的basis了.  

remark:  
$A\mid -B$和$A\mid B$的null space是类似的.  
对于一个vector space $V$的subspace $W$显然有$\{-w\mid w\in W\}=W$.  

### 正交分解定理

> Consider a inner product space $V$ and two vectors $\vec u,\vec x\in V$ where $u\neq 0$
> $\exist k \text{ s.t. }\vec x=k\vec u+\vec b \text{ where } (b, u)=0,\vec b\perp \vec u$

考虑把$x$投影到$u$上面去,这部分应该是$(\frac{u}{||u||},x)$

$$
\begin{aligned}
&k=\frac{(u,x)}{||\vec u||}\times \frac{1}{||u||}\\
&(x-ku,u)=(x,u)-k||u||^2=(u,x)-(u,x)=0\\
&b=x-ku
\end{aligned}
$$

更进一步地$k$是唯一的.  

$$
\begin{aligned}
&(x-ku,u)=0=(x,u)-k{||u||}^2\\
&k=\frac{(x,u)}{||u||^2}
\end{aligned}
$$

### 关于$W+W^\perp$

> Given that $W \text{ is a subspace of } V\quad \dim(V)=n$  
> Prove that $W+W^\perp=V$

首先是$W$为零空间$\{\vec 0\}$这是trivial的.  

Let $B=(u_1,u_2\dots u_m)$ be a basis of $W$.  

$$
\begin{aligned}
&A=\begin{bmatrix} u_1&u_2&u_3&\dots &u_m \end{bmatrix}\\
&0=Ax=A\begin{bmatrix} x_1\\x_2\\x_3\\\dots \\x_n \end{bmatrix}=
\begin{bmatrix}
u_1\cdot x\\
u_2\cdot x\\
u_3\cdot x\\
\vdots\\
u_m\cdot x\\
\end{bmatrix}\\
\end{aligned}
$$

So the null space of $A$ is the orthogonal completement of $W$.  

$rank(A)+nullity(A)=n$ where $rank(A)=rank(A^T)=m$ since the $m$ row vectors can form a basis, they are linearly independent.  

nullity of nullspace = dim of nullspace = dim of orthogonal completement.  
$\dim(W)+\dim(W^\perp)=n$, and $\dim(W\cap W^\perp)=\dim(\{\vec 0\})=0$ so.  

$$
\dim(W+W^\perp)=\dim(W)+\dim(W^\perp)-\dim(W\cap W^\perp)=n
$$

and $W+W^\perp\subseteq V$, so $V=W+W^\perp$

### 一个线性代数中的极为基础的问题

> For two $n\times n$ square real matrix $A,B$ such that $BA=I$,  
> Prove that $AB=I$  
> **remark: this is not true for non-square matrix**

#### intro

> 这里$V\to V$指domain(定义域=原象集合)为$V$,codomain(象集合)是$V$的子集.  
> 和常见$A\to B$表示$\text{domain}\subseteq A,\text{codomain}\subseteq B$有区别.  

我们不妨用从linear transform来定义matrix,  
$n\times n$ square matrix和$V\to V(\text{where }\dim(V)=n)$之间存在双射,乘法对应组合.  
设$A$对应的线性变换为$f_A$,有$\forall x\in V,f_x=Ax,Ax=f_x$以及$f_B\circ f_A=f_{BA}$.  

#### existence of right inverse

定义映射$f$的逆为一个映射$g$,满足$g\circ f=I$  
映射$f$可逆等价于$(x\neq y\to f\,x\neq f\, y)\land (\forall y\exists x(f\, x=y))$  

> 这个关于invertible 等价条件的论断我们稍后证明. ~~或者随便找本集合论的书就会有~~  

我们尝试说明$g\circ f=I\implies f\circ g=I$,尝试说明这个逆映射满足上面的两条约束.  

- 如果不满足第一条,即存在$x,y$虽然有$x\neq y$但是$g\, x=t=g\, y$  

设$x=f\,u,\ y=f\, v$显然$u\neq v$(否则$u=v\implies f\,u=f\, v\implies x=y$).  
而$t=g\, x=(g\circ f) u=u$另一方面$t=g\, y=(g\circ f)v=v$于是$u=v=t$,矛盾

- 如果不满足第二条,即$\exists y\forall x,\ g\,x\neq y$  

$f$满足$\forall y\exists x\text { s.t. }f\,x=y$. 设$f\, t=y$,那么$(g\circ f)t=g\, y=t$,矛盾

综上,$g$必须存在左逆,即$h\circ g=I$. 下面再证明$h=f$.  
这很简单$h\circ g\circ f=(h\circ g)\circ f=I\circ f=I$,另一方面$h\circ g\circ f=h\circ (g\circ f)=h\circ I=h$  

> 映射组合的结合律证明咕咕了...找本正经集合论书去吧.

到这里我们说明了,这种定义在整个空间$V$上的映射$f:V\to V$,满足$g\circ f=I\implies f\circ g=I$

#### conclusion

回到方阵上面来.  

已知$BA=I$即$f_B\circ f_A=f_{BA}=f_{I}=I$,  
根据上面的论证,有$f_A\circ f_B=I=f_{I}=f_{AB}$,  

于是$I=AB$,完成证明.

### 经典习题: rank(A+B) leq rank(A)+rank(B)

> given two $m\times n$ matrices $A,B$,  
> prove that $\mathrm{rank}(A+B)\leq \mathrm{rank}(A)+\mathrm{rank}(B)$

by definition $\mathrm{rank}(A)=\dim(R(A))=\dim(C(A))$, where $C(A),R(A)$ are row/column spaces of $A$ respectively.  
let $A=\begin{bmatrix}a_1&a_2&\ldots &  a_n\end{bmatrix},B=\begin{bmatrix}b_1&b_2&\ldots &  b_n\end{bmatrix}$, $C(A)=\mathrm{span}(a_1,a_2\ldots a_n)$

$$
\begin{aligned}
&\mathrm{span}(a_1+b_1,a_2+b_2\ldots a_n+b_n)=C(A+B)\\
&\mathrm{span}(a_1,a_2\ldots a_n,\, b_1,b_2\ldots b_n)=\mathrm{span}(a_1\ldots a_n)+\mathrm{span}(b_1\dots b_n)=C(A)+C(B)\\
\end{aligned}
$$

$$
\begin{aligned}
&\mathrm{span}(a_1+b_1,a_2+b_2\ldots a_n+b_n)\subseteq \mathrm{span}(a_1,a_2\ldots a_n,\, b_1,b_2\ldots b_n)\\
&\dim(\mathrm{span}(a_1+b_1,a_2+b_2\ldots a_n+b_n))\subseteq \dim(\mathrm{span}(a_1,a_2\ldots a_n,\, b_1,b_2\ldots b_n))\\
&\mathrm{rank}(A+B)\leq \dim(C(A)+C(B))=\dim(C(A))+\dim(C(B))-\dim(C(A)\cap C(B))\\
&\leq \mathrm{rank}(A)+\mathrm{rank}(B)-\dim(C(A)\cap C(B))\leq \mathrm{rank}(A)+\mathrm{rank}(B)\\
\end{aligned}
$$

remark: 简单来说,就是$\mathrm{span}\{a_i+b_i\}\subseteq \mathrm{span}\{a_i,b_i\}$加上$\dim(U+V)=\dim(U)+\dim(V)-\dim(U\cap V)$ **for finite dimensional vector space**

### transpose,hermitian and innerproduct

- real vector space: $\lang Ax,y\rang = y^T(Ax)= (A^T y)^T x = \lang x,A^T y\rang$
- complex vector space: $\lang Ax,y\rang =y^\dag (Ax)= (A^\dag y)^\dag x = \lang x,A^\dag y\rang$

where $A^\dag = \overline{A^T}={\overline A}^T$  

#### show that $rank(A^T A)=rank(A)$

$$
\begin{aligned}
Ax=0&\implies A^T Ax=A^T 0 =0\\
A^TA x=0&\implies x^T A^TAx =\lang Ax,Ax \rang=0\implies Ax=0
\end{aligned}
$$

#### real symmetric matrix has only real eigenvalues

> note that:
>
> - real symmetric:  $A=A^T=\overline A$
> - complex vector space standard inner product: $\lang x,y\rang=\sum x_i \overline{y_i}=x^T \overline y$
> - dot product($n\times 1$ column vector $x,y$) : $x^Ty=y^T x=\sum x_iy_i$

$$
\begin{aligned}
Ax&=\lambda x\\
{\overline x}^T (Ax)&={\bar x}^T (\lambda x)=\lambda {\overline x}^T x=\lambda \sum_{i=1}^n \overline {x_i}x_i=\lambda\sum ||x_i||^2=\lambda ||x||^2\\
\overline{{\overline x}^T Ax}&=\overline{ {\overline x}^T{\overline A}^Tx }=\overline{ (\overline{Ax})^T x }=\overline{ x^T(\overline{Ax}) }=\overline{x^T}(Ax)={\overline x}^TAx\\
\implies &\lambda ||x||^2={\overline x}^TAx\in \mathbb R\implies \lambda \in \mathbb R
\end{aligned}
$$

### rank-nullity theorem的经典证明

rank是极大无关行向量集合的大小,初等行变换不改变它,消元到RREF,leading ones所在的row vector就是一组row vecs的basis.  

另一个定理告诉我们某个列向量子集线性无关,那么任意进行行变换,这些列向量仍然线性无关(虽然行变换会改变列空间).于是包含leading varible的column对应的column vector线性无关,再原矩阵中找到这些行也是线性无关的. 两者都是count of leading varible于是row rank=column rank.  

nullity的话,是RREF中free varibles的数目,于是rank+nullity=count of column.  

### 关于rank-nullity theorem的一些思考

> given a linear transform $T:U\to V$, we define the that:  
>
> - $\mathrm{ker}(T)=\{v\mid T(v)=0\},\mathrm{im}(T)=\{T(v)\mid v\in U\}$ (image set也称为range)
> - $rank(T)=\dim(im(T)),nullity(T)=\dim(ker(T))$

考察$ker(T)$的basis如$(a_1,a_2\dots a_n)$,扩张到$(a_1\dots a_n,b_1\dots b_m)$为$U$的basis.  
显然有$b_i\not \in ker(T),T(b_i)\neq 0$.我们claim这个集合$(T(b_1),T(b_2)\dots T(b_m))$是$im(T)$的basis.  

首先它肯定是image set的subset.之后$\forall v\in im(T),\exists u\in U,T(u)=v$.即$v$的原像,由于$(a\dots,b\dots )$是$U$的basis,所以可以用它们线性组合出$u$来,设$u=\sum_i x_i a_i+\sum_j y_jb_j$线性性$f(u)=\sum_i x_if(a_i)+\sum_j y_jf(b_j)=0+\sum_j y_jf(b_j)$所以$v\in span(b_1,\dots b_m)$  

这样我们就证明了非常重要的rank-nullity theorem.

再来几个rank-nullity的题目.  

#### 来源不明的作业题

> given a linear operator $\varphi(x):V\to V$,  
> $$\dim\left(\ker(\varphi^{n+1})\right)=\sum_{k=0}^n \dim\left(\mathrm{im}\left(\varphi^{k}\right)\cap \ker(\varphi)\right)$$

这个技巧很常见,对于$f\circ g$,我们考察$h:\mathrm{im}(g)\to \mathrm{im}(f\circ g),h(x)=f(x)$  

考察$f:\mathrm{im}\left(\varphi^k\right)\to \mathrm{im}\left(\varphi^{k+1}\right),f(x)=\varphi(x)$.  
考虑一下$\ker(f)$,显然是$\ker(\varphi)\cap \mathrm{im}\left(\varphi^k\right)$

使用RN theorem有.  

$$
\dim\left(\mathrm{im}\left(\varphi^k\right)\right)=
\dim\left(\mathrm{im}\left(\varphi^{k+1}\right)\right)
+\dim\left(\ker(\varphi)\cap \mathrm{im}\left(\varphi^k\right)\right)
$$

我们两边对$k=0,1,2\dots n$求和,得到.

$$
\begin{aligned}
\dim\left(\mathrm{im}\left(\varphi^0\right)\right)-
\dim\left(\mathrm{im}\left(\varphi^{n+1}\right)\right)
=\sum_{k=0}^n \dim\left(\ker(\varphi)\cap \mathrm{im}\left(\varphi^k\right)\right)
\end{aligned}
$$

左边再用一次rank-nullity theorem,它是$f:V\to\mathrm{im}\left(\varphi^{n+1}\right),f(x)=\varphi^{n+1}(x)$的nullity,即$\dim\left(\ker\left(\varphi^{n+1}\right)\right)$.这样就昨晚了.

#### Sylvester's rank inequality

> given matrix $A_{n\times m},B_{m\times p}$, prove that  
> $$\mathrm{rank}(A)+\mathrm{rank}(B)\leq \mathrm{rank}(AB)+m$$

首先翻译成linear transform的语言.  

> given linear transform $f:V\to W,g:U\to V$, prove that  
> $$\dim(\mathrm{im}(f))+\dim(\mathrm{im}(g))\leq \dim(\mathrm{im}(f\circ g))+\dim(V)$$

还是上面的套路,考虑复合的中间过程.  
Let $h:\mathrm{im}(g)\to \mathrm{im}(f\circ g) \text{, where } h(x)=f(x)$  
$h(x)=0\implies x\in \ker(f)$ combined with the domain $\mathrm{im}(g)$,  
we can show that $h(x)=0\iff x\in\ker(f)\cap\mathrm{im}(g)$

rank-nullity theorem: $\dim\left(\mathrm{im}(g)\right)=\dim\left(\mathrm{im}(f\circ g)\right)+\dim\left(\ker(f)\cap \mathrm{im}(g)\right)$

$$
\begin{aligned}
&\dim(\mathrm{im}(f))+\dim(\mathrm{im}(g))-\dim(\mathrm{im}(f\circ g))\\
=&\dim(\mathrm{im}(f))+\dim\left(\ker(f)\cap \mathrm{im}(g)\right)\\
\leqslant& \dim(\mathrm{im}(f))+\dim\left(\ker(f)\right)
=\dim(V)
\end{aligned}
$$

#### Frobenius's inequality

> $$\mathrm{rank}(AB)+\mathrm{rank}(BC)\leq \mathrm{rank}(B)+\mathrm{rank}(ABC)$$

Let $f,g,h$ be the linear transform corresponding to $A,B,C$ i.e. $f(x)=Ax,g(x)=Bx,h(x)=Cx$  
$$\mathrm{rank}(f\circ g)+\mathrm{rank}(g\circ h)\leq \mathrm{rank}(g)+\mathrm{rank}(f\circ g\circ h)$$

Let $u:\mathrm{im}(g)\to \mathrm{im}(f\circ g)\quad u(x)=f(x)$. Notice that $u(x)=0\iff x\in \mathrm{im}(g)\cap \ker(f)$  
$$\dim\left(\mathrm{im}(g)\right)=\dim\left(\mathrm{im}(f\circ g)\right)+\dim\left(\mathrm{im}(g)\cap \ker(f)\right)$$

Let $v:\mathrm{im}(h)\to \mathrm{im}(g\circ h)\quad v(x)=g(x)$. Notice that $v(x)=0\iff x\in \mathrm{im}(h)\cap \ker(g)$  
$$\dim\left(\mathrm{im}(h)\right)=\dim\left(\mathrm{im}(g\circ h)\right)+\dim\left(\mathrm{im}(h)\cap \ker(g)\right)$$

Let $w:\mathrm{im}(g\circ h)\to \mathrm{im}(f\circ g\circ h)\quad w(x)=f(x)$  
$$\dim\left(\mathrm{im}(g\circ h)\right)=\dim\left(\mathrm{im}(f\circ g\circ h)\right)+\dim\left(\mathrm{im}(g\circ h)\cap \ker(f)\right)$$

Therefore

$$
\begin{aligned}
&\begin{array}{llll}
\mathrm{rank}(g\circ h)-\mathrm{rank}(f\circ g\circ h)
&=\dim\left(\mathrm{im}(g\circ h)\right)-\dim\left(\mathrm{im}(f\circ g\circ h)\right)
&=\dim\left(\mathrm{im}(g\circ h)\cap \ker(f)\right)
\\
\mathrm{rank}(g)-\mathrm{rank}(f\circ g)
&=\dim\left(\mathrm{im}(g)\right)-\dim\left(\mathrm{im}(f\circ g)\right)
&=\dim\left(\mathrm{im}(g)\cap \ker(f)\right)
\end{array}
\\
&\begin{array}{lll}
&\mathrm{rank}(g\circ h)-\mathrm{rank}(f\circ g\circ h)
&\leq
\mathrm{rank}(g)-\mathrm{rank}(f\circ g)\\
&\mathrm{rank}(f\circ g)+\mathrm{rank}(g\circ h)&\leq \mathrm{rank}(g)+\mathrm{rank}(f\circ g\circ h)\\
&\mathrm{rank}(AB)+\mathrm{rank}(BC)&\leq \mathrm{rank}(B)+\mathrm{rank}(ABC)\\
\end{array}
\end{aligned}
$$

### 张江理工 线性代数1-2020fall-finalexam题

> given two $n\times n$ matrix $A,B$ such that,  
> $A^{2020}=0\quad AB=BA\quad B\neq 0$,  
> show that $\mathrm{rank}(AB)\leq \mathrm{rank}(B)-1$ (or equivalently $r(AB)< r(B)$

如果$\mathrm{rank}(B)=\mathrm{rank}(AB)=\mathrm{rank}(BA)$,  
于是$C(BA)\subseteq C(B)\land \dim(C(BA))=\dim(C(B))$故$C(BA)=C(B)$.  

为了同时用上交换性和$A^{2020}=0$,我们考察$A^{2020}B$有.  
$A^{k}B=A^{k-1}(AB)=A^{k-1}(BA)$
在$C(B)$和$C(BA)$上面做$A^{k-1}$得到的空间是一样的.于是  
$C(A^{k} B)=C(A^{k-1}BA)=C(A^{k-1}B)$,  
这个推导与$k$无关,于是可以一直重复,得到$C(A^k B)=C(A^{k-1}B)=C(A^{k-2} B)\dots =C(B)$

考察$C(A^{2020}B)$有,$C(B)=C(A^{2020}B)=C(0B)=C(0)=\{\vec 0\}$  
而$B\neq 0$,矛盾. 故假设错误,应当有$rank(AB) < rank(B)$.

### square root of positive linear operator

> For all positive-definite real-symmetric matrices $A$, there is a matrix $P$ s.t. $A=P P^T$

By real real-spectral theorem, there is a othogonormal matrix $Q$ s.t. $Q^T A Q = \mathrm{diag}(\lambda_1,\lambda_2\ldots \lambda_n)$ where $\lambda_k$ are eigenvalues of $A$ counted with multiplicity.  
$A=Q D Q^T=P P^T$, so $P=Q\mathrm{diag}(\sqrt{\lambda_1},\sqrt{\lambda_2}\ldots \sqrt{\lambda_n})$.  
$A$ is a positive definite one, so the eigenvalues of $A$ are positive, therefore $P$ is a real-invertible matrix.

#### 例题

> 给定两个正定二次型的矩阵$A,B$, 证明
> $$\ln \left|\frac{A+B}{2}\right|\geqslant \frac{\ln|A|+\ln|B|}{2}$$
> 其中$|M|=\det(M)$

设$A=P^T P$,令$Q=P^{-1}$有$Q^T A Q=I_n$有  
考察$Q^T B Q$, 仍然是正定二次型对应的矩阵, 由谱定理, 它可以被某正交矩阵$R$正交对角化.  
即$R^T (Q^T B Q) R = {(QR)}^T B {(QR)}= \mathrm{diag}(d_1,d_2\ldots d_n)$ 其中$d_i$是$Q^T B Q$的特征值.  
同时有${(QR)}^T A {(QR)}=I_n$, 以及${(QR)}^T (A+B) {(QR)}=\mathrm{diag}(d_1+1,d_2+1\ldots d_n+1)$

于是有
$$
\begin{aligned}
|A|
&=\frac{1}{\sqrt{|QR|}}=\frac{1}{\sqrt{|Q|}}\\
|B|
&=\frac{\prod_i d_i}{\sqrt{|QR|}}=\frac{\prod_i d_i}{\sqrt{|Q|}}\\
\left|\frac{A+B}{2}\right|
&=\frac{1}{2^n}\frac{\prod_i (d_i+1)}{\sqrt{|QR|}}=\frac{\prod_i (d_i+1)}{2^n\sqrt{|Q|}}\\
\ln \left|\frac{A+B}{2}\right|
&=-\frac{1}{2}\ln|Q|+\sum_i \ln \frac{d_i+1}{2}\\
\frac{\ln |A|+\ln |B|}{2}
&=\frac{1}{2}\left(
-\frac{1}{2}\ln |Q|-\frac{1}{2}\ln |Q|+\sum_i \ln d_i
\right)\\
&=-\frac{1}{2}\ln |Q|+\frac{1}{2}\sum_i \ln d_i\\
\ln \frac{d_i+1}{2}&\geqslant\frac{\ln 1+\ln d_i}{2}=\frac{1}{2}\ln d_i\\
\ln \left|\frac{A+B}{2}\right|
&\geqslant - \frac{1}{2}\ln |Q|+\frac{1}{2}\sum_i \ln d_i=\ln |A|+\ln |B|
\end{aligned}
$$

