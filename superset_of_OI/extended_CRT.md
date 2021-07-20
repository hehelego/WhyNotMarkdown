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
\implies x&=a_1-k_1b_1=a_1-b_1(\frac{a_1-a_2}{(b_1,b_2)}k'_{10}+\frac{b_2}{(b_1,b_2)}t)\\
&=a_1-\frac{a_1-a_2}{(b_1,b_2)}b_1k'_{10}-\frac{b_1b_2}{(b_1,b_2)}t\\
\implies x&\equiv a_1+\frac{a_2-a_1}{(b_1,b_2)}b_1k'_{10}\pmod {\frac{b_1b_2}{(b_1,b_2)}}\quad [b_1,b_2](b_1,b_2)=b_1b_2
\end{aligned}
$$





code:

```python
n=int(input());
data=[list(map(int,input().split(' ')))[::-1] for _ in range(n)]
# trick reverse(a)=a[::-1]

def exgcd(a,b):
    if b==0: return (a,1,0)
    g,y,x=exgcd(b,a%b)
    return (g,x,y-(a//b)*x)

def solve(v):
    a0,b0=v[0];v=v[1:]
    for item in v:
        a1,b1=item
        g,x,y=exgcd(b0,b1)
        # assert( (a0-a1)%g=0 )
        x=x*(a1-a0)//g
        a0=a0+x*b0
        b0=b0*b1//g
        a0=(a0%b0+b0)%b0
    return (a0,b0)
print(solve(data)[0])
```

```cpp
typedef long long Int;
inline Int fix(Int x,Int y){ return (x%y+y)%y; }
struct T{
	Int rem,mod;
	T(Int a,Int b):rem(a),mod(b){}
	T(const std::pair<Int,Int> &x){
		rem=x.first; mod=x.second;
	}
};
Int exgcd(Int a,Int b,Int &x,Int &y){
	if(b==0){ x=1; y=0; return a; }
	Int g=exgcd(b,a%b,y,x);
	// ax+by=by+(a-(a/b)*b)x=gcd
	// ax+b(y-(a/b)*x)=gcd
	y=y-(a/b)*x;
	return g;
}
T solve(std::vector<T> v){
	if(v.size()==0) return T(0,0);
	Int a0=v[0].rem,b0=v[0].mod;
	for(int i=1;i<v.size();i++){
		Int a1=v[i].rem,b1=v[i].mod;
		Int x=0,y=0; Int g=exgcd(b0,b1,x,y),mod=b0/g*b1;
		//if(fix(a0-a1,g)!=0) return T(0,0);
		x=(a0-a1)/g*x; x=fix(x,b1/g);
		a0=a0-x*b0%mod; a0=fix(a0,b0=mod);
	}
	return T(a0,b0);
}

int main(){
	int n=read(); std::vector<T> v;
	for(int i=0;i<n;i++){
		Int mod=read(),rem=read();
		v.push_back(T(rem,mod));
	} std::cout<<solve(v).rem<<std::endl;
	return 0;
}
```

