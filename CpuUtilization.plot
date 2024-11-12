load "common.plot"
set terminal postscript eps enhanced dashed "Helvetica-Bold" fontfile "./font/Helvetica-Bold.pfb" 24 color
#set output 'plotSysParam.eps'
#set size 6,1
set key outside center top
set key horiz
##############################################################################################
PlotID=1
##############################################################################################
PlotID=1
set key Right
#set origin 0,0
set size 1,1
set style fill solid 0.95 border -1
set bars 1.0
set style boxplot outliers pointtype 7
set style data boxplot
set boxwidth .3
outFile='CpuUtlization.eps'
set output outFile
#set title ""
set xlabel "eBPF Program ID"
set ylabel "CPU Utilization (\%)"
set xrange [0 : *]
set yrange [0 : *]
imgSep=.2
ZERO=0.01
set ytics 0.25



# Set data file name
Datafile = "data/CPUNormal.tsv"
BeeGuardDatafile = "data/CPUBeeGuard.tsv"
#NormalDatafile = "data/CPUNormal.tsv"

set size 1.5,1
set origin 0,0
#set xtics 1
set xtics rotate by -90



#################
#plot BeeGuardDatafile  using ($1-imgSep)*2:0:($3):($4):::xticlabels(2) with candlesticks fill pattern 1 title "BeeGuard: KVStore" ls 21 whiskerbars;
#plot "TimeComponentsBeeGuard.csv" using ($1):3:4:4:4:xticlabels(2) with candlesticks fill pattern 1 title "BeeGuard: KVStore" ls 21 whiskerbars;
#################
plot Datafile every ::1 using ($1):($1-$1):xticlabels(2) with boxes fill pattern 1 notitle ls 25,\
	'' using ($1-imgSep):($3+$4) with boxes fill pattern 3 title "{{/Symbol s}}" ls 21,\
	'' using ($1-imgSep):($3) with boxes fill pattern 4 title "Unmodified" ls 29,\
	BeeGuardDatafile using ($1+imgSep):($3+$4) with boxes fill pattern 3 notitle "{{/Symbol s}}" ls 21,\
	'' using ($1+imgSep):($3) with boxes fill pattern 1 title "BeeGuard" ls 21,\


#	[-1:1] ZERO with boxes title " " ls 25 lw 0,\
#####################################################

xOffset=.05*(GPVAL_DATA_X_MAX-GPVAL_DATA_X_MIN)
yOffset=.1*(GPVAL_DATA_Y_MAX-GPVAL_DATA_Y_MIN)
set xrange [GPVAL_DATA_X_MIN-xOffset:GPVAL_DATA_X_MAX+xOffset]
set yrange [GPVAL_DATA_Y_MIN:GPVAL_DATA_Y_MAX+yOffset]
set output outFile
replot;
##############################################################################################
