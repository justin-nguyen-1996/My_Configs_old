#!/usr/bin/expect

set timeout -1

spawn conda install numpy
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install scipy
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install pandas
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install scikit-learn
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install matplotlib
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install rasterio
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install gdal
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install fiona
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install shapely
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install affine
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install pyproj
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install geopandas
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install pillow
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install fftw
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install cython
expect "Proceed ?"
send "y\r"
expect "$ "

spawn conda install pyfftw
expect "Proceed ?"
send "y\r"
expect "$ "

