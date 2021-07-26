# [SCOI2009] windy数

## problem statement

求十进制数$x$的计数, 满足如下约束

- $a\leq x\leq b$
- 无前导0
- 相邻数位上的数码之差至少为2

## solution

首先, 后两条约束和$a,b$没有关系, 于是, 可以分别求出$1\leq x< a$和$1\leq x\leq b$的范围内的计数, 差分一下.  
于是, 现在的约束条件为: $1\leq x\leq n$, $x$无前导$0$, $x$的相邻数位上数码差大于$1$.

### part 1

考虑一个 10-way trie, 表示所有decimal numbers.  
它是一个 rooted full 10-ary tree, edges 上面带着 `0,1,2...9` 的weight.  
从root到一个leaf的path上的edge weights依次表示最高位到最低位.

我们考虑遍历所有满足$1\leq x\leq n$的叶子的过程中所经过的节点.  
某些节点, 其子树被完全遍历, 某些节点, 其子树只被遍历一部分.

> 以4进制下31024为例子
>
> ```plaintext
> 0****
> 1****
> 2****
> 30***
> 3101*
> 31020, 31021, 31022, 31023, 31024
> ```

设$n=\overline{(a_{m-1} a_{m-2} \ldots a_2 a_1 a_0)}_{10}$
我们从最高位开始, 向最低位考虑.  

- 对于第$k$位, 若$m-1,m-2\ldots k+1$位上的选择, 分别为$a_{m-1},a_{m-2}\ldots a_{k+1}$,
那么第$k$位只能选择$0,1,2\ldots a_k$
- 若之前至少有一位错开, 那么$k,k-1\ldots 0$位都是可以任意选择的.

### part 2

遍历tire时, 我们需要记录以下信息, 来推断当前数位可以有哪些选择.

1. 是否处于"顶到上界", 即先前的数位选择中是否有和$n$的十进制表达错开.
2. 是否仍然在先导0阶段, 即是否选择过一个非0数码.
3. 上一个数位上的数码选择

转移比较自然, 初始提交也容易写出.  

### part 3

最后来考虑效率问题, 我们有$m=O(\log n)$, 和$n$的十进制表达第一次错开可以在第$0,1,2,3\ldots m$位,  
最坏情况是$n=10^m-1=\overline{9999\ldots 9}_{10}$, 错开后有$9$钟选择, 于是需要特殊处理的"顶到上界"的状态数,
是不超过$B\lceil \log_{B}n\rceil$的,其中$B=10$.  
而并非顶到上界时, 数码的选择是仅仅受到上一位数码的限制, `(剩余位数,上一次选择的数码)`
决定了这种状态在tire上面对应的子树内部满足$1\leq x\leq n$的叶子数目,
我们可以做一个记忆化搜索.

有$m=\log_B n$个可能错开的位置(即一个数字的十进制表达和$n$的十进制表达的LCP长度只能是$0,1,2,3\ldots m$)  
尚未错开时的状态有$m$个,  
错开之后 `(剩余位数,上一次选择的数码)` 的状态数不超过$Bm$.
而转移(走到tire上的这个个节点的子树中去)每一个状态都最多是有$B$个.  
于是总体的复杂度就是$O(m B^2)$的, 足以通过了.

## code

```cpp
#include <bits/stdc++.h>

const int N = 13;

std::vector<int> dec_bits(int n) {
	auto res = std::vector<int>{};
	while (n > 0) {
		res.emplace_back(n % 10);
		n /= 10;
	}
	return res;
}

int table[N][N];
bool vis[N][N];
#define DEBUG 1
int dfs(const std::vector<int> &bound, int step, int last_digit, bool flag_lcp,
				bool flag_zero, int dep = 0) {
#if DEBUG
	for (int i = 0; i < dep; i++) putchar('\t');
	printf("dfs(step=%d,last=%d,lcp=%d,zero=%d)\n", step, last_digit, flag_lcp,
				 flag_zero);
#endif

	// 边界, 选出了1个合法的数字
	if (step < 0) {
#if DEBUG
		if (!flag_zero) {
			for (int i = 0; i < dep; i++) putchar('\t');
			printf("\tok\n");
		}
#endif
		return flag_zero == false;
	}
	// 来开前导0部分, 并且不被上界约束, 剩余部分自由选择.
	// 做记忆化搜索
	if (flag_lcp == false && flag_zero == false) {
		int res = 0;
		if (vis[step][last_digit]) return table[step][last_digit];
		vis[step][last_digit] = true;
		for (int i = 0; i <= 9; i++)
			res += (std::abs(i - last_digit) > 1)
								 ? dfs(bound, step - 1, i, false, false, dep + 1)
								 : 0;
		return table[step][last_digit] = res;
	}
	int res = 0, beg = 0, end = flag_lcp ? bound[step] : 9;
	// 仍然位于前导0部分, 除非顶到上界, 否则可以随便选.
	if (flag_zero) {
		for (int i = beg; i <= end; i++) {
			res += dfs(bound, step - 1, i, flag_lcp && i == bound[step],
								 flag_zero && i == 0, dep + 1);
		}
	} else {
		// 对于顶到上界的处理: 之前的部分的选择与bound重合, 并且这一位仍然没有错开, 则下一位的选择不能超过bound[step-1]
		for (int i = beg; i <= end; i++) {
			res += (std::abs(i - last_digit) > 1)
								 ? dfs(bound, step - 1, i, flag_lcp && i == bound[step], false,
											 dep + 1)
								 : 0;
		}
	}
	return res;
}
int solve(int n) {
	if (n == 0) return 0;
	auto bits = dec_bits(n);
	int sz = bits.size();
	return dfs(bits, sz - 1, -10, 1, 1);
}

int main() {
#if DEBUG
	int n = 0;
	std::cin >> n;
	std::cout << solve(n) << std::endl;
	return 0;
#endif

	int l, r;
	std::cin >> l >> r;
	int ans = solve(r) - solve(l - 1);
	std::cout << ans << std::endl;
	return 0;
}
```

