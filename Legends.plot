load "common.plot"
set terminal postscript eps enhanced dashed "Helvetica-Bold" fontfile "./font/Helvetica-Bold.pfb" 24 color
#set output 'plotSysParam.eps'
#set size 6,1
set key outside center top
#set key horiz
##############################################################################################
PlotID=2
set terminal postscript eps enhanced dashed "Helvetica-Bold" fontfile "./font/Helvetica-Bold.pfb" 11 color
set key Right
#set origin 0,0
set size 1,1
set style fill solid 0.95 border -1
set bars 1.0
set style boxplot outliers pointtype 7
set style data boxplot

outFile='Legends.eps'
set output outFile
#set title ""
#set xrange [0 : 16]
#set yrange [0 : 16]
imgSep=.3
ZERO=1
#set ytics 1

#set xtics rotate by -90

# Set data file name
BeeGuardDatafile = "data/TimeComponentsBeeGuard.tsv"
NormalDatafile = "data/TimeComponentsNormal.tsv"
#################
#plot BeeGuardDatafile  using ($1-imgSep)*2:0:($3):($4):::xticlabels(2) with candlesticks fill pattern 1 title "BeeGuard: KVStore" ls 21 whiskerbars;
#plot "TimeComponentsBeeGuard.csv" using ($1):3:4:4:4:xticlabels(2) with candlesticks fill pattern 1 title "BeeGuard: KVStore" ls 21 whiskerbars;
#################
set multiplot
set size 4,1
set origin 0,0
set key outside left top
#set key at screen 2.95,1.45
#set xtics rotate by -90
set key title font "Helvetica-Bold, 13"
set key title "BeeGuard Without KVStore (BG)"
#unset key
# Disable the axis
unset border
unset xtics
unset ytics
unset xlabel
unset ylabel
set key outside left top
set key at screen .05,1
#set key box
plot \
    BeeGuardDatafile every ::1 using ($1):($1-$1) with boxes fill pattern 1 title "BG: Total Prog Load" ls 21, \
    '' every ::1 using ($1):($1-$1) with boxes fill pattern 2 title "BG: Verification" ls 26, \
    '' every ::1 using ($1):($1-$1) with boxes fill pattern 3 title "BG: Policy" ls 29, \
    '' every ::1 using ($1):($1-$1) with boxes fill pattern 3 title "BG: Signature" ls 22;
##################
set origin 0,0
set key title "BeeGuard With KVStore (BG')"
set key outside center top
set key at screen .45,1
plot \
	BeeGuardDatafile every ::1 using ($1):($1-$1) with boxes fill pattern 1 notitle ls 25,\
	'' using ($1):($1-$1) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1):($1-$1) with boxes fill pattern 1 title "BG': Total Prog Load" ls 21,\
	'' using ($1):($1-$1) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1):($1-$1) with boxes fill pattern 2 title "BG': Verification" ls 26,\
	'' using ($1):($1-$1) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1):($1-$1) with boxes fill pattern 4 title "BG': KVStore" ls 26,\
	'' using ($1):($1-$1) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1):($1-$1) with boxes fill pattern 3 title "BG': Signature" ls 22;

##################
set origin 0,0
set key title "Unmodified (UN)"
set key outside right top
set key at screen .80,.97
plot \
	NormalDatafile every ::1 using ($1):($1-$1) with boxes fill pattern 3 notitle "Unmodified: Total Prog Load" ls 21,\
	'' using ($1):($1-$1) with boxes fill pattern 1 title "UN: Total Prog Load" ls 27,\
	'' using ($1):($1-$1) with boxes fill pattern 3 notitle "UN: Verification" ls 21,\
	'' using ($1):($1-$1) with boxes fill pattern 3 title "UN: Verification" ls 28;
##################
set origin 0,0
set key outside right top
set key at screen .95,.95
set key title ""

plot \
	NormalDatafile every ::1 using ($1):($1-$1) with boxes title "Std. Dev. ({/Symbol s})" fill pattern 3 ls 21;;
unset multiplot



#### Sample Comment
if (1 == 2) {
###################################
plot BeeGuardDatafile every ::1 using ($1):($1-$1):xticlabels(2) with boxes fill pattern 1 notitle ls 25,\
	'' using ($1-imgSep):($3+$4+$5+$6+$9+$10+$11+$12+$13+$14+1):(sprintf("BG")) with labels notitle,\
	'' using ($1-imgSep):($3+$4+$5+$6+$9+$10+$11+$12+$13+$14) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1-imgSep):($3+$4+$5+$6+$9+$10+$11+$12+$13) with boxes fill pattern 1 notitle "BeeGuard: Total Prog Load" ls 21,\
	'' using ($1-imgSep):($3+$4+$5+$6+$9+$10+$11+$12) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1-imgSep):($3+$4+$5+$6+$9+$10+$11) with boxes fill pattern 2 notitle "BeeGuard: Verification" ls 26,\
	'' using ($1-imgSep):($3+$4+$5+$6+$9+$10) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1-imgSep):($3+$4+$5+$6+$9) with boxes fill pattern 3 notitle "BeeGuard: Policy" ls 29,\
	'' using ($1-imgSep):($5+$6) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1-imgSep):5 with boxes fill pattern 3 notitle "BeeGuard: Signature" ls 22,\
	BeeGuardDatafile every ::1 using ($1):($3+$4+$5+$6+$7+$8+$11+$12+$13+$14+1):(sprintf("BG'")) with labels notitle,\
	'' using ($1):($3+$4+$5+$6+$7+$8+$11+$12+$13+$14) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1):($3+$4+$5+$6+$7+$8+$11+$12+$13) with boxes fill pattern 1 notitle "BeeGuard: Total Prog Load" ls 21,\
	'' using ($1):($3+$4+$5+$6+$7+$8+$11+$12) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1):($3+$4+$5+$6+$7+$8+$11) with boxes fill pattern 2 notitle "BeeGuard: Verification" ls 26,\
	'' using ($1):($3+$4+$5+$6+$7+$8) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1):($3+$4+$5+$6+$7) with boxes fill pattern 4 notitle "BeeGuard: KVStore" ls 26,\
	'' using ($1):($5+$6) with boxes fill pattern 3 notitle "SD" ls 21,\
	'' using ($1):5 with boxes fill pattern 3 notitle "BeeGuard: Signature" ls 22,\
	NormalDatafile every ::1 using ($1+imgSep):($3+$4+$5+$6+1):(sprintf("UN")) with labels notitle,\
	'' using ($1+imgSep):($3+$4+$5+$6) with boxes fill pattern 3 notitle "Unmodified: Total Prog Load" ls 21,\
	'' using ($1+imgSep):($3+$4+$5) with boxes fill pattern 1 notitle "Unmodified: Total Prog Load" ls 27,\
	'' using ($1+imgSep):($3+$4) with boxes fill pattern 3 notitle "Unmodified: Verification" ls 21,\
	'' using ($1+imgSep):($3) with boxes fill pattern 3 notitle "Unmodified: Verification" ls 28,\
	[-1:1] ZERO with boxes notitle "{/Symbol s}" fill pattern 3 ls 21;
}