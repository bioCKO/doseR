#' @title dafsFilter Function to filter expression data within an object.
#' @description This function filters the expression of the supplied
#' object, by invoking the dafsFilter (dafs) function. dafsFilter is a
#' filtering function used to remove rows (genes) of various expression data.
#' @usage dafsFilter(se, PLOT=TRUE)
#' @param se A SummarizedExperiment object.
#' @param PLOT Boolean, toggles plotting.
#' @details This function filters the expression of the supplied object
#' using a Data Adaptive Flag filter. The internal function uses a vector
#' to store Kolmogorov Smirnov distance statistics, loops through cuts of
#' the data to determine targeted K-S statistic, selects data greater than
#' a quantile and runs Mclust on that data to determine theoretical
#' distribution. The wrapper uses simpleFilter to determine first left-most
#' local minima (using the Earth library).
#' @return Returns an invisible, filtered SummExp object.
#' @examples
#' library(mclust)
#' data(hmel.se)
#' f_se <- dafsFilter(se)
#' @author AJ Vaestermark, JR Walters.
#' @references BMC Bioinformatics, 2014, 15:92

dafsFilter <- function(se, PLOT=TRUE) {

VEC1 <- rowMeans( assays(se)$rpkm )

cutoff <- dafs (VEC1, PLOT)

invisible(   simpleFilter(se, mean_cutoff=2^cutoff, counts=FALSE    )    )

}
