
drawInputDataDistribution <- function(args){
	if(length(args)!=3){
		print("Usage: drawInput.r <input_data> <score_column_index> <out_file>")
	}
	else{
		data <- read.table(args[1], header=FALSE, sep="\t")
		x <- as.numeric(args[2])
		colnames(data)[x] <- "score"
		attach(data)
		p <- ggplot(data, aes(x=score)) + geom_density()		
		ggsave(args[3], p)
	}
}

library(ggplot2)
args <- commandArgs(trailingOnly = TRUE)
drawInputDataDistribution(args)
