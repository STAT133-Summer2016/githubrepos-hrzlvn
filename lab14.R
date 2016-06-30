dat <- read.csv("EconomistData.csv")
library(dplyr)
library(tidyr)
library(readr)
library(stringr)
library(lubridate)
library(ggplot2)
library(ggrepel)
library(grid)
library(gridExtra)


pc1 <- ggplot(dat, aes(x = CPI, y = HDI, color = Region))
pc1 + geom_point()
(pc2 <- pc1 +
  geom_smooth(aes(group = 1),
              method = "lm",
              formula = y ~ log(x),
              se = FALSE,
              color = "red")) +
  geom_point()
df2 <- data.frame(x = 1:5 , y = 1:25, z = 1:25)
s <- ggplot(df2, aes(x = x, y = y))
s + geom_point(aes(shape = z), size = 4) + scale_shape_identity()
s + geom_point(aes(shape = z), size = 4, colour = "Red") +
  scale_shape_identity()
s + geom_point(aes(shape = z), size = 4, colour = "Red", fill = "Black") +
  scale_shape_identity()
pc2 +
  geom_point(shape = 1, size = 4)
(pc3 <- pc2 +
  geom_point(size = 4.5, shape = 1) +
  geom_point(size = 4, shape = 1) +
  geom_point(size = 3.5, shape = 1))
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")
(pc4 <- pc3 +
  geom_text(aes(label = Country),
            color = "gray20",
            data = subset(dat, Country %in% pointsToLabel)))
pc3 +
  geom_text_repel(aes(label = Country),
                  color = "gray20",
                  data = subset(dat, Country %in% pointsToLabel),
                  force = 10)
dat$Region <- factor(dat$Region,
                     levels = c("EU W. Europe",
                                "Americas",
                                "Asia Pacific",
                                "East EU Cemt Asia",
                                "MENA",
                                "SSA"),
                     labels = c("OECD",
                                "Americas",
                                "Asia &\nOceania",
                                "Central &\nEastern Europe",
                                "Middle East &\nnorth Africa",
                                "Sub-Saharan\nAfrica"))
pc4$data <- dat
pc4
library(grid)
(pc5 <- pc4 +
  scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                     limits = c(.9, 10.5),
                     breaks = 1:10) +
  scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                     limits = c(0.2, 1.0),
                     breaks = seq(0.2, 1.0, by = 0.1)) +
  scale_color_manual(name = "",
                     values = c("#24576D",
                                "#099DD7",
                                "#28AADC",
                                "#248E84",
                                "#F2583F",
                                "#96503F")) +
  ggtitle("Corruption and Human development"))

(pc6 <- pc5 +
  theme_minimal() +
  theme(text = element_text(color = "gray20"),
        legend.position = c("top"), 
        legend.direction = "horizontal",
        legend.justification = 0.1,
        legend.text = element_text(size = 11, color = "gray10"),
        axis.text = element_text(face = "italic"),
        axis.title.x = element_text(vjust = -1), 
        axis.title.y = element_text(vjust = 2), 
        axis.ticks.y = element_blank(), 
        axis.line = element_line(color = "gray40", size = 0.5),
        axis.line.y = element_blank(),
        panel.grid.major = element_line(color = "gray50", size = 0.5),
        panel.grid.major.x = element_blank()
  ))
(mR2 <- summary(lm(HDI ~ log(CPI), data = dat))$r.squared)
png(file = "images/econScatter10.png", width = 800, height = 600)
pc6 
grid.text("Sources: Transparency International; UN Human Development Report",
          x = .02, y = .03,
          just = "left",
          draw = TRUE)
grid.segments(x0 = 0.81, x1 = 0.825,
              y0 = 0.90, y1 = 0.90,
              gp = gpar(col = "red"),
              draw = TRUE)
grid.text(paste0("R² = ",
                 as.integer(mR2*100),
                 "%"),
          x = 0.835, y = 0.90,
          gp = gpar(col = "gray20"),
          draw = TRUE,
          just = "left")

dev.off()