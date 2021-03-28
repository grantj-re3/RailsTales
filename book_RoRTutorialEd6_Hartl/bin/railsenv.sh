#!/bin/sh
# Usage:  railsenv.sh
#
# Run a few commands to confirm we have the expected Ruby on Rails environment.
##############################################################################
cat <<-END_MSG
	Show Rails environment
	----------------------
	You may need to run one of the following:
	- cd  my_rails_project
	- rbenv  shell|local|global
	- .  ~/.bash_profile
END_MSG

cmds=`cat <<-END_CMDS
	rbenv versions
	rbenv which ruby

	ruby -v
	which gem
	gem env home

	rails -v
	bundler -v
	node -v
END_CMDS`

echo "$cmds" |
  while read cmd; do
    [ "$cmd" = "" ] && continue
    echo
    echo "COMMAND: $cmd"
    eval $cmd
  done

