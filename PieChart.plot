load "common.plot"
set terminal postscript eps enhanced dashed "Helvetica-Bold" fontfile "./font/Helvetica-Bold.pfb" 24 color
set key outside center top
##############################################################################################
PlotID=1

#set origin 0,0
set size 2,2
#set style fill solid 0.95 border -1
#set bars 1.0

outFile='PieChart.eps'
set output outFile

# Set data file name
Datafile = "data/AndriodShare.tsv"
unset key
unset border
set xtics 0.25
set ytics 0.25
set xrange [0:1]
set yrange [0:1]
unset colorbox
unset ylabel
set xlabel "Android Version Share"
set style fill solid 1.0 border -1


totalRows = system(sprintf("wc -l < %s", Datafile))
#print "Number of rows in the file:", totalRows

# Initialize a variable to hold the cumulative sum
cusum = 0

pi = 3.141592653589793
ang(x)=2*pi*x/360.0        		# get angle (grades)
perc2ang(x)=x*3.6 				# get deg from percentage
label_x(r,theta)= r * cos(theta)
label_y(r,theta)= r * sin(theta)
midang(i,j)=(i+((j-i)/2))*3.6


xCenter=0.5
yCenter=0.5
radius=.3


# using x:y:radius:arc_begin_deg:arc_end_deg:color
plot \
	Datafile using (xCenter):(yCenter):(radius):($3*3.6):($4*3.6):(hsv2rgb($0/totalRows, 1, 1)) with circles lc rgb variable, \
	'' using (xCenter+label_x(radius*1.5,ang(midang($3,$4)))):(yCenter+label_y(radius*1.5,ang(midang($3,$4)))):(sprintf("%s (%0.0f\%)", stringcolumn(2),$5)) with labels offset char 1,1 notitle,\
	;



#plot \
#	Datafile using (0):(0):(1):(Ai):(Ai=Ai+ang($2)):(i=i+1) with circle linecolor var;

#	,\
#    Datafile u (1.5):(yi=yi+0.5/STATS_records):($1) w labels,\
#    Datafile u (1.3):(yi2=yi2+0.5/STATS_records):(j=j+1) w p pt 5 ps 2 linecolor var,\
#    Datafile u (mid=Bi+ang($2)*pi/360.0, Bi=2.0*mid-Bi, 0.5*cos(mid)):(0.5*sin(mid)):(sprintf('%.0f (%.1f\%)', $2, perc($2))) w labels;