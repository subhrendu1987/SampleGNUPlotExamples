load "common.plot"
set terminal postscript eps enhanced dashed "Helvetica-Bold" fontfile "./font/Helvetica-Bold.pfb" 24 color
set key outside center top
##############################################################################################
PlotID=1

set size 2,2
unset key

unset xtics
unset ytics
set xrange [-.70:.70]
set yrange [-.70:.70]
unset colorbox
unset ylabel
unset border
set style textbox opaque noborder fillcolor rgb "#ffcc00"
set xlabel "Android Version Share"
set style fill solid 1.0 border -1

outFile='PieChart.eps'
set output outFile

# Set data file name
Datafile = "data/AndriodShare.tsv"


totalRows = system(sprintf("wc -l < %s", Datafile))
#print "Number of rows in the file:", totalRows

##########################################
pi = 3.141592653589793
ang(x)=2*pi*x/360.0        		# get angle gradian
perc2ang(x)=x*3.6 				# get deg from percentage
ang2deg(x)=x*360/pi 			# get deg from gradian
#######
label_x(r,theta)= r * cos(theta)
label_y(r,theta)= r * sin(theta)
midang(i,j)=(i+((j-i)/2))*3.6
##########################################


xCenter=0.0
yCenter=0.0
radius=.3
labelRadius=.6


# using x:y:radius:arc_begin_deg:arc_end_deg:color
plot \
	Datafile using (xCenter):(yCenter):(radius):($3*3.6):($4*3.6):(hsv2rgb($0/totalRows, 1, 1)) with circles lc rgb variable, \
		'' using (xCenter+label_x(radius,ang(midang($3,$4)))):(yCenter+label_y(radius,ang(midang($3,$4)))):((xCenter+label_x(labelRadius,ang(midang($3,$4))))-(xCenter+label_x(radius,ang(midang($3,$4)))))/1.5:((yCenter+label_y(labelRadius,ang(midang($3,$4))))-(yCenter+label_y(radius,ang(midang($3,$4)))))/1.5 with vectors linecolor rgb "black" filled head notitle,\
		'' using (xCenter+label_x(labelRadius,ang(midang($3,$4)))):(yCenter+label_y(labelRadius,ang(midang($3,$4)))):(sprintf("%s (%0.2f\%)", stringcolumn(2),$5)) with labels boxed notitle,\
	;



# 	'' using (xCenter+label_x(radius*1.75,ang(midang($3,$4)))):(yCenter+label_y(radius*1.75,ang(midang($3,$4)))):(sprintf("Pos=(%0.2f,%0.2f)", (xCenter+label_x(radius*1.75,ang(midang($3,$4)))),(yCenter+label_y(radius*1.75,ang(midang($3,$4)))))) with labels offset char 1,1 notitle,\