
# temp.sh

vim -c ":silent! %s/export PATH=\"\/home\/jusnguy\/miniconda2\/bin:\$PATH\"/\
export PATH=\"\/home\/jusnguy\/miniconda2\/bin:\$PATH\"\r/g" ~/.profile
