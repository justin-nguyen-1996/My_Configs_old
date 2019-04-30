#!/usr/bin/expect

# set timeout -1

# spawn printf "\n=========================\ninstalling ipython\n=========================\n"
# spawn conda install ipython
# expect "Proceed ?"
# send "y\r"
# expect "$ "

pip install ipython
pip install ipdb
pip install numpy
pip install scipy
pip install pandas
pip install scikit-learn
pip install matplotlib
pip install jupyter

