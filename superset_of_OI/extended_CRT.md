# 扩展中国剩余定理: 使用exgcd合并线性同余方程

## derivation

$$
\begin{aligned}
&\begin{cases}
x\equiv a_1\pmod {b_1}\\
x\equiv a_2\pmod {b_2}
\end{cases}\\
&x=a_1-k_1b_1=a_2+k_2b_2\\
&a_1-a_2=k_1b_1+k_2b_2\\
&\frac{a_1-a_2}{(b_1,b_2)}=\frac{b_1}{(b_1,b_2)}k_1+\frac{b_2}{(b_1,b_2)}k_2\\
&A=B_1k_1+B_2k_2\quad(A=\frac{a_1-a_2}{(b_1,b_2)},B=\frac{b}{(b_1,b_2)},\ \gcd(B_1,B_2)=1)\\
&\text{exgcd}\to 1=B_1 k'_{10}+B_2 k'_{20}\to 1=B_1 k'_{1}+B_2 k'_{2}\\
&\begin{cases}
k_1'=k'_{10}+B_2t\\
k_2'=k'_{20}-B_1t
\end{cases}\quad \to \quad
\begin{cases}
k_1=Ak'_{10}+B_2t\\
k_2=Ak'_{20}-B_1t
\end{cases}\\
\implies x&=a_1-k_1b_1=a_1-b_1(\frac{a_1-a_2}{(b_1,b_2)}k'_{10}+\frac{b_2}{(b_1,b_2)}t)\\ &=a_1-\frac{a_1-a_2}{(b_1,b_2)}b_1k'_{10}-\frac{b_1b_2}{(b_1,b_2)}t\\
\implies x&\equiv a_1+\frac{a_2-a_1}{(b_1,b_2)}b_1k'_{10}\pmod {\frac{b_1b_2}{(b_1,b_2)}}\quad [b_1,b_2](b_1,b_2)=b_1b_2
\end{aligned}
$$

## code

```python
n = int(input())
data = [
    [int(i) for i in input().strip().split(' ')[::-1]]
    for _ in range(n)]


def exgcd(a, b):
    if b == 0:
        return (a, 1, 0)
    g, y, x = exgcd(b, a % b)
    return (g, x, y-(a//b)*x)


def solve(v):
    a0, b0 = v[0]
    for item in v[1:]:
        a1, b1 = item
        g, x, y = exgcd(b0, b1)
        _ = y  # discard y

        # assert( (a0-a1)%g=0 )

        x = x*(a1-a0)//g
        a0 = a0+x*b0
        b0 = b0*b1//g
        a0 = (a0 % b0+b0) % b0

    return (a0, b0)


print(solve(data)[0])
```
