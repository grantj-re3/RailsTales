# How to install rails for the Hartl RoR Tutorial book

## Purpose

I wanted to install Ruby, Bundler & Rails on an [old] Fedora 25 Linux
operating system compatible with the book
[Ruby on Rails Tutorial, 6th Ed. by Michael Hartl](https://www.railstutorial.org/book/beginning).
I wanted to do this rather than use the AWS Cloud9 platform suggested
in the book.

I am documenting the procedure here so that I have the *principles*
available for next time. This might also be useful for those trying
to do something similar for other operating systems in the same family
with a conservative release strategy (such as Centos 7 or RHEL 7).

The book says it is using:

- Ruby 2.6.3
- Bundler 2.2.13
- Rails 6.1.3

so I want to install and use *exactly* those versions!

***Warning:*** The install instructions below assume that you either
trust the development teams for rbenv, Node.js, etc. or that you are
happy to review the source code, particularly for commands like:

```
$ git clone ...
```

or

```
$ curl ... | bash
```


## Instructions

These instructions are based on Centos 7 instructions given in the References section
and so use rbenv to install the desired version of Ruby (rather than Ruby Version Manager, RVM).

All commands to be run by an *unprivileged* (non-root) user unless otherwise stated.


### High level install procedure

- Install rbenv, Ruby and Rails dependencies
- Install rbenv
- Install Ruby 2.6.3
- Configure .gemrc
- Install Bundler 2.2.13 gem
- Install Rails 6.1.3 gem
- Install Node.js


### Install rbenv, Ruby and Rails dependencies

I had several of the dependencies below installed already (I checked
with *rpm -qa |egrep PACKAGE_NAME*) so I only installed those packages
I didn't have.

As root:

```
dnf install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
```


### Install rbenv

As an unprivileged user (i.e. under your login):

```
$ cd
$ git clone git://github.com/sstephenson/rbenv.git .rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
$ exec $SHELL

$ git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
$ echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
$ exec $SHELL
```

rbenv doesn't seem to be visible to my bash shell (even after *exec $SHELL* above) unless I do:

```
$ source ~/.bash_profile
```

Check rbenv was installed ok.

```
$ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
```


### Install Ruby 2.6.3

```
$ source ~/.bash_profile
```

Experiment...

```
$ rbenv versions
$ rbenv version
$ rbenv which ruby
$ ruby -v
$ set |egrep RBENV
RBENV_SHELL=bash
```

Select a version

```
$ rbenv install -L |egrep 2.6.3
2.6.3
```

Install and use the new version

```
$ rbenv install 2.6.3
$ rbenv shell 2.6.3     # ...or you may prefer "rbenv global 2.6.3"
```

Checking...

```
$ rbenv versions
  system
* 2.6.3 (set by RBENV_VERSION environment variable)
$ ruby -v
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]

$ which gem
~/.rbenv/shims/gem
$ gem env home
~/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0
```


### Configure .gemrc

From RoRTut6 book:

```
echo "gem: --no-document" >> ~/.gemrc
```


### Install Bundler 2.2.13 gem

- Confirm the bundler gem already installed is not the version we want.
- See which (remote) bundler versions are available.
- Install the desired version, 2.2.13.
- Confirm both versions are installed now.

```
$ gem list bundler
*** LOCAL GEMS ***
bundler (default: 1.17.2)

$ gem list ^bundler$ --remote --all
*** REMOTE GEMS ***
bundler (2.2.14, 2.2.13, 2.2.12, ...

$ gem install bundler -v 2.2.13
$ rbenv rehash    # Deprecated?

$ gem list bundler

*** LOCAL GEMS ***

bundler (2.2.13, default: 1.17.2)
```

Note: The default bundler version (1.17.2) can't be changed and
shouldn't be removed. However in our case, this is not a problem
as running *rails \_6.1.3\_ new APP_NAME* as per the RoRTut6 book
causes the latest version of bundler (2.2.13) to be invoked.


### Install Rails 6.1.3 gem

- Install rails
- Check that rails will run (and output its version number)
- Check that the local rails gem also shows the expected version number

```
$ gem install rails -v 6.1.3
$ rbenv rehash    # Deprecated?

$ rails -v
Rails 6.1.3

$ gem list ^rails$

*** LOCAL GEMS ***

rails (6.1.3)
```


### Install Node.js

I attempted to install Node.js using 3 different methods but the only
one which was successful and provided the version required (>=10.17.0)
was via NVM.

As an unprivileged user (i.e. under your login):

- Install NVM.

```
$ curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
```

- Ensure your xterm can see the newly installed NVM.
- Show all the Node.js versions available remotely.
- Install the latest stable LTS (Long Term Support) version. In our case, the version must be 10.17.0 or higher.
- Verify by asking *node* to show its version.

```
$ source ~/.bashrc	# Or in my case, opened new xterm
$ nvm ls-remote
    ...
    v14.16.0   (Latest LTS: Fermium)
$ nvm install v14.16.0
    ...
    Now using node v14.16.0 (npm v6.14.11)
    Creating default alias: default -> v14.16.0

$ node -v
v14.16.0
```


### Verify that rails is working

I have provided a script [railsenv.sh](bin/railsenv.sh) (in the bin folder) which helps
verify that the items above are installed ok. You should run it as
the same unprivileged user who installed rbenv, ruby, etc.

Also, verify that *rails new* works ok. For example, from the RoRTut6 book:

```
$ mkdir ~/environment
$ cd ~/environment
$ rails _6.1.3_ new hello_app

```


## References

1. https://www.railstutorial.org/book/beginning
2. https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-centos-7
3. https://github.com/rbenv/rbenv
4. https://github.com/rbenv/rbenv-gem-rehash
5. https://tecadmin.net/install-latest-nodejs-on-fedora/
6. https://tecadmin.net/install-nodejs-with-nvm/

