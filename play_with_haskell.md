# play with Haskell
> record my progress of learning the functional programming language `haskell`



## start up

### some useful resources. 

- [Learn X in Y minutes:haskell](https://learnxinyminutes.com/docs/haskell/) 一个cheat sheet,快速熟悉用HS写程序的基本要素.
- [read it online:LYH4GG](http://learnyouahaskell.com/chapters) 大名鼎鼎的入门书,中文书名叫Haskell趣学指南,对于理论的讲解不够.
- [bilibili:learn your haskell for great good](https://www.bilibili.com/video/av7513983) 对于learn your Haskell for great good**部分**内容的讲解.
- [bilibili:FP101X](https://www.bilibili.com/video/av18823116/) TUDelft的一位教授开的MOOC,在edx.org上面可以看,国内只能看这个.
- [zhihu:仙境里的haskell](<https://zhuanlan.zhihu.com/p/21371274>) zhihu的网友创作的专栏系列文章,讲解haskell的基础玩法.
- 两个更加深入的教学书thinking functionally with haskell/Programming in Haskell
- Lambda-Calculus and Combinators
- 然后可能需要type theory,category theory

另外三个官方向的文档链接 [hs doc](https://www.haskell.org/documentation/),[hoogle](https://hoogle.haskell.org/),[hs wiki](https://wiki.haskell.org/Haskell)



### setup Haskell environment

**Installing Haskell via ‘stack’ is highly recommended** see [this page](<https://docs.haskellstack.org/en/stable/install_and_upgrade/>) for stack installation,after that try `stack ghci` in your console.
get Haskell packages(stackages+hackages) with the help of [tuna mirros](<https://mirrors.tuna.tsinghua.edu.cn/help/stackage/>).
安装的时候,记得选择安装本地文档,直接看
**tuna上面关于config.yaml的配置可能是过时的,取stack官方的doc里面找吧**

```
stack --version (ver>=2.1.3)
stack new project-name
cd ./new-project
stack setup
stack build

stack ghc
stack ghci
stack runghc

stack ghc -- --version(WTF!)
```

### basic commands in GHCi

```haskell
-- get brief introduction to the commands in GHCi
:help -- :? for short

:quit -- or :q for short,quit GHCi; bear it in mind not to use Ctrl+C to break.

-- in GHCi,how to write a multi-line function
:{
  my_true a b=a
  my_false a b=b
  my_not x=x my_false my_true
:}

-- show the type of something,get documentation
:info function/binding/type/typeclass --show the information of XXX, :i for short
:type something --show the type of YYY, :t for short
:doc Functor --show basic doc
:kind Functor --show kind of type Functor,-k for short
-- kind of (,,) is *->*->*->*,which means you can put three concrete types into it,and get a new concrete type.
-- kind of (Maybe [[Int]]) is *,which means it is already a concrete type

:load qwq.hs -- compile and load the file qwq.hs, :l for short
:reload -- reload all packages


-- (help,quit) (t,k,i,doc) (l,r)
```



## notes

haskell uses **indentation ** to mark code-blocks rather than `{}` 

Haskell doesn’t allow a identifier to start with a capitalized letter(`QaQ=1`and`let Abs_1926=1926 in Abs_1929+1` are not allowed).Name starting with a capitalized letter like `Bool,MyADT` is for type names.



### adding packages to your project

当前目录没有`stack.yaml`时stack会使用global project,它不会屏蔽任何库(尽量不要在global project中安装库),而在stack sandbox中,它仅仅引入`packages.yaml`,`stack.yaml`中指定的包,比如你新建了一个stack sandbox,然后运行GHCi,尝试导入`Data.Set`就会出错,它提示你

```
<no location info>: error:
    Could not load module ‘Data.Set’
    It is a member of the hidden package ‘containers-0.6.2.1’.
    You can run ‘:set -package containers’ to expose it.
    (Note: this unloads all the modules in the current scope.)
```



怎么解决呢?找到当前目录下的`packages.yaml`在dependencies中加入containers(当然你可以不指定版本让stack去找最新的)之后再次启动GHCi就能成功导入`Data.Set`了.

```yaml
dependencies:
- base >= 4.7 && < 5
- containers

library:
  source-dirs: src

executables:
  learn-hs-exe:
    main:                Main.hs
    source-dirs:         app
    ghc-options:
    - -threaded
    - -rtsopts
    - -with-rtsopts=-N
    dependencies:
    - learn-hs

tests:
  learn-hs-test:
    main:                Spec.hs
    source-dirs:         test
    ghc-options:
    - -threaded
    - -rtsopts
    - -with-rtsopts=-N
    dependencies:
    - learn-hs
```





## 随笔

> 这里会记录一些学习中遇到的有趣的例子.
>
> 笔记这种东西,不用记得多么详细,
> 精简到只剩下足以推导出其他一切东西的基础公理和推理方式.



### 0000 有时候你需要钦定类型帮助推导

HS的extended HM类型系统是非常强大的,但是有时候你不得不指定类型,比如读入一个string,转换成integer.

```haskell
-- read::(Read a)->String->a
(read::[Char]->Int) "1926"  -- specify the type of read
(read "3.1415926")::Double  -- specify the type of the result of read,at let the complier decide the type of function read
```



### 0001 haskell对标识符的要求很弱

一个有趣的程序,模仿它的样子,我们也可以在Haskell中做运算符重载

```haskell
main::IO()
main=putStrLn $ show $ (let 2*-3="NSML" in 2*-3)
# -> NMSL
```



### 0002 一个效率非常低的素数筛…

```haskell
import Data.List
primes_leq m = sieve [2..m]
  where
    sieve (x:xs) = x : sieve (xs \\ [x,x+x..m])
    sieve [] = []
p_leq_100 = primes_leq 100
```



### 0003 merge sort

```haskell
my_merge::(Ord a)=>[a]->[a]->[a]
my_merge xs []=xs
my_merge [] ys=ys
my_merge a@(x:xs) b@(y:ys)=
  if x<y
  then x:(xs `my_merge` b)
  else y:(a `my_merge` ys)


(//)=div
left_half  xs = let n = length xs in take (n//2) xs
right_half xs = let n = length xs in drop (n//2) xs

my_merge_sort::(Ord a)=>[a]->[a]
my_merge_sort []=[]
my_merge_sort [x]=[x]
my_merge_sort xs =
  my_merge as bs
  where
    as=my_merge_sort $ left_half xs
    bs=my_merge_sort $ right_half xs

call_by_name=
  let inf_loop=inf_loop in (a||inf_loop)&&(b&&inf_loop)
    where
      a=True
      b=False

main::IO ()
main=do
  let qwq=call_by_name in print $ show $ my_merge_sort $ map (*(-3)) [1..10]
```



### 0004 递归求解中的技巧:计数器(累加器)

hs中简单的记忆化搜索,因为没有副作用,不能实时更新数据结构,那就只好把数据结构带着扔进参数列表里面,每次换一个了…大概就这样,效率很低…对于参数多的,试试Data.Map

```haskell
fib n=solve n 0 1  where
  solve 0 a b =a
  solve n a b =solve (n-1) b (a+b)
```



### 0005 luoguP1118

这个题目是[USACO06FEB]Backward Digit Sums G/S
求出一个$[1..n]$的排列$p$,使得$\sum_{i=1}^n p_i\binom{n-1}{i-1}=s$其中$n$非常小,允许阶乘/指数复杂度.

```haskell
main::IO()
main=do
  --putStrLn "-->start"

  line<-getLine
  let q=( (fmap read) . words $line )::[Int]
  let (n,s)=(q!!0,q!!1)
  let ret=search n 0 s [] 
  putStrLn . sm $ ret

  --putStrLn "-->end"

getfactorial = (1:scanl1 (*) [1..])::[Int]
fac n=getfactorial !! n
getbinom n=[div (fac n) $ fac(i)*fac(n-i) | i<-[0..]]::[Int]
binom n m=(getbinom n)!!m

merge::Maybe a->Maybe a->Maybe a
merge Nothing  x = x
merge (Just x) _ = Just x

rev n s=filter (\x->not $ elem x s) [1..n]
sm (Just a)=foldl (\acc x->acc++(show x)++" ") "" $reverse a
sm Nothing =""

search::Int->Int->Int->[Int]->Maybe [Int]
search n i s use=
  if i==n
  then if s==0 then Just use else Nothing
  else foldl merge Nothing qaq
    where qwq=filter (\x->s>=x*binom (n-1) i) (rev n use)
          qaq=(\x->search n (i+1) (s-x*binom (n-1) i) (x:use))<$>qwq
```



### 0006 CF27E的haskell solution

关于怎么不使用共享可变状态表示当前可行解的情况下,如何表达最优性剪枝.

> 大概还是正常地写, 把当前最优解作为一个参数,再加一个参数表述当前尝试过的决策集合.
>
> ```haskell
> f::Parameters->[Decesion]->Answer->Answer
> f package used_decisions temporary_ans=?
> ```
> 
> 尝试决策d,深入搜索树,等从搜索树深层回来时,常规参数package不变,used加入d,当前最优解取个min,再调用自己.  
> 可用决策集合为空,决策全都扔进used里面的时候就返回当前最优解...

另外这里haskell中的`Prelude.Int`范围不够…

```haskell
import qualified Data.Set as QAQ
main::IO()
main=do
  line<-getLine
  let n=(read line)::Int
  putStrLn . show  $ dfs (n,1,0,n) QAQ.empty max_possible_ans

max_possible_ans=(10^18)

--dvs::Int->[Int]
dvs k=[y|y<- [2..k],0==k `mod` y,y<64]


--primes::[Int]
primes = sieve [2..]
  where sieve (x:xs)=(:) x $  sieve [y | y<-xs,0/=mod y x]

--getlog::Int->Int->Int
getlog 0 y=0
getlog x y=let x'=div x y in 1+getlog x' y

--pw::Int->Int->Int->Int
pw p q ans=if q>=getlog ans p
  then -1
  else
    raw_pw p q
    where raw_pw p 0=1
          raw_pw p q=p*raw_pw p (q-1)

--dfs::(Int,Int,Int,Int)->QAQ.Set Int->Int->Int
dfs (n,now,i,last) used ans=let dcs=[x|x<-dvs n,x `QAQ.notMember` used,x<=last] in
  if null dcs
  then (if n==1 then min ans now else ans)
  else let q=head dcs in let r=pw (primes!!i) (q-1) ans in
    if (r<0) || ((div ans r)<=now) then ans
    else
      let ans'=dfs (div n q,now*r,i+1,q) QAQ.empty ans
      in  dfs (n,now,i,last) (QAQ.insert q used) ans'
```

### 0007 请不要用加法举例子

对于许多定义在`Foldable` typeclass中的操作,初看难以理解其行为,这时候不少人会用加法举例,比如

```haskell
sumList::(Num a)=>[a]->a
sumList []=0
sumList (x:xs)=x+sumList(xs)

sumList s=foldl (+) 0 s
sumList =\s->foldl (+) 0 s
sumList = foldl (+) 0
```

然而这根本不make sense,我们看看那些fold的签名吧.看看这个`b->a->b`加法的`(+)::(Num a)=>a->a->a`太特殊了,加法有交换律,结合律,从左向右/从右向左都一样,并且加法的零元就是0太常见了,foldl的初值的作用没体现出来.
```haskell
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
foldl1 :: Foldable t => (a -> a -> a) -> t a -> a
foldr1 :: Foldable t => (a -> a -> a) -> t a -> a

scanl :: (b -> a -> b) -> b -> [a] -> [b]
scanl :: (b -> a -> b) -> b -> [a] -> [b]
```

fold函数实际上干的事情,应该是这样:给定一个初值作为累积器,指定一个可迭代对象,再给出一个累积函数将新遇到的东西加入到累积器中去. 我们看看一个靠谱的解释,它来自GHC document,它是这样说的.

```haskell
foldl f z [x1, x2, ..., xn] == (...((z `f` x1) `f` x2) `f`...) `f` xn`
scanl f z [x1, x2, ...] == [z, z `f` x1, (z `f` x1) `f` x2, ...]
last (scanl f z xs) == foldl f z xs.
```

这才是我想要的东西啊,它的行为一目了然.
