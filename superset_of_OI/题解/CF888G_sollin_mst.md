# CF edu round 32: XOR-MST

> - Borůvka's algorithm
> - Sollin's algorithm

## problem statement

Given a complete graph with $n$ vertices $G=(V,E)$, where $V=\{i\in \mathbb{N}\mid i\leq n\},E=\{\{u,v\}\mid u\in V\land v\in V\}$.  
Assign a natural number weight $a_i$ to vertex $i$ for all $1\leq i\leq n$.  
The weight of edge $\{i,j\}$ is $a_i\oplus a_j$, the bitwise-exclusive-or.

Find a MST of the graph

## Sollin's MST algorithm

For a graph $G=(V,E)$, where the weight of edge $\{u,v\}$ is $w(u,v)$

1. Initially, there are $|V|$ blocks.
   Each vertex belongs to a block of size $1$.
2. For each block $B$. For $u\in B,v\not\in B$,  
   let $f(v)=\min \{w(u,v) \mid u\in B\},g(u)=\min \{w(u,v)\mid v\not\in B\}$.  
   Find $\mathrm{from}_B=\mathrm{arg\, min}\{g(u)\mid u\in B\},\mathrm{to}_B=\mathrm{arg\, min}\{f(v)\mid v\not\in B\}$.
3. For each block $B$, try to combine $B$ with another block by adding the edge $\{ \mathrm{from}_B,\mathrm{out}_B \}$ into MST.
4. Repeate step2 and step3 until no edge can be added.

In one iteration,  
we find the minimum out-going edge for each connected component.  
try add the minimum out-going edges into MST.

In each iteration, every block is matched with another block.
suppose that we have $B$ blocks, after one iteration, the number of remaining blocks is at most $\lfloor B/2 \rfloor$.

- **correctness**: cut-property, induction.  
- **complexity**: $O(E\log V)$, at most $\log V$ iterations, enumerate all the edges in each iteration.

## solution

Sollin's MST.  
01-trie xor-min/max greedy.  
union by size.

## code

```cpp
#include <bits/stdc++.h>
int read() {
  int x = 0;
  char c;
  do { c = getchar(); } while (!isdigit(c));
  do { x = x * 10 + c - '0', c = getchar(); } while (isdigit(c));
  return x;
}
const int N = 200000 + 10;
const int LIM = 30;
int n, a[N], link_v[N], link_w[N];
struct UnionFind {
  int fa[N];
  std::vector<int> mem[N];
  void init(int n) {
    for (int i = 1; i <= n; i++) { fa[i] = i, mem[i].push_back(i); }
  }
  int find(int x) { return fa[x]; }
  bool merge(int x, int y) {
    x = fa[x], y = fa[y];
    if (x == y) { return false; }
    if (mem[x].size() < mem[y].size()) { std::swap(x, y); }
    for (int i : mem[y]) { fa[i] = x, mem[x].push_back(i); }
    std::vector<int>().swap(mem[y]);
    return true;
  }
} dsu;
struct Trie {
  struct Node {
    int ch[2], sz, id;
  };
  static Node pool[];
  static int cnt;
  static void create_if_empty(int &x) { x = x ? x : ++cnt; }

  int root;
  Trie() { root = ++cnt; }
  void update(int val, int id, int delta) {
    int p = root, v = 0;
    pool[p].sz += delta;
    for (int i = LIM - 1; i >= 0; i--) {
      v = (val >> i) & 1;
      create_if_empty(pool[p].ch[v]);
      p = pool[p].ch[v];
      pool[p].sz += delta;
    }
    pool[p].id = id;
  }
  int query(int val) {
    int p = root, v = 0;
    for (int i = LIM - 1; i >= 0; i--) {
      v = (val >> i) & 1;
      p = pool[pool[p].ch[v]].sz ? pool[p].ch[v] : pool[p].ch[v ^ 1];
    }
    return pool[p].id;
  }
} tree;
int Trie::cnt = 0;
Trie::Node Trie::pool[N * (LIM + 2)];

int b[N];
int main() {
  int m = read();
  for (int i = 0; i < m; i++) { b[i] = read(); }
  std::sort(b, b + m);
  for (int i = 0; i < m; i++) {
    if (i > 0 && b[i - 1] == b[i]) continue;
    n++;
    tree.update(a[n] = b[i], n, 1);
  }
  dsu.init(n);

  unsigned long long ans = 0;
  while (true) {
    bool flag = false;
    for (int i = 1; i <= n; i++) {
      if (dsu.fa[i] != i) { continue; }
      link_v[i] = 0;
      for (int j : dsu.mem[i]) { tree.update(a[j], 0, -1); }
      for (int j : dsu.mem[i]) {
        int k = tree.query(a[j]);
        if (k == 0) { continue; }
        if (link_v[i] == 0 || (a[j] ^ a[k]) < link_w[i]) {
          link_v[i] = k, link_w[i] = a[j] ^ a[k];
          flag = true;
        }
      }
      for (int j : dsu.mem[i]) { tree.update(a[j], j, 1); }
    }
    if (!flag) { break; }
    for (int i = 1; i <= n; i++) {
      if (dsu.fa[i] != i) { continue; }
      if (dsu.merge(i, link_v[i])) { ans += link_w[i]; }
    }
  }
  std::cout << ans << std::endl;

  return 0;
}
```
