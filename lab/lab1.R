# Part 1
scored <- c(14, 14, 9, 14, 28, 13, 13, 24, 17, 6, 24, 0, 24, 13, 26, 14)
against <- c(19, 30, 16, 38, 31, 24, 23, 30, 41, 13, 20, 52, 13, 31, 24, 47)
scored[7]
scored[1:5]
scored[c(FALSE, TRUE)]
scored[length(scored)]
scored[scored > 14]
scored[scored == 14]
scored[scored == 14 | scored == 13]
scored[scored > 7 && scored < 21]
sort(scored, decreasing = TRUE)
max(scored)
min(scored)
mean(scored)
summary(scored)
length(scored[scored > 20])

# Part 2
scored[7] + against[7]
scored[(length(scored) - 4) :length(scored)] + against[(length(against) - 4) :length(against)] 
abs(scored[c(TRUE, FALSE)] - against[c(TRUE, FALSE)])
which(scored > against)
length(which(scored == against))