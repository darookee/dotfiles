#!/usr/bin/env python3
import re, os, sys

def get_authinfo(accountName):
    # lines have this format
    # account <accountName> machine <serveraddress> login <username> password <password> port <numericPort>
    s = "account %s machine ([^ ]*) login ([^ ]*) password ([^ ]*) port ([0-9]*)" % (accountName)
    p = re.compile(s)
    authinfo = os.popen("gpg -q --use-agent --batch --no-tty -d ~/.authinfo.gpg").read()
    return p.search(authinfo)

def mailpasswd(account):
    info = get_authinfo(account)
    return info.group(3)

def mailusername(account):
    info = get_authinfo(account)
    return info.group(2)

def mailhost(account):
    info = get_authinfo(account)
    return info.group(1)

def mailport(account):
    info = get_authinfo(account)
    return info.group(4)

if len(sys.argv) != 0:
    if sys.argv[1] == 'print':
        r = get_authinfo(sys.argv[2])
        if r:
            print(r.group(3))
