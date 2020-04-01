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

```
stack --version (ver>=2.1.3)
stack new project-name
cd ./new-project
stack setup
stack build

stack ghc
stack ghci
stack runghc
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





##随笔

> 这里会记录一些学习中遇到的有趣的例子.
>
> 笔记这种东西,不用记得多么详细,
> 精简到只剩下足以推导出其他一切东西的基础公理和推理方式.



HS的类型系统是非常强大的,但是有时候你不得不指定类型,比如读入一个string,转换成integer.

```haskell
-- read::(Read a)->String->a
(read::[Char]->Int) "1926"  -- specify the type of read
(read "3.1415926")::Double  -- specify the type of the result of read,at let the complier decide the type of function read
```



一个有趣的程序,模仿它的样子,我们也可以在Haskell中做运算符重载

```haskell
main::IO()
main=putStrLn $ show $ (let 2*-3="NSML" in 2*-3)
# -> NMSL
```



一个效率非常低的素数筛…

```haskell
import Data.List
primes_leq m = sieve [2..m]
  where
    sieve (x:xs) = x : sieve (xs \\ [x,x+x..m])
    sieve [] = []
p_leq_100 = primes_leq 100
```



一个写得非常垃圾的排序,以及对于惰性求值的测试.
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



hs中简单的记忆化搜索,因为没有副作用,不能实时更新数据结构,那就只好把数据结构带着扔进参数列表里面,每次换一个了…大概就这样,效率很低…对于参数多的,试试Data.Map

```haskell
fib n=solve n 0 1  where
  solve 0 a b =a
  solve n a b =solve (n-1) b (a+b)
```

