#!/usr/bin/expect -f

ssh-keygen -t rsa -b 4096 -C "2014justinnguyen@gmail.com"
set timeout -1
expect "$ "
send "\r"

# expect -c "$ " -c "send \"\n\""
