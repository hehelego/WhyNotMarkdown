# [SDOI2014] 数数

## problem statement

输入正整数$n$, 以及一些${\{0,1,2,3\ldots 9\}}^{\ast}$的子集$S$.
统计$x$的数量, 满足

- $x\in [1,n]\land x\in \mathbb{Z}$
- $x$的十进制表达的子串, 不出现在$S$内(十进制表达不允许先导0)

## solution

数位DP+AC自动机, 太套路了.  
数位DP的关键就是, 在trie上面找这样一个子树(可以看看二进制的情况,就是线段树前缀查询):
包含不超过$n$的数对应的叶子节点(一个前缀), 以及这些节点的所有祖先.  
然后根据数位的约束, 设计状态, 并记录是否顶住上界, 是否在前导0部分.  

这里有一个容易写挂的地方:  
我们显然要记录一下, 当前选出的前缀, 在AC自动机的哪个状态.  
但是在先导0阶段, 不应更新这个状态记录...  
考虑$n=10,S=\{0\}$的情况. 我们会错过$\overline{(0x)}_{10}$的数字即$\{1,2,3\ldots 9\}$.

## code

```cpp
#include <bits/stdc++.h>
const int n = 1600;
const int mod = int(1e9) + 7;
int readbits(int *buf) {
	int n = 0;
	char c;
	do {
		c = getchar();
	} while (!isdigit(c));
	do {
		buf[n++] = c - '0';
		c = getchar();
	} while (isdigit(c));
	return n;
}
int parse(int *buf, int n) {
	int x = 0;
	for (int i = 0; i < n; i++) x = x * 10 + buf[i];
	return x;
}

namespace ahocorasick {
int root, cnt;
int ch[n][10], fail[n], end[n];
int qq[n], ql, qr;
void init() { root = ++cnt; }
void insert(int *buf, int n) {
	int p = root;
	for (int i = 0; i < n; i++) {
		int c = buf[i];
		if (ch[p][c] == 0) ch[p][c] = ++cnt;
		p = ch[p][c];
	}
	end[p]++;
}
void build() {
	ql = qr = 0;
	for (int i = 0; i < 10; i++) {
		int &v = ch[root][i];
		if (v == 0)
			v = root;
		else
			fail[qq[qr++] = v] = root;
	}
	while (ql < qr) {
		int p = qq[ql++];
		end[p] += end[fail[p]];
		for (int i = 0; i < 10; i++) {
			int &v = ch[p][i];
			if (v == 0)
				v = ch[fail[p]][i];
			else
				fail[qq[qr++] = v] = ch[fail[p]][i];
		}
	}
}
}	 // namespace ahocorasick

int nbits, bound[n], buf[n];

bool vis[n][n];
int table[n][n];
int dfs(int step, bool flag_bound, bool flag_zero, int state) {
	if (ahocorasick::end[state]) return 0;

	if (step == nbits) return !flag_zero;
	int res = 0;
	if (flag_bound == false && flag_zero == false) {
		if (vis[step][state]) return table[step][state];
		for (int i = 0; i <= 9; i++)
			res =
					(res + dfs(step + 1, false, false, ahocorasick::ch[state][i])) % mod;
		vis[step][state] = true;
		return table[step][state] = res;
	} else if (flag_zero) {
		int lim = flag_bound ? bound[step] : 9;
		res =
				(res + dfs(step + 1, flag_bound && 0 == lim, true, ahocorasick::root)) %
				mod;
		for (int i = 1; i <= lim; i++)
			res = (res + dfs(step + 1, flag_bound && i == lim, false,
											 ahocorasick::ch[state][i])) %
						mod;
	} else {
		int lim = flag_bound ? bound[step] : 9;
		for (int i = 0; i <= lim; i++)
			res = (res + dfs(step + 1, flag_bound && i == lim, false,
											 ahocorasick::ch[state][i])) %
						mod;
	}
	return res;
}

int main() {
	nbits = readbits(bound);

	int mbits = readbits(buf);
	int m = parse(buf, mbits);
	ahocorasick::init();
	while (m--) {
		int len = readbits(buf);
		ahocorasick::insert(buf, len);
	}
	ahocorasick::build();

	std::cout << dfs(0, true, true, ahocorasick::root) << std::endl;
	return 0;
}
```
