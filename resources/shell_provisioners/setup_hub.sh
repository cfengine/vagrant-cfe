#!/bin/bash -x

echo setting up MongoDB phpcfengine/usersettings

/var/cfengine/bin/mongo phpcfengine --eval 'db.usersettings.insert({ "username" : "admin", "gitServer" : "/var/tmp/masterfiles.git", "gitEmail" : "root@thissystem.com", "gitAuthor" : "The Root Account", "gitBranch" : "master" })'
install -m 0600 -o apache id_rsa /opt/cfengine/userworkdir/admin/.ssh/id_rsa.pvt
