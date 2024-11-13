load "common.plot"
set terminal postscript eps enhanced dashed "Helvetica-Bold" fontfile "./font/Helvetica-Bold.pfb" 24 color
set key outside center top
##############################################################################################
PlotID=1

set size 2,2
unset key
set palette rgb 30,31,32
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
#ang(x)=2*pi*x/360.0        		
ang(deg) = deg * pi / 180		# get gradian from deg
p2deg(x)=x*3.6 					# get deg from percentage
ang2deg(x)=x*180/pi 			# get deg from radian
p2rad(x)=2*pi*x/100 			# get gradian from percentage
#######
label_x(r,theta)= r * cos(theta)
label_y(r,theta)= r * sin(theta)
midang(i,j)=p2rad(i+((j-i)/2))
##########################################


xCenter=0.0
yCenter=0.0
radius=.3
labelRadius=.6


# using x:y:radius:arc_begin_deg:arc_end_deg:color
plot \
	Datafile using (xCenter):(yCenter):(radius):(p2deg($3)):(p2deg($4)):(hsv2rgb($0/totalRows, 1, 1)) with circles lc rgb variable, \
		'' using (xCenter+label_x(radius,midang($3,$4))):(yCenter+label_y(radius,midang($3,$4))):((xCenter+label_x(labelRadius,midang($3,$4)))-(xCenter+label_x(radius,midang($3,$4))))/1.5:((yCenter+label_y(labelRadius,midang($3,$4)))-(yCenter+label_y(radius,midang($3,$4))))/1.5 with vectors linecolor rgb "black" filled head notitle,\
		'' using (xCenter+label_x(labelRadius,midang($3,$4))):(yCenter+label_y(labelRadius,midang($3,$4))):(sprintf("%s (%0.2f\%)", stringcolumn(2),$5)) with labels boxed notitle,\
;



# 	'' using (xCenter+label_x(radius*1.75,ang(midang($3,$4)))):(yCenter+label_y(radius*1.75,ang(midang($3,$4)))):(sprintf("Pos=(%0.2f,%0.2f)", (xCenter+label_x(radius*1.75,ang(midang($3,$4)))),(yCenter+label_y(radius*1.75,ang(midang($3,$4)))))) with labels offset char 1,1 notitle,\

##############################################################################################
PlotID=2
set xrange [-1:1]
set yrange [-1:1]
set terminal postscript eps enhanced dashed "Helvetica-Bold" fontfile "./font/Helvetica-Bold.pfb" 10 color
outFile='debug.eps'
set output outFile
plot \
	Datafile using (xCenter+label_x(labelRadius,midang($3,$4))):(yCenter+label_y(labelRadius,midang($3,$4))):(sprintf("r, {/Symbol q} (%0.2f, %0.2f{/Symbol p}=%f{{\260}});\n x,y (%f,%f)", radius, midang($3,$4),ang2deg(midang($3,$4)), (xCenter+label_x(radius,midang($3,$4))),(yCenter+label_y(labelRadius,midang($3,$4))))) with labels boxed notitle,\
	'' using (xCenter+label_x(radius,midang($3,$4))):(yCenter+label_y(radius,midang($3,$4))):(sprintf("%.2f/100, %.2f{deg},%.2f/100",$3,midang($3,$4),$4)) with labels  notitle,\
	'' using (xCenter+label_x(radius,midang($3,$4))):(yCenter+label_y(radius,midang($3,$4))):((xCenter+label_x(labelRadius,midang($3,$4)))-(xCenter+label_x(radius,midang($3,$4))))/1.5:((yCenter+label_y(labelRadius,midang($3,$4)))-(yCenter+label_y(radius,midang($3,$4))))/1.5 with vectors linecolor rgb "black" filled head notitle,\
	;
