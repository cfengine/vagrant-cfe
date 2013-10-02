#!/bin/bash -x

echo setting up Jenkins

yum remove java
yum install -y java-1.6.0-openjdk

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
sudo service jenkins restart
