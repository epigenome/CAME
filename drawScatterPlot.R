
drawScatterPlot <- function(args){
	if(length(args)!=1){
		print("Usage: drawInput.r <input_data>")
	}
	else{
		data <- read.table(args[1], header=FALSE, sep="\t")
		score <- data$V5
		length <- data$V6
		pdf(paste(args[1], 'scatter', 'pdf', sep='.'), w=300, h=200)
		plot(score, length, xlab="Average Methylation Score", ylab="Length", xlim=c(0,1))
		graphics.off()
	}
}

args <- commandArgs(trailingOnly = TRUE)
drawScatterPlot(args)
