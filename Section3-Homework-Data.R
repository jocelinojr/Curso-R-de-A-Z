#Data
revenues <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#Solution

# Profit for each month (revenue - expenses)
profits <- revenues - expenses


# tax
taxes <- round(profits * 0.3, 2)
taxes

# profit after tax for each month
profits.after.tax <- profits - taxes
profits.after.tax

# profit margin for each monthn (in %)
profits.margin <- round(profits.after.tax /revenues, 2) * 100
profits.margin

avg.profit.tax <- mean(profits.after.tax) 
avg.profit.tax

# good months
good.months <- profits.after.tax > avg.profit.tax
bad_months  <- profits.after.tax < avg.profit.tax

# Extra
months.my <- c("jan", "fev", "mar", "abr", "mai","jun", "jul", "ago", "set", "out", "nov", "dez")

months.my[good.months]
good.months

bad.months <- !good.months
bad.months
# not in the exercise
months.my[bad.months]


# The  best month
best.month <- (profits.after.tax ==  max(profits.after.tax))
best.month
# The worst month
worst.month <- (profits.after.tax ==min(profits.after.tax))

revenues.1000 <- round(revenues/1000)
expenses.1000 <- round(revenues/1000)
profits.1000 <- round(profits/1000)
profits.after.tax.1000 <- round(profits.after.tax/1000)

M <- rbind(revenues.1000,
           expenses.1000,
           profits.1000,
           profits.after.tax.1000,
           good.months,
           bad.months,
           best.month,
           worst.month)
M
