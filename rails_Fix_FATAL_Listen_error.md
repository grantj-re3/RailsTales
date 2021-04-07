# Fix for "FATAL: Listen error: unable to monitor directories for changes"

I'm a Ruby on Rails newbie... but not a Linux newbie.


## The problem

After using rails 6 for a few days, the size of my project became bigger
and I started to frequently get the error:

```
FATAL: Listen error: unable to monitor directories for changes.
Visit https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers for info on how to fix this.
```

when attempting to run a rails command like:

```
$ rails server
$ rails console
$ rails test
$ rails generate ...
$ rails db:migrate
```


## The solution


### Option 1: Disable Spring using a shell environment variable

The solution below worked for me under Fedora Linux.

This seems like a reasonable solution if you are following
a rails tutorial or similar situation and you would rather
not make your own alterations to the Gemfile.

Firstly, stop any spring processes which are running.

```
$ cd TOP_FOLDER_OF_RAILS_PROJECT
$ bin/spring stop
```

Set the environment variable to prevent spring from running
every time you run a rails command. For example:

```
$ DISABLE_SPRING=1 rails server
$ DISABLE_SPRING=1 rails console
$ DISABLE_SPRING=1 rails test
$ DISABLE_SPRING=1 rails generate ...
$ DISABLE_SPRING=1 rails db:migrate
```
Alternatively, set the environment variable in your bash
profile so that you can run your rails commands as usual.

```
echo "DISABLE_SPRING=1; export DISABLE_SPRING" >> ~/.bash_profile
```

Then to read the bash profile:
- restart your xterm, or
- logout/login, or
- source it with:

```
$ source ~/.bash_profile  # Long version, or
$ . ~/.bash_profile       # short version (dot)
```

Then celebrate!


### Option 2: Increasing the amount of inotify watchers

I did *not* attempt this solution.

Firstly, the link in the error message is broken. The new link appears
to be:
https://github.com/guard/listen/blob/master/README.md#increasing-the-amount-of-inotify-watchers

- This solution assumes you have sudo or root access.
- I understand it does not work in some environments such as Docker.


### Option 3: Remove Spring from your rails project

I did *not* attempt this solution.

Follow the instructions at
https://github.com/rails/spring#removal

