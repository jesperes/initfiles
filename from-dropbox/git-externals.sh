#!/bin/bash

: ${SVNURL:=$(git svn info | sed -ne 's/URL: \(.*\)/\1/p')}

if svn ls $SVNURL >/dev/null ; then
    echo Using Subversion URL: $SVNURL
else
    echo "SVNURL not set, or not a valid URL."
    exit 1
fi

SVN_SERVER=$(echo $SVNURL | sed -ne 's,\(\(https\|http\)://[^/]*\).*,\1,gp')

echo "Getting properties (this may take a little while)..."
[ -f svn.ls-R ] || svn ls -R $SVNURL > svn.ls-R
[ -f externals.txt ] || \
    (( cat svn.ls-R | grep -e '/$' ; echo) | \
    sed -e "s@\\(.*\\)@${SVNURL}/\\1@" | \
    xargs -d '\n' svn propget svn:externals \
    > externals.txt )

function filter_externals()
{
    cat $1 | \
	sed -ne 's,\(.*\) - \([^ \t]*\)[ \t]*-r\([0-9]*\)[ \t]*\([^ \t]*\),cd "\1" \&\& svn checkout -q -r\3 \4 \2,gp'
    cat $1 | \
	sed -ne "s,\\(.*\\) - \\(/[^ \\t]*\\)[ \\t][ \\t]*\\([^ \\t]*\\),cd \"\\1\" \&\& svn checkout -q $SVN_SERVER\\2 \\3,gp"
    cat $1 | \
	sed -ne 's,\([^ \t]*\)[ \t]*-r\([0-9]*\)[ \t]*\([^ \t]*\),cd "\1" \\&\\& svn checkout -q -r\2 \3 \1,gp'
    cat $1 | \
	sed -ne "s,\\(/[^ \\t]*\\)[ \\t][ \\t]*\\([^ \\t]*\\),cd \"\\1\" \\&\\& svn checkout -q $SVN_SERVER\\1 \\2,gp"
}

filter_externals externals.txt | while read f; do
    echo $f
     $f
done
