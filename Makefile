#!/bin/bash
all:
	gnuplot CpuUtilization.plot
	gnuplot Legends.plot
	gnuplot PieChart.plot
grey:
	gs -sOutputFile=TimeComponents-eps-converted-to.greyscale.pdf -dEmbedAllFonts=true -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray  -dCompatibilityLevel=1.4  -dNOPAUSE  -dBATCH TimeComponents-eps-converted-to.pdf
	gs -sOutputFile=Legends-eps-converted-to.greyscale.pdf -dEmbedAllFonts=true -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray  -dCompatibilityLevel=1.4  -dNOPAUSE  -dBATCH Legends-eps-converted-to.pdf

clean:
	rm *.eps	
