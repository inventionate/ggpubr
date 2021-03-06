#' @include utilities.R ggpar.R stat_chull.R stat_conf_ellipse.R
NULL
#' Text
#' @description Add text to a plot.
#' @inheritParams ggscatter
#' @param x,y x and y variables for drawing.
#' @param color point colors.
#' @param label the name of the column containing point labels. Can be also a
#'   character vector with length = nrow(data).
#' @param font.label a vector of length 3 indicating respectively the size
#'   (e.g.: 14), the style (e.g.: "plain", "bold", "italic", "bold.italic") and
#'   the color (e.g.: "red") of point labels. For example \emph{font.label =
#'   c(14, "bold", "red")}. To specify only the size and the style, use
#'   font.label = c(14, "plain").
#' @param label.select character vector specifying some labels to show.
#' @param repel a logical value, whether to use ggrepel to avoid overplotting
#'   text labels or not.
#' @param label.rectangle logical value. If TRUE, add rectangle underneath the
#'   text, making it easier to read.
#' @param ggp a ggplot. If not NULL, points are added to an existing plot.
#' @param ... other arguments to be passed to \code{\link[ggplot2]{geom_point}}
#'   and \code{\link{ggpar}}.
#' @details The plot can be easily customized using the function ggpar(). Read
#'   ?ggpar for changing: \itemize{ \item main title and axis labels: main,
#'   xlab, ylab \item axis limits: xlim, ylim (e.g.: ylim = c(0, 30)) \item axis
#'   scales: xscale, yscale (e.g.: yscale = "log2") \item color palettes:
#'   palette = "Dark2" or palette = c("gray", "blue", "red") \item legend title,
#'   labels and position: legend = "right"  }
#' @seealso \code{\link{ggpar}}
#' @examples
#' # Load data
#' data("mtcars")
#' df <- mtcars
#' df$cyl <- as.factor(df$cyl)
#' df$name <- rownames(df)
#' head(df[, c("wt", "mpg", "cyl")], 3)
#'
#' # Textual annotation
#' # +++++++++++++++++
#' ggtext(df, x = "wt", y = "mpg",
#'    color = "cyl", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
#'    label = "name", repel = TRUE)
#'
#' # Add rectangle around label
#' ggtext(df, x = "wt", y = "mpg",
#'    color = "cyl", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
#'    label = "name", repel = TRUE,  label.rectangle = TRUE)
#'
#'
#' @export
ggtext <- function(data, x, y,
                      color = "black",  palette = NULL,
                      size = 2, point = TRUE,
                      label = NULL,  font.label = c(12, "plain"),
                      label.select = NULL, repel = FALSE, label.rectangle = FALSE,
                      ggp = NULL, ggtheme = theme_classic2(),
                      ...)
{

  if(length(label) >1){
    if(length(label) != nrow(data))
      stop("The argument label should be a column name or a vector of length = nrow(data). ",
           "It seems that length(label) != nrow(data)")
    else data$label.xx <- label
    label <- "label.xx"
  }

  # label font
  font.label <- .parse_font(font.label)
  font.label$size <- ifelse(is.null(font.label$size), 12, font.label$size)
  font.label$color <- ifelse(is.null(font.label$color), color, font.label$color)
  font.label$face <- ifelse(is.null(font.label$face), "plain", font.label$face)

  if(is.null(ggp)) p <- ggplot(data, aes_string(x, y))
  else p <- ggp

  # Add textual annotation
  # ++++++
  alpha <- 1
  if(!is.null(list(...)$alpha)) alpha <- list(...)$alpha

  if(!is.null(label)) {
    lab_data <- data
    # Select some labels to show
    if(!is.null(label.select))
      lab_data  <- subset(lab_data, lab_data[, label, drop = TRUE] %in% label.select,
                          drop = FALSE)

    if(repel){
      ggfunc <- ggrepel::geom_text_repel
      if(label.rectangle) ggfunc <- ggrepel::geom_label_repel
        p <- p + .geom_exec(ggfunc, data = lab_data, x = x, y = y,
                          label = label, fontface = font.label$face,
                          size = font.label$size/3, color = font.label$color,
                          alpha = alpha,
                          box.padding = unit(0.35, "lines"),
                          point.padding = unit(0.3, "lines"),
                          force = 1)
    }
    else{
      ggfunc <- geom_text
      vjust  <- -0.7
      if(label.rectangle) {
        ggfunc <- geom_label
        vjust <- -0.4
        }
      p <- p + .geom_exec(ggfunc, data = lab_data, x = x, y = y, color = color,
                          label = label, fontface = font.label$face,
                          size = font.label$size/3, color = font.label$color,
                          vjust = vjust, alpha = alpha)
    }
  }
  p <- ggpar(p, palette = palette, ggtheme = ggtheme, ...)
  p
}




