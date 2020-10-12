
drawPredictedDistribution <- function(args){
	if(length(args)!=1){
		print("Usage: drawPredictedDistribution.r <input_data>")
	}
	else{
		d <- read.table(args[1], header=TRUE, sep="\t")
		attach(d)
		p <- ggplot2.density(data=d, xName='Score', groupName='Class',
    	showLegend=TRUE,
    	groupColors=c('#000000','#339999'),
    	linetype="solid", lwd=2,
    	backgroundColor="white",
    	xtitle="\nGCH methylation score", ytitle="Density\n", 
    	xtitleFont=c(32,"bold", "#000000"),
    	xtitlePosition=c(0,0),
    	ytitleFont=c(32, "bold", "#000000"),
    	xTickLabelFont=c(28,"bold", "#000000"),
    	yTickLabelFont=c(28,"bold", "#000000"),
    	xlim=c(0,1),
    	addMeanLine=TRUE, 
    	meanLineColor="#990000",
    	meanLineSize=2,
    	meanLineType="dotted",
    	legendTitle="",
    	legendTextFont=c(20, "bold", "black"),
    	removePanelGrid=TRUE,removePanelBorder=TRUE,
    	axisLine=c(0.5, "solid", "black"),
    	alpha=0.5) + theme(legend.key = element_blank(), legend.margin = unit(-1, "cm"))
		ggsave(paste(args[1], 'dist', 'pdf', sep='.'), p)
	}
}

library(easyGgplot2)
args <- commandArgs(trailingOnly = TRUE)
drawPredictedDistribution(args)
