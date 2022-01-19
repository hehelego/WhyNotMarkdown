# 关于BIT的二三事

> BIT(binary indexed tree)二进制索引树.
> 由于是Fenwick搞出来,也称为Fenwick tree.
> 国内称为"树状数组"

BIT是一种基于二进制分解的数据结构,支持维护前缀信息(一般维护非常简单的区间和,是交换结合且可逆的).

给定$n$,$s_i=[i-f(i)+1,i]$其中$f=\mathop{lowbit}$对于有符号整数,可以用`lowbit(x)=x&(-x)`
如果$s_i\subset s_j$那么$s_j$为$s_i$的祖先,这样可以形成一个树型结构.

首先有一个简单性质$f(i+f(i))\geq 2f(i)$(考虑二进制下的进位)以及$f(i-f(i))\geq 2f(i)\lor i-f(i)=0$成立.
我们在节点$i$处维护区间$s_i$的信息.
显然$s(i-f(i))$是紧贴$s(i)$的左侧,而$s(i+f(i))$是真包含$s_i$的最小区间.

于是我们可以不断$i\to i+f(i)$遍历包含$i$的所有区间,每次$s_i$的长度至少翻倍于是是$O(\log n)$次操作.
而使用$i\to i-f(i)$来遍历前缀$[1..i]$,每次操作$i$的二进制表示中的$1$减少$1$个,于是是$O(\log n)$次操作.

## 例子维护前缀和

```cpp
const int N = 1000000 + 10;
int t[N], n;

inline int lowbit(int x) { return x & (-x); }
void add(int x, int y) { //遍历包含区间
  while (x <= n) {
    t[x] += y;
    x += lowbit(x);
  }
}
int qry(int x) { // 分解前缀
  int s = 0;
  while (x) {
    s += t[x];
    x -= lowbit(x);
  }
  return s;
}
```
