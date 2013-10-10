# Installing Jenkins

`vagrant up -- --type=single_centos_jenkins`

Redhat/CentOS only.

Note this overrides the 80 -> 8080 forwarding we do for Mission Portal.  With Jenkins we forward 8080 to 8080.

# Post-install steps

The default policy will synchronize `${WORKSPACE}/myartifacts` into
`/var/tmp/deployment` (as an example).

To create something useful in `{WORKSPACE}/myartifacts`, add a build
step shell call to do `/usr/bin/rsync -a --delete /etc/rc.d
${WORKSPACE}/myartifacts`.  Again, this is just an example of a copy.

Install the PostBuildScript Plugin (https://wiki.jenkins-ci.org/display/JENKINS/PostBuildScript+Plugin, available from the Jenkins plugin configuration screen)

For your project, add a post-build shell (not a script path) to call `/vagrant/resources/plugins/jenkins-postbuild.sh`

This script calls `sudo /var/cfengine/bin/cf-agent`.  You'll need to give the `jenkins` user permission to run it, e.g.

```
(grep /var/cfengine/bin/cf-agent /etc/sudoers | grep jenkins) || echo 'jenkins ALL=(ALL) NOPASSWD: /var/cfengine/bin/cf-agent' >> /etc/sudoers
```

(but please, use visudo or the Design Center sudoers sketch to do this
properly or talk to your friendly sysadmin)

# Verify that it works

In the console output for your build, you should see something like this:

```
2013-10-03T17:53:12+0000     info: Using command line specified bundlesequence
2013-10-03T17:53:12+0000   notice: R: feature: feature_set_90m_jenkinsnotify => SET class 'jenkinsnotify for '90m'
2013-10-03T17:53:12+0000   notice: R: feature: have jenkinsnotify
```

That indicates that the `jenkinsnotify` class was set correctly.

In the CFEngine agent output, using the `velocity2013` policy from [fill in final URL], you should see:

```
2013-10-03T18:18:28+0000     info: Executing 'no timeout' ... '/tmp/jenkins-postbuild'
2013-10-03T18:18:28+0000     info: Completed execution of '/tmp/jenkins-postbuild'
2013-10-03T18:18:28+0000     info: Executing 'no timeout' ... '/usr/bin/rsync -a --delete /var/lib/jenkins/jobs/test/workspace/myartifacts /var/tmp/deployment'
2013-10-03T18:18:28+0000     info: Completed execution of '/usr/bin/rsync -a --delete /var/lib/jenkins/jobs/test/workspace/myartifacts /var/tmp/deployment'
2013-10-03T18:18:28+0000   notice: R: Deployment script enabled
2013-10-03T18:18:28+0000   notice: R: The build succeeded recently!  Deploying from /var/lib/jenkins/jobs/test/workspace to /var/tmp/deployment
2013-10-03T18:18:28+0000   notice: R: The build was deployed successfully to /var/tmp/deployment
```

If the deployment was not attempted (e.g. the sudo command didn't
work) or the deployment was already made successfully you'll see:

```
2013-10-03T18:18:02+0000     info: Executing 'no timeout' ... '/tmp/jenkins-postbuild'
2013-10-03T18:18:02+0000     info: Completed execution of '/tmp/jenkins-postbuild'
2013-10-03T18:18:02+0000   notice: R: Deployment script enabled
2013-10-03T18:18:02+0000     info: Recording promise valuations
```

That indicates that the policy knows about the deployment but the
`jenkinsnotify` class wasn't set.  That class is cleared upon a
successful deployment.
