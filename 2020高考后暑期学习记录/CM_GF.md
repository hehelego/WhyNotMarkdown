# 具体数学 学习笔记 生成函数



## 简单例子

### 自然数平方和

$$
\begin{aligned}
&G(x)=\sum_{i=0}^n x^i=\frac{1-x^{n+1}}{1-x}\\
&G'(x)=\sum_{i=1}^n ix^{i-1}=\text{?}\\
&G'(1)=\sum_{i=1}^n i\\
&G''(x)=\sum_{i=2}^n i(i-1)x^{i-2}=\text{?}"\\
&G''(1)=\sum_{i=2}^ni(i-1)=\sum_{i=2}^n(i^2-i)\\
&G'(1)+G''(1)=1+\sum_{i=2}^ni^2=\sum_{i=1}^n i^2
\end{aligned}
$$

但是这里有些小问题$G'(x),G''(x)$在$x=1$处没有定义,好在它的极限是存在的.
我们用sagemath计算$\lim_{x\to 1}(G'(x)+G''(x))=\frac13 n^3+\frac12 n^2+\frac16 n^1$



### 自然数幂和的EGF

$$
\begin{aligned}
&e^{kx}=\sum_{0\leq n}\frac{k^n}{n!}x^n\\
&F(x)=\sum_{i=1}^n e^{ix}=\sum_{0\leq i}\frac{x^i}{i!}\sum_{j=1}^n j^i=e^x\frac{1-e^{nx}}{1-e^x}	
\end{aligned}
$$







### 常见操作

$$
\begin{aligned}
&[x^k](\frac{1}{1-z})^n\\
&(x_1,x_2\dots x_n),x_i\geq 0\quad  \sum_{i=1}^n x_i=k\\
&(x_1,x_2\dots x_n),x_i\geq 1\quad  \sum_{i=1}^n x_i=k+n\\
&\binom{n+k-1}{n-1}=\binom{n-k+1}{k}\\
&\implies \frac{1}{(1-z)^n}=\sum_{0\leq} \binom{n+k-1}{k}z^k
\end{aligned}
$$

$$
\begin{aligned}
&F(z)=\sum_{0\leq i} \frac{z^i}{i!}\\
&F'(z)=\sum_{1\leq i} \frac{i}{i!}z^{i-1}=\sum_{1\leq i}\frac{z^{i-1}}{(i-1)!}=\sum_{0\leq i}\frac{z^i}{i!}\\
&\implies F(z)=F'(z),F(0)=1\\
&\implies F(z)=e^z
\end{aligned}
$$


$$
\begin{aligned}
&F(z)=\sum_{1\leq i}\frac{z^i}{i}\\
&F'(z)=\sum_{1\leq i}z^{i-1}=\sum_{0\leq i}z^i=\frac{1}{1-z}\\
&\implies F(0)=0,F'(z)=\frac{1}{1-z}\\
&F(z)=\int\frac{1}{1-z}\mathrm{d}z\\
&\text{let t}=1-z,\mathrm{d}t=-\mathrm{z}\\
&F(t)=-\int\frac{1}{t}\mathrm{d}t=-\ln t+C\\
&F(z)=-\ln(1-z)+C=\ln\frac{1}{1-z}+C\\
&F(0)=C+\ln 1=0\implies C=0\\
&\implies F(z)=\ln\frac{1}{1-z}
\end{aligned}
$$








----------------------

## exercises

### warm up



### basic



### homework



### exam





