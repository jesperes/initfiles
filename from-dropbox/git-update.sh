#!/bin/bash

#
# Utility script for updating/committing with git-svn.  The script
# does the following:
# 
# - Stash any uncommitted work
#
# - Rebase the satellite-branch for the current branch. This is the
#   branch where I push incoming changes from my laptop to.
#
# - Fetch/rebase incoming subversion changes
#
# - Rebase the satellite-branch again, if there has been any new svn
#   revisions.
#
# - Pop the stash
#

# set -e
# set -x
branch=$1
if [ -z "$branch" ]; then
    branch=`git branch | grep "*" | cut -d' ' -f2`
fi

echo Using branch \"$branch\"

scripthome=$(cd $(dirname "$0"); pwd)
satellite=satellite/$branch
svnremote=svn
svnhead=$(basename $(git config --get svn-remote.$svnremote.fetch | cut -d: -f2))
svnurl=$(git config --get svn-remote.$svnremote.url)

stashname=MERGE_SATELLITE

if git stash list | grep $stashname; then
    echo "Stash $stashname already exists. Exiting."
    exit 1
fi

# Merges/fast-forwards revisions in $satellite
function i_merge_satellite()
{
    unmerged_satellite_revs=`git log --oneline $satellite...$branch | wc -l`
    if [ $unmerged_satellite_revs != 0 ]; then
	echo "$satellite and $branch differ by $unmerged_satellite_revs revisions:"
	echo
	git log $satellite...$branch
	echo
	read -p "Merge/rebase $satellite into $branch? " do_rebase
	if [ x$do_rebase = xyes ]; then
	    git rebase -q $branch $satellite
	    git checkout -q $branch
	    # this should always be ff, since we just rebased
	    git merge -q --ff-only $satellite
	    echo "$unmerged_satellite_revs revisions merged into $branch."
	else
	    echo "Leaving $satellite untouched."
	fi
    fi
}

function stash() 
{
    if [ ! -z "`git status -s`" ]; then
	echo Working directory not clean, saving stash...
	git stash save -q $stashname
    fi
}

function stash_pop()
{
    if git stash list | grep -q MERGE_SATELLITE; then 
	echo Restoring saved stash...
	rev=`git stash | grep $stashname | cut -d: -f1`
	git stash pop -q $rev
    fi
}

function i_scan_externals()
{
    read -p "Scan for changes in externals? " do_scan_externals
    if [ x$do_scan_externals = xyes ]; then
	ruby $scripthome/git-externals.rb
	if [ -f update-externals.sh ]; then
	    source update-externals.sh
	fi
    fi
}

function i_svn_rebase()
{
    echo -n "Checking for new revisions from $svnurl... "
    git svn -q fetch --parent
    unrebased_revs=`git log --oneline $svnhead ^HEAD | wc -l`
    if [ $unrebased_revs != 0 ]; then
	echo
	echo There are $unrebased_revs incoming revisions from $svnurl
	echo
	git log $svnhead ^HEAD
	echo
	read -p "Run 'git svn rebase'? " do_rebase
	if [ x$do_rebase = xyes ]; then
	    git svn -q rebase
	    unrebased_revs=0

	    echo "Updating $satellite after 'git svn rebase'..."
	    git rebase -q $branch $satellite
	    git checkout -q $branch

	    i_scan_externals
	fi
    else
	echo none
    fi
}

function i_svn_dcommit()
{
    uncommitted=`git log --oneline HEAD ^$svnhead | wc -l`
    if [ $uncommitted != 0 ]; then
	if [ $unrebased_revs != 0 ]; then
	    echo You have $uncommitted revisions to dcommit, but you need to rebase first.
	else
	    echo There are $uncommitted revisions to dcommit to $svnurl
	    echo
	    git log HEAD ^$svnhead
	    echo
	    read -p "Run 'git svn dcommit'? " do_commit
	    if [ x$do_commit = xyes ]; then
		git svn -q dcommit

		echo "Updating $satellite after 'git svn dcommit'..."
		git rebase -q $branch $satellite
		git checkout -q $branch
	    fi	    
	fi
    fi
}

function on_exit() 
{
    echo "Exiting."
    git checkout $branch
    stash_pop
}

stash
trap on_exit EXIT
i_merge_satellite
i_svn_rebase
i_svn_dcommit
