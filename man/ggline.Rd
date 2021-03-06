% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggline.R
\name{ggline}
\alias{ggline}
\title{Line plot}
\usage{
ggline(data, x, y, group = 1, color = "black", palette = NULL,
  linetype = "solid", plot_type = c("b", "l", "p"), size = 0.5,
  shape = 19, select = NULL, order = NULL, add = "none",
  add.params = list(), error.plot = "errorbar",
  ggtheme = theme_classic2(), ...)
}
\arguments{
\item{data}{a data frame}

\item{x, y}{x and y variables for drawing.}

\item{group}{grouping variable to connect points by line.
Allowed values are 1 (for one line, one group) or a character vector specifying
the name of the grouping variable (case of multiple lines).}

\item{color}{line colors.}

\item{palette}{the color palette to be used for coloring or filling by
groups. Allowed values include "grey" for grey color palettes; brewer
palettes e.g. "RdBu", "Blues", ...; or custom color palette e.g. c("blue",
"red"); and scientific journal palettes from ggsci R package, e.g.: "npg", "aaas", "lancet", "jco",
"ucscgb", "uchicago", "simpsons" and "rickandmorty".}

\item{linetype}{line type.}

\item{plot_type}{plot type. Allowed values are one of "b" for both line and point;
"l" for line only; and "p" for point only. Default is "b".}

\item{size}{Numeric value (e.g.: size = 1). change the size of points and outlines.}

\item{shape}{point shapes.}

\item{select}{character vector specifying which items to display.}

\item{order}{character vector specifying the order of items.}

\item{add}{character vector for adding another plot element (e.g.: dot plot
or error bars). Allowed values are one or the combination of: "none",
"dotplot", "jitter", "boxplot", "point", "mean", "mean_se", "mean_sd", "mean_ci",
"mean_range", "median", "median_iqr", "median_mad", "median_range"; see
?desc_statby for more details.}

\item{add.params}{parameters (color, shape, size, fill, linetype) for the
argument 'add'; e.g.: add.params = list(color = "red").}

\item{error.plot}{plot type used to visualize error. Allowed values are one
of c("pointrange", "linerange", "crossbar", "errorbar", "upper_errorbar",
"lower_errorbar", "upper_pointrange", "lower_pointrange",
"upper_linerange", "lower_linerange"). Default value is "pointrange" or "errorbar". Used
only when add != "none" and add contains one "mean_*" or "med_*" where "*"
= sd, se, ....}

\item{ggtheme}{function, ggplot2 theme name. Default value is theme_pubr().
Allowed values include ggplot2 official themes: theme_gray(), theme_bw(),
theme_minimal(), theme_classic(), theme_void(), ....}

\item{...}{other arguments to be passed to geom_dotplot.}
}
\description{
Create a line plot.
}
\details{
The plot can be easily customized using the function ggpar(). Read
  ?ggpar for changing: \itemize{ \item main title and axis labels: main,
  xlab, ylab \item axis limits: xlim, ylim (e.g.: ylim = c(0, 30)) \item axis
  scales: xscale, yscale (e.g.: yscale = "log2") \item color palettes:
  palette = "Dark2" or palette = c("gray", "blue", "red") \item legend title,
  labels and position: legend = "right" \item plot orientation : orientation
  = c("vertical", "horizontal", "reverse") }
}
\examples{
# Data
df <- data.frame(dose=c("D0.5", "D1", "D2"),
   len=c(4.2, 10, 29.5))
print(df)

# Basic plot
# +++++++++++++++++++++++++++
ggline(df, x = "dose", y = "len")


# Plot with multiple groups
# +++++++++++++++++++++

# Create some data
df2 <- data.frame(supp=rep(c("VC", "OJ"), each=3),
   dose=rep(c("D0.5", "D1", "D2"),2),
   len=c(6.8, 15, 33, 4.2, 10, 29.5))
print(df2)

# Plot "len" by "dose" and
# Change line types and point shapes by a second groups: "supp"
ggline(df2, "dose", "len",
  linetype = "supp", shape = "supp")


# Change colors
# +++++++++++++++++++++

# Change color by group: "supp"
# Use custom color palette
ggline(df2, "dose", "len",
   linetype = "supp", shape = "supp",
   color = "supp", palette = c("#00AFBB", "#E7B800"))


# Add points and errors
# ++++++++++++++++++++++++++

# Data: ToothGrowth data set we'll be used.
df3 <- ToothGrowth
head(df3, 10)

# It can be seen that for each group we have
# different values
ggline(df3, x = "dose", y = "len")

# Visualize the mean of each group
ggline(df3, x = "dose", y = "len",
 add = "mean")

# Add error bars: mean_se
# (other values include: mean_sd, mean_ci, median_iqr, ....)
# Add labels
ggline(df3, x = "dose", y = "len", add = "mean_se")

# Change error.plot to "pointrange"
ggline(df3, x = "dose", y = "len",
 add = "mean_se", error.plot = "pointrange")

# Add jitter points and errors (mean_se)
ggline(df3, x = "dose", y = "len",
 add = c("mean_se", "jitter"))

# Add dot and errors (mean_se)
ggline(df3, x = "dose", y = "len",
 add = c("mean_se", "dotplot"), color = "steelblue")

# Add violin and errors (mean_se)
ggline(df3, x = "dose", y = "len",
 add = c("mean_se", "violin"), color = "steelblue")

# Multiple groups with error bars
# ++++++++++++++++++++++

ggline(df3, x = "dose", y = "len", color = "supp",
 add = "mean_se", palette = c("#00AFBB", "#E7B800"))

# Add jitter
ggline(df3, x = "dose", y = "len", color = "supp",
 add = c("mean_se", "jitter"), palette = c("#00AFBB", "#E7B800"))

# Add dot plot
ggline(df3, x = "dose", y = "len", color = "supp",
 add = c("mean_se", "dotplot"), palette = c("#00AFBB", "#E7B800"))


}
\seealso{
\code{\link{ggpar}}, \code{\link{ggbarplot}}
}
