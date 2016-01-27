Vagrant environments
====================

This is repository with test environments I use for some tests or even development tasks. Usualy I place the git clones in the share folder and work inside the vagrant environments to avoid project specific things on my host system and to ensure I do not influence something by any configuration of my host system.

This environments are created with Vagrant and support two providers: docker and virtualbox.

Environment list
================

 - centos-7-64 - Centos 7 base image
 - ubuntu-14.04-64 - Ubuntu 14.04 base image

How to use
==========

```bash
cd centos-7-64
# select docker as provider
vagrant up --provider=docker
# select virtualbox as provider
vagrant up --provider=virtualbox
```

You can add some local settings by creating `vagrant.local.rb`. Content of this file is evaluated in scope of `Vagrant.configure`. Example:

```ruby
# Add another synced_folder
config.vm.synced_folder '../../another-share', '/home/vagrant/another-share'
```

Contributions
=============

Please use [GitHub Pull requests][github_pullreq] for this.

License and copyright
=====================
Copyright 2015 Artem Sidorenko and contributors.

See the COPYRIGHT file at the top-level directory of this distribution
and at https://github.com/artem-sidorenko/vagrant-environments/blob/master/COPYRIGHT

[github_pullreq]: https://help.github.com/articles/using-pull-requests
