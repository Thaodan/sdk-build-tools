#!/bin/bash

#
# This is preliminary build script used to setup documentation for SailfishOS SDK
# (c) 2014 Jolla Ltd. Contact: Jarko Vihriälä <jarko.vihriala@jolla.com>
# License: Jolla Proprietary until further notice.
#
# for tracing: set -x

usage() {
    cat <<EOF
Create documentation.7z

Usage:
   $0 [OPTION]

Options:
   -c | --compression <0-9> compression level of 7z [9]
   -h | --help              this help

EOF

    # exit if any argument is given
    [[ -n "$1" ]] && exit 1
}



#
# Execution starts here
#
# handle commandline options
while [[ ${1:-} ]]; do
    case "$1" in
	-c | --compression ) shift
	    OPT_COMPRESSION=$1; shift
	    if [[ $OPT_COMPRESSION != [0123456789] ]]; then
		usage quit
	    fi
	    ;;
	-h | --help ) shift
	    usage quit
	    ;;
	-* )
	    usage quit
	    ;;
	* )
	    shift
	    ;;
    esac
done

INSTALL_PATH=$PWD/documentation
mkdir -p $INSTALL_PATH
for NAME in $(ls *.qch);
do
	echo "Hard linking $PWD/$NAME => $INSTALL_PATH/$NAME"
	ln -f $PWD/$NAME $INSTALL_PATH/$NAME
done

ZIP_STATUS=$(7z a -mx=$OPT_COMPRESSION documentation.7z $INSTALL_PATH/)




