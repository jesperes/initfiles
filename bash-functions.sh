# -*- shell-script -*-

function colorant
{
    ant -logger org.apache.tools.ant.listener.AnsiColorLogger "$@"
}

function prpath
{
    OLDIFS=$IFS
    IFS=:

    for f in $PATH; do
	echo "$f"
    done

    IFS=$OLDIFS
}

function sweep
{
    find | while read f; do
	case "$f" in
	    *~)
		rm -vf "$f"
		;;
        esac
    done
}

function settitle()
{
    echo -ne "\e]2;$@\a\e]1;$@\a";
}

function exphere()
{
    explorer $(cygpath -aw "$1")
}

function is_git_repo()
{
    if [ "$PWD" = / ]; then
	return 1;
    elif [ -d "$PWD/.git" ]; then
	return 0;
    else
	(cd ..; is_git_repo)
    fi
}

function display_vc_location()
{
    if [ -d .svn ]; then
	SVNLOC=$(svn info . | sed -ne 's@URL: \(.*\)@\1@p' | cut -d/ -f4-)
	SVNREV=$(svn info . | sed -ne 's@Revision: \(.*\)@\1@p')
	echo svn\($SVNLOC@$SVNREV\)
    elif is_git_repo; then
	GITLOC=$(git branch -a | grep -e '^*' | cut -d' ' -f2-)
	echo git\($GITLOC\)
    fi
}

# Deletes all non-svn files (i.e. displayed with ? by "svn status")
function svn_clean()
{
    svn status \
	| sed -ne 's@^\?\(.*\)@\1@gp' \
	| sed -e 's@\\@/@g' \
	| while read f; do
	rm -rfv "$f"
    done
}

# As svn_clean, but removes ignored files as well.
function svn_purge()
{
    svn status --no-ignore \
	| sed -ne 's@^\(\?\|I\)\(.*\)@\2@gp' \
	| sed -e 's@\\@/@g' \
	| while read f; do
	rm -rfv "$f"
    done
}

function vc_prompt
{
    STAT=`git status 2>&1`
    if echo $STAT | grep -q "Not a git repository"; then
	if [ -d .svn ]; then
	    if [ -z "`svn status --ignore-externals | grep -v ^X`" ] ; then
		echo -en '[svn:\033[0;32mclean\033[m]'
	    else
		echo -en '[svn:\033[0;31mdirty\033[m]'
	    fi
	fi
    else
	ref=$(git symbolic-ref HEAD 2> /dev/null)

	echo -en '\033[0;36m'"(${ref#refs/heads/})" '\033[m'
	
	if echo $STAT | grep -q "working directory clean"; then	
	    echo -en '[git:\033[0;32mclean\033[m]'
	else
	    echo -en '[git:\033[0;31mdirty\033[m]'
	fi
    fi
}
