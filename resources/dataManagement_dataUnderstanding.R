subject_name <- c("John Doe","Jane Doe","Steve Graves")
temperature <- c(98.1, 98.6, 101.4)
flu_status <- c(FALSE, FALSE, TRUE)

temperature[2]
temperature[2:3]
temperature[-2]
temperature[c(TRUE,TRUE,FALSE)]

gender <- factor(c("MALE","MALE","FEMALE"))
gender
blood <- factor(c("O","AB","A"),levels = c("A","B","AB","O"))
blood

subject_name[1]
temperature[1]
flu_status[1]
gender[1]
blood[1]

subject1 <- list(fullname = subject_name[1],
                 temperature = temperature[1],
                 flu_status = flu_status[1],
                 gender = gender[1],
                 blood = blood[1])
subject1
subject1[2]
subject1$temperature
subject1[c("temperature","flu_status")]

# 数据框
pt_data <- data.frame(subject_name, temperature, flu_status, gender, blood, stringsAsFactors = FALSE)
pt_data
pt_data$subject_name
pt_data[c("temperature","flu_status")]

pt_data[1,2]
pt_data[c(1,3),c(2,4)]
pt_data[,1]
pt_data[1,]
pt_data[,]

pt_data[c(1,3),c("temperature","gender")]
pt_data[-2,c(-1,-3,-5)]

x <- subject_name
y <- subject1
z <- pt_data
save(x,y,z, file="mydata.RData")
load("mydata.RData")

pt_data <- read.csv("pt_data.csv", stringsAsFactors=FALSE)
#pt_data <- read.csv("pt_data.csv", stringsAsFactors=FALSE, header=FALSE)

write.csv(pt_data, file="pt_data2.csv")

str(pt_data)
summary(pt_data$temperature)
summary(pt_data[c("gender","temperature")])

model_table <- table(pt_data$gender)
pmt <- prop.table(model_table)
round(pmt, digits=2)

plot(x = pt_data$temperature, y = pt_data$flu_status,
     main = "Temperature vs. Flu",
     xlab = "温度",
     ylab = "感冒")

# R语言通过ODBC链接MYSQL数据库
mydb <- odbcConnect("localhost", uid="root", pwd="123123")
sqlTables(mydb)
students <- sqlQuery(mydb,"select * from Student")
students[1,2]
temp <- sqlFetch(mydb,"Student",rownames = "id")
odbcClose(mydb)

