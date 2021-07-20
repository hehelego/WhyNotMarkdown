# CF-Edu106Div2-chaotic_merge

> 这也太trivial了...  
> 但是很长时间不做相关训练,已经熟练度已经大幅下降了.

## problem statement

```haskell
merge:: String->String -> [String]
merge [] ys = [ys]
merge xs [] = [xs]
merge xs@(hx:tx) ys@(hy:ty) = 
  let pa = (hx:)<$>(merge tx ys)
      pb = (hy:)<$>(merge xs ty)
  in pa++pb

isChaotic:: String -> Bool
isChaotic s = and $ zipWith (/=) (tail s) (init s)

solveOnce:: String->String -> Int
solveOnce s0 s1 = length $ filter isChaotic $ merge  s1
```

输入两个串`S,T`,枚举非空子串`s,t`,对`solveOnce s t`求和.


## solution


### part 1

~~首先排除自动机玩法~~

先考虑怎做`solveOnce`, 一个简单DP即可.  
设$f(i,j,0)$ 表示`s[1:i],t[1:j]`的混乱合并中,最后一个字符是`s[i]`.计数  
设$f(i,j,1)$ 表示`s[1:i],t[1:j]`的混乱合并中,最后一个字符是`t[j]`.计数  

考虑倒数第二个字符来自s还是t,写出转移方程(边界条件省略,因为比较显然)  

$$
\begin{aligned}
f(i,j,0) &= [s_{i-1}\neq s_i]f(i-1,j,0) + [t_j\neq s_i]f(i-1,j,1)\\
f(i,j,1) &= [t_{j-1}\neq t_j]f(i,j-1,1) + [s_i\neq t_j]f(i,j-1,0)
\end{aligned}
$$


所求答案即为$f(|s|,|t|,0)+f(|s|,|t|,1)$  
我们枚举两个输入串的子串,做上面这个过程,可以得到$O\left(n^2 m^2 \times n m\right)=O\left({(nm)}^3\right)$的做法.

更进一步,我们可以枚举`S,T`的后缀,做上述DP,并对所有`f`求和,  
取出后缀`s=S[p:],t=T[q:]`时,`f(i,j,0)+f(i,j,1)`即为`solveOnce s[p:p+i-1] t[q:q+j-1]`.  

这样不用枚举子串的结束位置,复杂度降低为$O(n^2 m^2)$

### part 2

这个考虑末尾加入一个字符,对末尾的前一个字符分类讨论,计数的过程,已经无法优化了.  
我们必须设法消除掉"枚举后缀"这个操作,才能得到足以通过的复杂度.  



定义状态$g(i,j)$表示考虑`S[:i],T[:j]`时的混乱合并计数,  

我们需要取出子串(连续一段)而非子区间(允许不连续),所以这个状态是没法转移的,  
需要加上"是否开始取字符"的信息, "已经开始取字符"的状态只能转移到"已经开始取字符"的状态, 而"还未开始取字符"的状态,可以转移到"已经/还未开始取字符".  

定义$g(i,j,0/1,0/1)$表示考虑了`S[:i],T[:j]`.

- $g(i,j,0,\ast ),\ g(i,j,1,\ast)$ 分别表示 "还未开始取`S`中的字符","已经从`S`中选取过字符".
- $g(i,j,\ast, 0),\ g(i,j,\ast, 1)$ 分别表示 "还未开始取`T`中的字符","已经从`T`中选取过字符".

最后,还要带上 末位字符来自于`S`/末尾字符来自于`T` 的信息.  
定义$g(i,j,0/1,0/1,0/1)$表示某个状态下的混乱合并计数.  

状态转移类似$f$,但是需要考虑"是否开始取字符"的信息.

- $g(i,j,0,0,0),g(i,j,0,0,1)$ 为未定义状态, 对它们赋值为0避免一些边界讨论.
- $g(i,j,1,0,1),g(i,j,0,1,0)$ 的处理同上一类状态.
- $g(i,j,1,0,0)=1+[s_{i-1}\neq s_i]g(i-1,j,1,0,0)$  
  $g(i,j,0,1,1)=1+[t_{j-1}\neq t_j]g(i,j-1,0,1,1)$  
  这种仅从`S`/`T`中取字符的情况,有两种情况  
  1. 之前已经从`S`/`T`取过字符, 那么上一步取的应该是`s[i]`/`t[j]`,判断是否相等进行转移.
  2. 之前什么字符都没有,取了这个字符之后,得到一个长度为`1`的合并串,没有任何约束.
- $g(i,j,1,1,0)=[s_{i-1}\neq s_i]g(i-1,j,1,1,0) + [t_j\neq s_i]\left\{g(i-1,j,1,1,1)+g(i-1,j,0,1,1)\right\}$  
  还是类似$f$的转移,枚举倒数第二个字符来自哪边,是什么字符,分类讨论,进行计算.  
  这种`S,T`中都已经开始选取的字符的情况,只能从 "`S,T`中均开始选取字符","`S`中开始选取,`T`中未选取过字符","`T`中开始选取,`S`中未选取过字符" 这样三类状态转移过来.  
  $g(i,j,1,1,1)$根据对称性很容易写出来.是这个样子  
  $g(i,j,1,1,1)=[t_{j-1}\neq t_j]g(i,j-1,1,1,1) + [s_i\neq t_j]\left\{g(i,j-1,1,1,1)+g(i,j-1,1,0,0)\right\}$  

我们按照上述过程进行计算,并对$g(\ast,\ast,1,1,\ast)$求和,即为答案.  
这样,成功消除了所有对于边界的枚举,只保留了分类讨论保证相邻不相同的递推计算, 做到了$O(nm)$的复杂度, 可以通过本题.




## implementation

### part 1

```cpp
int solve(int p0, int p1) {
  int res = 0;
  memset(f, 0, sizeof(f));
  memset(g, 0, sizeof(g));
  auto S = [=](int i) { return i > 0 ? s0[p0 + i - 1] : 0; };
  auto T = [=](int j) { return j > 0 ? s1[p1 + j - 1] : 0; };
  int n = n0 - p0 + 1, m = n1 - p1 + 1;

  f[1][0]=1;
  for(int i=2;i<=n;i++){
    f[i][0]=S(i-1)!=S(i)&&f[i-1][0]>0?1:0;
  }
  g[0][1]=1;
  for(int j=2;j<=m;j++){
    g[0][j]=T(j-1)!=T(j)&&g[0][j-1]>0?1:0;
  }
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= m; j++) {
      f[i][j] = (S(i - 1) != S(i) ? f[i - 1][j] : 0) +
                (T(j) != S(i) ? g[i - 1][j] : 0);
      g[i][j] = (T(j - 1) != T(j) ? g[i][j - 1] : 0) +
                (S(i) != T(j) ? f[i][j - 1] : 0);
      f[i][j] %= mod;
      g[i][j] %= mod;
      res = (res + f[i][j] + g[i][j]) % mod;
    }
  }
  return res;
}
```

### part 2

```cpp
#include <bits/stdc++.h>
#define chk(c,v) (c?v:0)
using u32 = uint32_t;
const u32 mod = 998244353;
const u32 N = 1000 + 3;
char s[N], t[N];
template <typename T, T mod> class Zmod {
private:
  T v;

public:
  Zmod(T value = 0) : v((value % mod + mod) % mod) {}
  const T value() const { return this->v; }
  Zmod operator+(const Zmod &rhs) const { return Zmod(v + rhs.v); }
  Zmod operator-(const Zmod &rhs) const { return Zmod(v - rhs.v); }
  Zmod operator*(const Zmod &rhs) const { return Zmod(v * rhs.v); }
};
using Zp = Zmod<u32, mod>;
Zp f[N][N][2][4];

int main() {
  scanf("%s", s + 1);
  scanf("%s", t + 1);
  int n = strlen(s + 1), m = strlen(t + 1);

  Zp ans = 0;
  for (int i = 1; i <= n; i++) {
    f[i][0][0][0b01] = Zp(1) + chk(s[i - 1] != s[i], f[i - 1][0][0][0b01]);
  }
  for (int j = 1; j <= m; j++) {
    f[0][j][1][0b10] = Zp(1) + chk(t[j - 1] != t[j], f[0][j - 1][1][0b10]);
  }
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= m; j++) {
      // 0b01
      f[i][j][0][0b01] = Zp(1) + chk(s[i-1]!=s[i],f[i - 1][j][0][0b01]);
      // 0b10
      f[i][j][1][0b10] = Zp(1) + chk(t[j-1]!=t[j],f[i][j-1][1][0b10]);
      // 0b11
      f[i][j][0][0b11] = chk(s[i-1]!=s[i],f[i-1][j][0][0b11])+chk(t[j]!=s[i],f[i-1][j][1][0b10]+f[i-1][j][1][0b11]);
      f[i][j][1][0b11] = chk(t[j-1]!=t[j],f[i][j-1][1][0b11])+chk(s[i]!=t[j],f[i][j-1][0][0b01]+f[i][j-1][0][0b11]);

      ans = ans + f[i][j][0][0b11] + f[i][j][1][0b11];
    }
  }
  std::cout << ans.value() << std::endl;
  return 0;
}
```
