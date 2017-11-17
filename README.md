# VASPpng
Massive generation of figures from VASP structures using XCrySDen

# Requirements
* v2xsf, by Jens Kunstmann 
* XCrySDen 
* imagemagick 

# Warnings 
* Do NOT put comments in the printing.tcl file.
* Use an intelligent label system if you are managing large volumes of information. 

# Instructions

1. Collect in one folder all the POSCAR/CONTCAR files you want to convert into images. They should have a .vasp extension.  

2. If you are working with surfaces, you may want to eliminate the bottom layer before generating the figure. 
   For example, in a Cu(111) 3x3 slab with 4 layers, you may remove the 9 atoms in the bottom: 
   $ for j in `ls *.vasp` ; do sed -i "10,18d"     $j ; done
   And then reduce the 36 Cu atoms for 27: 
   $ for j in `ls *.vasp` ; do sed -i "7s/36/27/g" $j ; done

3. Convert POSCAR/CONTCAR to *.xsf
   $ for j in `ls *.vasp` ; do v2xsf $j ; done

4. Run figures.sh provided in this repository. 
   If you put it into the working folder: 
   $ . ./figures.sh
   If you put it into the bin folder: 
   $ figures.sh 

5. Run XCrySDen:
   $ xcrysden -s printing.tcl
   
6. You may want to make white areas transparent. Also, you can crop the figure or convert them into other formats: 
   for j in *.png ; do echo $j ; convert -transparent white $j $j ; done
   for j in *.png ; do echo $j ; convert -trim $j $j ; done
   for j in *png ; do echo $j ; convert -density 600 $j ${j%%.png}.eps ; done
   for j in *eps ; do echo $j ; convert -density 600 $j ${j%%.eps}.png ; done
   
# Interpreting the script

You can set the size of the window with the command below. Notice that a bigger window size imply a larger and heavier image.
   scripting::displayWindow resize 800 1000

You can change the colors of your atoms. The example shows H, C, O and Pt (Z=1,6,8,78) and colors white (1.00 1.00 1.00 RGB), gray, red and light green:
  xc_newvalue .mesa 8  1 1.000000 1.000000 1.000000
  xc_newvalue .mesa 8  6 0.250000 0.250000 0.250000
  xc_newvalue .mesa 8  8 1.000000 0.000000 0.000000
  xc_newvalue .mesa 8 78 0.800000 1.000000 0.800000

To change the size of the ball for each element, you have this part:
  xc_newvalue .mesa 4  1 0.90000
  xc_newvalue .mesa 4  6 2.05000
  xc_newvalue .mesa 4  8 1.80000
  xc_newvalue .mesa 4 78 3.55000

The quality of the texture can be adjusted with the tessellation factor. Use low values (20) for fast screening, tests, and images of internal use. Use large values (99) for publication-quality images.
  set myParam(TESSELLATION)      20.00

To colour the borders of the supercell in black:
  set myParam(FRAMECOL)          { 0.00 0.00 0.00 }

Set the background color as white to be printer-friendly.
  set myParam(BACKGROUND)        { 1.00 1.00 1.00 }

Build a 1×1×1 supercell
  scripting::buildCrystal 1 1 1 

Play with these parameters in order to focus your cell at your wish:
  scripting::rotate x 90
  scripting::zoom 2

