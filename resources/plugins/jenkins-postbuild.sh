#!/bin/bash

if [ -z "$NODE_NAME" -o -z "$JOB_NAME" -o -z "$BUILD_TAG" ]; then
    echo "NODE_NAME JOB_NAME BUILD_TAG must be defined.  Exiting..."
    exit 1
fi

NOW=$(date '+%s')
umask 077

TMPFILE=/tmp/jenkins-postbuild
echo '#!/bin/bash' > $TMPFILE

# Note you may want to filter further if you don't want the environment to leak out to CFEngine
printenv | /bin/grep '^[A-Z]' | /bin/sed 's/^/echo "=/; s/$/"/' >> $TMPFILE
echo "echo \"=BUILD_TIME=$NOW\"" >> $TMPFILE
echo 'echo "+jenkins_module_loaded"' >> $TMPFILE
chmod 700 $TMPFILE

# This is the fun part: we use the feature.cf policy to set a persistent jenkinsnotify class (90 million minutes == very long time)
# NOTE: this does NOT run the deployment policy!!!  It only sets a class which will be picked up in the next run

sudo -n /var/cfengine/bin/cf-agent -I -f /var/cfengine/inputs/lib/3.5/feature.cf -b feature -Dfeature_set_90m_jenkinsnotify
