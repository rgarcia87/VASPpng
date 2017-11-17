#!/bin/bash
# By: Rodrigo García-Muelas 
# Suitable for VASP 5.x 
# First review:  July 10, 2012 
# Current version: November 17, 2017 
# 
#
# Notes:
# 1. The input files should be *.vasp
# 2. Requires v2xsf conversor <--- Available on VASP webpage.
# 3. Inspired by a similar creation from David Karhanek.
# 4. Remember to write in the terminal: for j in `ls *.vasp` ; do v2xsf $j ; done
#
# remove old tcl scripts (this section needs to be fix)
if [ -e epsprinting.tcl ] ; then echo "removing old epsprinting.tcl" ; rm -f epsprinting.tcl ; fi
#
# comprobates if you have *.xsf.gz files
if [ -z `ls *.vasp.xsf.gz` ] ; then 
echo "Please execute: "
echo "for j in \`ls *.vasp\` ; do sed -i "7s/48/36/g" \$j ; sed -i "10,21d" \$j ; done"
echo "for j in \`ls *.vasp\` ; do v2xsf \$j ; done" 
echo "All your POSCAR's should have .vasp extension"
exit
fi 
#
# Note: you can use: "resize 640 480" or "resize 800 1000" or "resize 640 480", etc. Limit around 4000.

#####################
# Loop for side view:
for i in `ls *.vasp.xsf.gz`
do   
cat >>epsprinting.tcl<<!
scripting::open --xsf $i
scripting::displayWindow resize 800 800
xc_newvalue .mesa 8  0 1.000000 1.000000 1.000000
xc_newvalue .mesa 8  1 1.000000 1.000000 1.000000
xc_newvalue .mesa 8  3 1.000000 1.000000 0.500000
xc_newvalue .mesa 8  5 0.670000 0.330000 0.000000
xc_newvalue .mesa 8  6 0.250000 0.250000 0.250000
xc_newvalue .mesa 8  7 0.000000 0.000000 1.000000
xc_newvalue .mesa 8  8 1.000000 0.000000 0.000000
xc_newvalue .mesa 8  9 0.000000 1.000000 0.000000
xc_newvalue .mesa 8 26 1.000000 0.930000 0.870000
xc_newvalue .mesa 8 27 0.870000 0.930000 1.000000
xc_newvalue .mesa 8 28 0.800000 1.000000 1.000000
xc_newvalue .mesa 8 29 1.000000 0.920000 0.880000
xc_newvalue .mesa 8 30 0.900000 0.900000 0.900000
xc_newvalue .mesa 8 44 1.000000 0.800000 1.000000
xc_newvalue .mesa 8 45 1.000000 0.800000 1.000000
xc_newvalue .mesa 8 46 0.900000 0.900000 1.000000
xc_newvalue .mesa 8 47 0.933333 0.933333 0.933333
xc_newvalue .mesa 8 48 1.000000 0.880000 0.920000
xc_newvalue .mesa 8 75 1.000000 0.950000 0.850000
xc_newvalue .mesa 8 76 1.000000 0.900000 0.900000
xc_newvalue .mesa 8 77 1.000000 0.800000 1.000000
xc_newvalue .mesa 8 78 0.900000 1.000000 0.900000
xc_newvalue .mesa 8 79 1.000000 1.000000 0.800000
xc_newvalue .mesa 4  1 0.90000
xc_newvalue .mesa 4  3 0.90000
xc_newvalue .mesa 4  5 1.50000
xc_newvalue .mesa 4  6 2.05000
xc_newvalue .mesa 4  7 1.90000
xc_newvalue .mesa 4  8 1.80000
xc_newvalue .mesa 4  9 1.70000
xc_newvalue .mesa 4 26 3.10000
xc_newvalue .mesa 4 27 3.05000
xc_newvalue .mesa 4 28 2.95000
xc_newvalue .mesa 4 29 2.95000
xc_newvalue .mesa 4 30 2.95000
xc_newvalue .mesa 4 44 3.55000
xc_newvalue .mesa 4 45 3.47000
xc_newvalue .mesa 4 46 3.40000
xc_newvalue .mesa 4 47 3.45000
xc_newvalue .mesa 4 48 3.50000
xc_newvalue .mesa 4 75 3.55000
xc_newvalue .mesa 4 76 3.55000
xc_newvalue .mesa 4 77 3.55000
xc_newvalue .mesa 4 78 3.55000
xc_newvalue .mesa 4 79 3.55000
scripting::displayMode3D BallStick
set myParam(TESSELLATION)      20.00
set myParam(COV_SCALE)          1.25
set myParam(FRAMECOL)         { 0.00 0.00 0.00 } 
set myParam(BACKGROUND)       { 1.00 1.00 1.00 }
scripting::load_myParam
scripting::display off crystal-cells 
scripting::displayMode3D BallStick
scripting::display as cell-unit symm
scripting::buildCrystal 1 1 1
xc_translparam set 0 0 1 
scripting::rotate x 90
scripting::zoom 2
scripting::printToFile ${i%\.vasp.xsf.gz}_s.png

!
done

# Loop for top view:
for i in `ls *.vasp.xsf.gz`
do                              # resize 640 480
cat >>epsprinting.tcl<<!
scripting::open --xsf $i
scripting::displayWindow resize 800 800
xc_newvalue .mesa 8  0 1.000000 1.000000 1.000000
xc_newvalue .mesa 8  1 1.000000 1.000000 1.000000
xc_newvalue .mesa 8  3 1.000000 1.000000 0.500000
xc_newvalue .mesa 8  5 0.670000 0.330000 0.000000
xc_newvalue .mesa 8  6 0.250000 0.250000 0.250000
xc_newvalue .mesa 8  7 0.000000 0.000000 1.000000
xc_newvalue .mesa 8  8 1.000000 0.000000 0.000000
xc_newvalue .mesa 8  9 0.000000 1.000000 0.000000
xc_newvalue .mesa 8 26 1.000000 0.930000 0.870000
xc_newvalue .mesa 8 27 0.870000 0.930000 1.000000
xc_newvalue .mesa 8 28 0.800000 1.000000 1.000000
xc_newvalue .mesa 8 29 1.000000 0.920000 0.880000
xc_newvalue .mesa 8 30 0.900000 0.900000 0.900000
xc_newvalue .mesa 8 44 1.000000 0.800000 1.000000
xc_newvalue .mesa 8 45 1.000000 0.800000 1.000000
xc_newvalue .mesa 8 46 0.900000 0.900000 1.000000
xc_newvalue .mesa 8 47 0.933333 0.933333 0.933333
xc_newvalue .mesa 8 48 1.000000 0.880000 0.920000
xc_newvalue .mesa 8 75 1.000000 0.950000 0.850000
xc_newvalue .mesa 8 76 1.000000 0.900000 0.900000
xc_newvalue .mesa 8 77 1.000000 0.800000 1.000000
xc_newvalue .mesa 8 78 0.900000 1.000000 0.900000
xc_newvalue .mesa 8 79 1.000000 1.000000 0.800000
xc_newvalue .mesa 4  1 0.90000
xc_newvalue .mesa 4  3 0.90000
xc_newvalue .mesa 4  5 1.50000
xc_newvalue .mesa 4  6 2.05000
xc_newvalue .mesa 4  7 1.90000
xc_newvalue .mesa 4  8 1.80000
xc_newvalue .mesa 4  9 1.70000
xc_newvalue .mesa 4 26 3.10000
xc_newvalue .mesa 4 27 3.05000
xc_newvalue .mesa 4 28 2.95000
xc_newvalue .mesa 4 29 2.95000
xc_newvalue .mesa 4 30 2.95000
xc_newvalue .mesa 4 44 3.55000
xc_newvalue .mesa 4 45 3.47000
xc_newvalue .mesa 4 46 3.40000
xc_newvalue .mesa 4 47 3.45000
xc_newvalue .mesa 4 48 3.50000
xc_newvalue .mesa 4 75 3.55000
xc_newvalue .mesa 4 76 3.55000
xc_newvalue .mesa 4 77 3.55000
xc_newvalue .mesa 4 78 3.55000
xc_newvalue .mesa 4 79 3.55000
scripting::displayMode3D BallStick
set myParam(TESSELLATION)      20.00
set myParam(COV_SCALE)          1.25
set myParam(FRAMECOL)         { 0.00 0.00 0.00 } 
set myParam(BACKGROUND)       { 1.00 1.00 1.00 }
scripting::load_myParam
scripting::display on crystal-cells 
scripting::displayMode3D BallStick
scripting::display as cell-unit symm
scripting::buildCrystal 1 1 1
xc_translparam set 0 0 1 
scripting::zoom 2
scripting::printToFile ${i%\.vasp.xsf.gz}_t.png 

!
done

echo "Now run XCrySDen in script mode: xcrysden -s epsprinting.tcl"
