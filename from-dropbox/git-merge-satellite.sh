#!/bin/bash

set -e

branch=$1; shift
satellite=satellite/$branch
svnremote=svn
svnhead=$(basename $(git config --get svn-remote.$svnremote.fetch | cut -d: -f2))

stashname=MERGE_SATELLITE

if git stash list | grep $stashname; then
    echo "Stash $stashname already exists. Exiting."
    exit 1
fi

function fixup_satellite()
{
    if [ `git rev-parse $branch` != `git rev-parse $satellite` ]; then
	echo Rebasing $satellite on top of $branch... 
	git rebase $branch $satellite
    fi

    if [ `git rev-parse HEAD` != `git rev-parse $branch` ]; then
	echo Checking out $branch...
	git checkout $branch
    fi

    if [ `git rev-parse HEAD` != `git rev-parse $satellite` ]; then
	echo Fastforwarding $satellite
	git merge --ff-only $satellite
    fi
}

function stash() 
{
    if [ ! -z "`git status -s`" ]; then
	echo Working directory not clean, saving stash
	git stash save -q $stashname
    fi
}

function stash_pop()
{
    if git stash list | grep -q MERGE_SATELLITE; then 
	echo Restoring saved stash
	rev=`git stash | grep $stashname | cut -d: -f1`
	git stash pop -q $rev
    fi
}

stash
fixup_satellite

echo Fetching...
git svn -q fetch --parent
if [ `git rev-parse $svnhead` != `git rev-parse HEAD` ]; then
    numrevs=`git log --oneline $svnhead..$HEAD | wc -l`
    echo Fetched $numrevs new revisions. Rebasing..."
    git svn rebase
else
    echo No new revisions"
fi

if [ `git rev-parse $svnhead` != `git rev-parse HEAD` ]; then
    uncommitted=`git log --oneline $svnhead..HEAD | wc -l`
    if [ $uncommitted != 0 ]; then
	echo
	echo There are $uncommitted revisions which have not been committed to `git config --get svn-remote.$svnremote.url`:
	git log --oneline $svnhead..HEAD
	echo
	read -p "Run 'git svn dcommit'? " do_commit
	if [ $do_commit = yes; then
	    git svn dcommit
	fi
    
	fixup_satellite
    fi
fi

stash_pop
git --no-pager lg --all
