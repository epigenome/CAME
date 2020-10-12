#!/bin/bash

if (( $# < 2 ))
then
	echo USAGE: input_bed output_prefix ocr
	exit -1
fi

pdir=`dirname $0`
in=$1
out=$2
outdir=`dirname $out`
if [ ! -z $3 ]
then
	ocr="-o 1"
fi

if [ ! -e "$in" ]
then
	echo Not found $in
	exit -2
fi

if file $in | grep 'gzip compressed' >/dev/null
then
	nin=/tmp/$(basename $in .gz)
	echo "gunzip -c $in > $nin"
	gunzip -c $in > $nin || exit $?
	in=$nin
fi

outfile=$outdir/`basename $in`.pdf
echo Rscript $pdir/drawInput.R $in 5 $outfile
Rscript $pdir/drawInput.R $in 5 $outfile || exit $?

outfile=$out.bed
echo java -jar $pdir/came-0.0.1.jar $ocr $in $outfile
java -jar $pdir/came-0.0.1.jar $ocr $in $outfile || exit $?

if [ ! -e "$outfile" ]
then
	echo Rscript $pdir/drawMixtureDistribution.R 0.1 0.1 0.9 0.1 $outdir/mixture.pdf
	Rscript $pdir/drawMixtureDistribution.R 0.1 0.1 0.9 0.1 $outdir || exit $?
fi

if [ -e "$outfile.pred" ]
then
	echo Rscript $pdir/drawPredictedDistribution.R $outfile.pred
	Rscript $pdir/drawPredictedDistribution.R $outfile.pred || exit $?
fi

echo Rscript $pdir/drawScatterPlot.R $outfile
Rscript $pdir/drawScatterPlot.R $outfile || exit $?

if [[ "$nin" != "" ]]
then
	rm $nin
fi

