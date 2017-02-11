Source-to-image for OSTree
==========================

Composing an OSTree for Atomic using source-to-image
This is part of a trial to automate BYO-Atomic in a different way.

Previously I have setup a build pipeline, which
  * composed
  * and publishes

the ostree using the GitLab CI Runners and Pages. This result is
published at [byo-atomic](https://gitlab.com/gbraad/byo-atomic).

I wanted to examine an alternative strategy... what if [s2i](https://blog.openshift.com/create-s2i-builder-image/)
was used... and it would be possible to target the archives:

  * https://github.com/centos/sig-atomic-buildscripts
  * https://pagure.io/fedora-atomic.git

with this build container? The result would be a tree that
can be hosted as static assets using either nginx or a 
trivial httpd instance.

Unfortunately this is currently not possible. OStree fails:

  * error: compose tree must presently be run as uid 0 (root)
  * Creating new namespace failed: Operation not permitted

and containers would have to run as non-root and privileged.

Hopefully, this could be possible in the future...


Usage
-----
```
$ make
$ s2i build https://pagure.io/fedora-atomic.git ostree-compose fedora-atomic-ostree
```


Authors
-------

| [!["Gerard Braad"](http://gravatar.com/avatar/e466994eea3c2a1672564e45aca844d0.png?s=60)](http://gbraad.nl "Gerard Braad <me@gbraad.nl>") |
|---|
| [@gbraad](https://twitter.com/gbraad)  |
