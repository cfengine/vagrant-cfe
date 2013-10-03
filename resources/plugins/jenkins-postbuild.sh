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

sudo -n $(dirname $0)/jenkins-postbuild2.sh
