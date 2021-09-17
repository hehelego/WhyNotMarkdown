# REVIEW: kmp algorithm

## background

Given a pattern string $S[1,n]$, and a text string $T[1,m]$.  
Find all the matches(the index $k$ such that $T[k,k+n-1]=S[1,n]$).

## brute force

For all $k=1,2,3,\ldots m$, check whether the substring of $T$ starting at $k$ equals to $S$.  

Mismatch: $S[1,i]=T[k,k+i-1]\land S_{i+1}\neq T_{k+i}$,
when a mismatch occurs, stop checking and let $k'\leftarrow k+1$.

```cpp
for(int k=1;k+n-1<=m;k++){
  bool ok=true;
  for(int i=1;i<=n;i++){
    if(S[i]!=T[k+i-1]) {ok=false; break;}
  }
  if(ok) matches.push_back(k);
}
```

## observation

For $k=1$: When a mismatch happens `T[i+1] != S[i+1]`

```plaintext
T[1] T[2] T[3] T[4] T[5] ... T[i+0] | T[i+1] T[i+2] ...
S[1] S[2] S[3] S[4] S[5] ... S[i+0] | S[i+1] S[i+2] ...
     S[1] S[2] S[3] S[4] ... S[i-1] | S[i+0] S[i+1] ...
          S[1] S[2] S[3] ... S[i-2] | S[i+0] S[i+1] ...
```

If `S[1]=T[2]=S[2], S[2]=T[3]=S[3], S[3]=T[4]=S[4] ... S[i-1]=T[i+0]=S[i+0]` is not satisfied,
then a match is impossible, we should not check $k=2$  
For the same reason, if `S[1]=T[3]=S[3], S[2]=T[4]=S[4] ... S[i-2]=T[i+0]=S[i+0]` is not satisfied,
we should also skip $k=3$

We skip $k=2,3\ldots j-1$, until $k=j$, where  
we have `S[1]=S[j] S[2]=S[j+1] S[3]=S[j+2] ... S[i-j+1]=S[i]`,  
then we go on check whether $S[i-j,n]$ matches $T[i+1,n+j+1]$.

```plaintext
T[1] T[2] T[3] ... T[k-1] T[j] T[j+1] T[j+2] ... T[i+0]   | T[i+1]   T[i+2]   ...
S[1] S[2] S[3] ... S[k-1] S[j] S[j+1] S[j+2] ... S[i+0]   | S[i+1]   S[i+2]   ...
                          S[1] S[2]   S[3]   ... S[i-j+1] | S[i-j+2] S[i-j+3] ...
```

Moreover, $j=\min \{0\leq p\leq i-1\mid S[1,i-p+1] = S[p,i] \}$.  
We define $\text{next}_i = i-j+1 = \max \{0\leq p\leq i-1\mid S[1,p]=S[i-p+1,i]\}$

when a mismatch happens, we simply, we move forward $j-1$ character,  
and continue checking from comparing $S[i-j+2]=S[\text{next}_i +1]$ and $T[i+1]$

```cpp
int j=0;
for(int i=1;i<=m;i++){
  while(j>0 && S[j+1]!=T[i]) j=next[j];
  if(S[j+1]==T[i]) j++;
  if(j==n) matches.push_back(i-n+1);
}
```

## finding the `next`

Let $j=\min \{0\leq p\leq i-1\mid S[1,i-p+1] = S[p,i] \}$.  
We define $\text{next}_i = i-j+1 = \max \{0\leq p\leq i-1\mid S[1,p]=S[i-p+1,i]\}$  
$S[1,\text{next}_i] = S[i-\text{next}_i+1,i]$  

Suppose that we have already find $\text{next}_1,\text{next}_2\ldots \text{next}_{i-1}$.  
By definition, we have $S[1,\text{next}_{i-1}] = S[i-\text{next}_{i-1},i-1]$  
If $S[\text{next}_{i-1}+1]=S[i]$, then $S[1,\text{next}_{i-1}+1]=S[i-\text{next}_{i-1},i]$,  
so $\text{next}_{i}=\text{next}_{i-1}+1$.  
Otherwise, check $\text{next}[\text{next}[i-1]]+1,\ \text{next}[\text{next}[\text{next}[i-1]]]+1$, and so on.

```cpp
int j=0;
for(int i=1;i<=n;i++){
  while(j>0 && S[j+1]!=S[i]) j=next[j];
  if(S[j+1]==S[i]) j++;
  next[i]=j;
}
```

## the essence of KMP algorithm

Focus on the value of $j$ when $i$ increases.  
The algorithm computes $f_i=\max \{0\leq j\leq n\mid S[1,j]=T[i-j+1,i]\}$  

- $f_{i+1}\leq f_i + 1$

$$
\begin{aligned}
  S[f_i+1]                              =T[i+1]    & \to f_{i+1}  = f_{i}+1\\
  S[\text{next}[f_i]+1]                 =T[i+1]    & \to f_{i+1}  = f_{\text{next}[i]}+1\\
  S[\text{next}[\text{next}[f_i]]+1]    =T[i+1]    & \to f_{i+1}  = f_{\text{next}[\text{next}[i]]}+1\\
  S[\text{next}^k + 1]                  =T[i+1]    & \to f_{i+1}  = f_{\text{next}^k[i]}+1\\
                                                   & \to f_{i+1}  = 0
\end{aligned}
$$

## complexity analysis

### matching stage

Apply amortized analysis, let $\phi(\text{state}(S,T,i,j))=j$.  

In every iteration of the outer for loop,  
every iteration of the inner loop, $j$ get decresed at least by $1$,  
the last if statement: $j$ get increased at most by $1$.  

- increment: at most $|T|$, takes $O(|T|)$ operations.
- decrement: at most $|T|$, takes $O(|T|)$ operations.

### preprocessing stage

Similar to the matching stage, takes $O(|S|)$ operations.

### total runtime

Summing up, KMP algorithm, runs in linear time and uses linear space.

## further readings

- border of a string
- Aho-Corasick automaton
- NFA and DFA; Gievn a NFA, construct a DFA that accept all the strings which is recognized by the NFA.
- suffix automaton
- minimizing a DFA
