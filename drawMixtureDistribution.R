
drawMixtureDistribution <- function(args){
	if(length(args)!=5){
		print("Usage: drawPredictedDistribution.r <CCR mean> <CCR std> <OCR mean> <OCR std> <out_dir>")
	}
	else{
		nor_mean <- as.numeric(args[1])
		nor_std <- as.numeric(args[2])
		ndr_mean <- as.numeric(args[3])
		ndr_std <- as.numeric(args[4])
		
		nor_alpha <- ((1-nor_mean) / nor_std^2 - 1/nor_mean)*nor_mean^2
		nor_beta <- nor_alpha * (1/nor_mean -1)
		
		ndr_alpha <- ((1-ndr_mean) / ndr_std^2 - 1/ndr_mean)*ndr_mean^2
		ndr_beta <- ndr_alpha * (1/ndr_mean -1)
		
		x <- rbeta(7000, nor_alpha, nor_beta)
		y <- rbeta(3000, ndr_alpha, ndr_beta)
		
		Score <- c(x,y)
		ClassNOR <- rep.int("NOR", 7000)
		ClassNDR <- rep.int("NDR", 3000)
		Class <- c(ClassNOR, ClassNDR)
		
		d <- data.frame(Score, Class)
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
		ggsave(paste(args[5], 'mixture.pdf', sep='/'), p)
	}
}

library(easyGgplot2)
args <- commandArgs(trailingOnly = TRUE)
drawMixtureDistribution (args)
