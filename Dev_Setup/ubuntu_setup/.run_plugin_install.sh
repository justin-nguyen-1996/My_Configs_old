#!/usr/bin/expect

set timeout -1

spawn vim -c ":PluginInstall" -c ":qa"
expect "$ "
send "\r"

