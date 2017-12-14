#先来说说本节常用函数
#生成一个顺序序列seq
1:10
seq(1,10)
seq(1,10,by=2)
seq(1,10,length.out=6)
#查看帮助
?seq


#生成一个随机数序列rnorm,sample
#生成服从标准正态分布的随机变量
x <- rnorm(100)
plot(x,type='l')
#从1到20的序列中随机无重复抽样的10个数
x <- sample(1:20,10)


#数据结构
#Vector向量
#R数据挖掘以及机器学习模型大部分都直接操作向量.
#所以向量也是R里面直接支持的数据结构;
#这里的向量指的都是列向量;


#创建向量
x_numberic <- sample(1:10,5)
x_character <- c('mon','tue','wed','thu','fri')
x_logical <- x_numberic == 5
#这样我们就生成了三个类型得向量,分别是numeric型的,
#一种是character型的,另一种是logical型.


#向量的属性以及访问
names(x_numberic)
names(x_numberic) <- x_character
x_numberic[1]
#R语言的下标都是从1开始的
x_numberic[1] <- 10
x_numberic[1]


#向量的操作
sum(x_numberic)
min(x_numberic)
max(x_numberic)
sort(x_numberic) 
sort(x_numberic,decreasing=T) 
summary(x_numberic)
#summary可以给出数据集的概括,即最小值,第一四分位数,中位数,均值,第三四分位素,最大值,根据这些概括你可以对该数据集有更加深入的了解.
x = 1:5
x[-2]
x[-(2:4)]


#向量间的运算
y <- c(x,x)
y <- x^2 + 1
y <- c(x_numberic,x_numberic + rnorm(5))
mean(y)
#如果我们想得到每个日期标签的分类均值怎么办呢,
#方法当然是有的,并且很方便如下:
tapply(y,names(y),mean)
which(x_numberic == 10)
subset(x_numberic,x_numberic==10)
#当我们有一个子集,想要知道你子集中的元素是否在你的目标集合中包含的时候该如何做呢
c(10,5) %in% x_numberic
#运算符%in%可以帮你轻松完成
#前面介绍了向量的排序sort那么要想反转一个集合而不用排序方法那就看看下面这个方法吧
rev(x_numberic)
#去重
unique(x_numberic)


#多个向量有哪些方便得运算方式呢
x <- c(sample(1:100,7))
y <- c(sample(1:100,7))
z <- c(sample(1:100,7))
#现在我们得到了三个数字类型得向量,我们希望找到每个向量第一个维度的值里面得最小值,和最大值怎么办呢
pmin(x,y,z)
pmax(x,y,z)
#其实我们还可以有别的方法
apply(rbind(x,y,z),2,min)


#最后咱们也来一个布朗运动的轨迹图:
n=100;x=cumsum(rnorm(n));y=rnorm(n); plot(x,y,type="b",col="red")
