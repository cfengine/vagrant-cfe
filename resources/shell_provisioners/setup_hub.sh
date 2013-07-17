#!/bin/bash -x

echo setting up MongoDB phpcfengine/usersettings

/var/cfengine/bin/mongo phpcfengine --eval 'db.usersettings.insert({ "username" : "admin", "gitServer" : "/var/tmp/masterfiles.git", "gitEmail" : "root@thissystem.com", "gitAuthor" : "The Root Account", "gitBranch" : "master" })'
install -d -m 0755 -o apache /opt/cfengine/userworkdir
install -d -m 0755 -o apache /opt/cfengine/userworkdir/admin
install -d -m 0755 -o apache /opt/cfengine/userworkdir/admin/.ssh
install -m 0600 -o apache /vagrant/resources/shell_provisioners/id_rsa /opt/cfengine/userworkdir/admin/.ssh/id_rsa.pvt
chown -R apache:apache /opt/cfengine/userworkdir
