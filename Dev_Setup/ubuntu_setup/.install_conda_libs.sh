#!/usr/bin/expect

set timeout -1

spawn printf "\n=========================\ninstalling ipython\n=========================\n"
spawn conda install ipython
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling numpy\n=========================\n"
spawn conda install numpy
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling scipy\n=========================\n"
spawn conda install scipy
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling pandas\n=========================\n"
spawn conda install pandas
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling sklearn\n=========================\n"
spawn conda install scikit-learn
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling matplt\n=========================\n"
spawn conda install matplotlib
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling rasterio\n=========================\n"
spawn conda install rasterio
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling fiona\n=========================\n"
spawn conda install fiona
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling pyproj\n=========================\n"
spawn conda install pyproj
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling geopandas\n=========================\n"
spawn conda install geopandas
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling pillow\n=========================\n"
spawn conda install pillow
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling fftw\n=========================\n"
spawn conda install fftw
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling cython\n=========================\n"
spawn conda install cython
expect "Proceed ?"
send "y\r"
expect "$ "

spawn printf "\n=========================\ninstalling pyfftw\n=========================\n"
spawn conda install pyfftw
expect "Proceed ?"
send "y\r"
expect "$ "

