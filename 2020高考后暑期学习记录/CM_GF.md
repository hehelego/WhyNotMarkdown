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





