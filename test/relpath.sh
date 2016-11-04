#! /bin/sh

. common.sh
. ${SCRIPTPREFIX}/common.sh


# XXX: This isn't testing symlinks yet
#dir1 dir2 - common reldir1 reldir2
dirs="\
/prefix/a/b/c /prefix/a/b - /prefix/a/b c . \
/prefix/a/b /prefix/a/b/c - /prefix/a/b . c \
/prefix/a/b/c /root/a - / prefix/a/b/c root/a \
/tmp/../tmp /tmp - /tmp . . \
/tmp/.. /tmp/../tmp/ - / . tmp \
/tmp/../tmp/../tmp /tmp/../tmp/ - /tmp . . \
"

set -- ${dirs}
while [ $# -gt 0 ]; do
	dir1="$1"
	dir2="$2"
	expected_common="$4"
	expected_reldir1="$5"
	expected_reldir2="$6"
	shift 6
	saved="$@"

	set -- $(relpath "${dir1}" "${dir2}")
	actual_common="$1"
	actual_reldir1="$2"
	actual_reldir2="$3"

	assert "${expected_common}" "${actual_common}" "(common) dir1: '${dir1}' dir2: '${dir2}'"
	assert "${expected_reldir1}" "${actual_reldir1}" "(reldir1) dir1: '${dir1}' dir2: '${dir2}'"
	assert "${expected_reldir2}" "${actual_reldir2}" "(reldir2) dir2: '${dir1}' dir2: '${dir2}'"

	set -- ${saved}
done