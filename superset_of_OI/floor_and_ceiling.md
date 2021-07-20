## floor and ceiling


$$
\begin{aligned}
&\left\lceil\frac{a}{b}\right\rceil=\left\lfloor\frac{a+b-1}{b}\right\rfloor\\
&\left\lfloor\frac{a}{b}\right\rfloor=\left\lceil\frac{a-b+1}{b}\right\rceil\\
\end{aligned}
$$


考虑$a\equiv r\pmod{b}\quad q=\lfloor\frac{a}{b}\rfloor$.  
- $r=0$时,ceil和floor都是$q$
- $0 < r < b$时,ceil是$q+1$而floor是$q$





考虑证明. 对于$a\bmod b$分类讨论即可,这里以第一个式子为例子.

- $a=kb+0$时,外加的$b-1$不会使得quotient增加,reminder对于floor没有影响. 结果为$k$,正确.
- $a=kb+1,kb+2,kb+3\dots kb+(b-1)$时,附加$b-1$使得quotient增加$1$,而reminder的改变不影响. 结果为$k+1$,正确.