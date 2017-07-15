#!/usr/bin/expect

set timeout -1

spawn git clone git@github.com:justin-nguyen-1996/My_Configs.git
expect "Are you sure ?"
send "yes\r"
expect "$ "

