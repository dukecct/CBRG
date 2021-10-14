# # https://github.com/GuangchuangYu/hexSticker
#
# # e.g.
# library(tidyverse)
# library(ggimage)
# p <- ggplot(aes(x = mpg, y = wt), data = mtcars) + geom_point()
# p <- p + theme_void() + theme_transparent()
#
# library(hexSticker)
# hexSticker::sticker(p, package="hexSticker", p_size=20, s_x=1, s_y=.75, s_width=1.3, s_height=1, filename="inst/imgfile.png")
#
# # Make CBRG hex sticker
# golub_subjects <- read_csv("https://raw.githubusercontent.com/BAREJAA/website_for_john/master/datasets/golub_kaggle/golub_subjects.csv")
# gene_pval <- read_csv("https://raw.githubusercontent.com/BAREJAA/website_for_john/master/datasets/golub_kaggle/gene_pval.csv")
# golub_full <- golub_subjects %>%
#   inner_join(gene_pval, by = "gene_name")
# golub_full <- golub_full %>%
#   filter(!str_detect(gene_name, "AFFX"))
# golub_full <- golub_full %>%
#   mutate(neg_log_pval = -log10(p_val_adj)) %>%
#   mutate(log_fc = mean_ALL - mean_AML)
# p <- ggplot(golub_full, aes(log_fc, neg_log_pval)) +
#   geom_point(data = filter(golub_full, neg_log_pval > -log10(0.05), log_fc > log10(2)|log_fc < -log10(2)), colour = "#FF5733", size = 0.5, alpha = 0.5) +
#   geom_point(data = filter(golub_full, neg_log_pval <= -log10(0.05)), colour = "black", size = 0.5, alpha = 0.1) +
#   geom_point(data = filter(golub_full, log_fc <= log10(2), log_fc >= -log10(2)), colour = "black", size = 0.5, alpha = 0.1) +
#   geom_vline(xintercept = 0, size = 0.3) +
#   geom_vline(xintercept = log10(2), linetype = "dotted", colour = "#FF7F7F", size = 0.2) +
#   geom_vline(xintercept = -log10(2), linetype = "dotted", colour = "#FF7F7F", size = 0.2) +
#   #geom_hline(yintercept = -log10(0.05), linetype = "dotted", colour = "#FF7F7F", size = 0.2) +
#   labs(x = "",
#        y = "",
#        title = "",
#        subtitle = "",
#        caption = "") +
#   theme_void() + theme_transparent()
#
# hexSticker::sticker(p, package="CBRG", p_size=10, s_x=0.95, s_y=.85, s_width=1.3, s_height=1.5, filename="inst/imgfile.png")
