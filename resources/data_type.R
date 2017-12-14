#numeric数值型
x <- c(1:10)
mode(x)


#complex复数类型
x <- 100 + 1i
mode(x)


#logical逻辑型
x <- c(sample(1:10, 5))
x <- x==3
mode(x)


#character字符型
x <- 'bo.chen'
mode(x)
nchar(x)


#factor因子型
#因子就是分类变量
#在R中,如果把数字作为因子,那么在导入数据之后,需要将向量转换为因子(factor),
#而因子在整个计算过程中不再作为数值,而是一个"符号"而已.
x = 1:5
x = sample(x,size=5)
#x = sample(x,size=10)
#有放回抽取则
x <- sample(1:5, 10, replace=T)
x <- as.factor(x)
#因子类型很有用,其中的levels代表着你的因子的水平.即:去重以后的类别.
#在你处理数据集分类的时候就方便多了.当你改变你的因子level的时候,你会发现你的数据其实也跟着改变了如下:
levels(x)
#R语言中下标有1开始!
levels(x)[3] <- 't'
