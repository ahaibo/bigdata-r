insurance <- read.csv("insurance.csv", stringsAsFactors = TRUE)
str(insurance)

#既然因变量是charges,我们就来看一下它是如何分布的
summary(insurance$charges)
hist(insurance$charges)

table(insurance$region)
cor(insurance[c("age","bmi","children","charges")])
pairs(insurance[c("age","bmi","children","charges")])

library("psych")
pairs.panels(insurance[c("age","bmi","children","charges")])

ins_model <- lm(charges ~ age + children + bmi + sex + smoker + region, data=insurance)
ins_model <- lm(charges ~ . , data=insurance)
ins_model
summary(ins_model)

insurance$age2 <- insurance$age^2
insurance$bmi30 <- ifelse(insurance$bmi >= 30, 1, 0)

ins_models <- lm(charges ~ age + age2 + children + bmi + sex + bmi30*smoker + region , data=insurance)
summary(ins_models)
