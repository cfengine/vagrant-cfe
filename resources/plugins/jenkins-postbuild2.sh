#!/bin/bash

# Must be run as root or you'll get errors...

# This is the fun part: we use the feature.cf policy to set a persistent jenkinsnotify class (90 million minutes == very long time)
# NOTE: this does NOT run the deployment policy!!!  It only sets a class which will be picked up in the next run
/var/cfengine/bin/cf-agent -I -f /var/cfengine/inputs/lib/3.5/feature.cf -b feature -Dfeature_set_90m_jenkinsnotify
