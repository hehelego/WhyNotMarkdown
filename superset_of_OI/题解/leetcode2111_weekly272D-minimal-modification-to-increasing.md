# [weekly contest 272] leetcode 2111: Minimum Operations to Make the Array K-Increasing

## problem statement

[link](https://leetcode.com/contest/weekly-contest-272/problems/minimum-operations-to-make-the-array-k-increasing/)

An sequence $a_1\ldots a_n$ is called $k$-increasing if $\forall i\ a[i-k] \leq a[i]$.  
Given a integer $k$ and a sequence of $n$ integers, find the minimum number of operations required to make the sequence $k$-increasing,
where the effect of an operation $(p,v)$ is $a[p]\gets v$

## solution

### reduction

Divide the sequence into $k$ disjoint sub-sequences.

- $0$: $a[0],a[k+0],a[2k+0]\ldots$
- $1$: $a[1],a[k+1],a[2k+1]\ldots$
- $2$: $a[2],a[k+2],a[2k+2]\ldots$
- $j$: $a[j],a[k+j],a[2k+j]\ldots$
- $k-1$: $a[k-1],a[k+(k-1)],a[2k+(k-1)]\ldots$

$a$ is $k$-increasing iff the $k$ sub-sequences are increasing.

### invariant

Now let's consider this problem: given a sequence $a_1, a_2\ldots a_n$, find the minimum number of operations to make it increasing.

The answer is always no more than $n-1$ since we can make $a_1=a_2=a_3\ldots a_n$ with in $n-1$ steps.

Suppose that in the optimal solution, we do not modify $a[b_1],a[b_2]\ldots a[b_m]$, where $1\leq b_1 < b_2\ldots b_m \leq n$.  
Then we should have $a[b_1]\leq a[b_2]\ldots a[b_m]$.  
Conversely, if we have a subsequence $1\leq b_1<b_2\ldots b_m$, we can make the sequence a increasing one within $n-m$ steps:  

- for $1 < k <b_{1}$, let $a[k]\gets a[b_1]$
- for $b_{j-1} < k < b_{j}$, let $a[k]\gets a[b_{j-1}]$

Thus, any valid solution corresponds to a increasing sub-sequence of $a$.  
To minimize the number of operations, we need to find the longest increasing subsequence of $a$, which can be done in $O(n\log n)$ time with `DP+binary-search` or `DP+SegmentTree`.
