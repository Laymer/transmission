#! /bin/sh
#
# $Id$

# convention: -TR MAJOR MINOR MAINT STATUS - (each a single char)
# STATUS: "X" for prerelease test builds,
#         "Z" for unsupported trunk builds,
#         "0" for stable, supported releases
# these should be the only two lines you need to change
PEERID_PREFIX="-TR140Z-"
USERAGENT_PREFIX="1.40+"

SVN_REVISION=`git rev-parse --short HEAD`
SVN_REVISION_MAC=$SVN_REVISION

# Generate files to be included: only overwrite them if changed so make
# won't rebuild everything unless necessary
replace_if_differs ()
{
    if cmp $1 $2 > /dev/null 2>&1; then
      rm -f $1
    else
      mv -f $1 $2
    fi
}

# Generate version.h
cat > libtransmission/version.h.new << EOF
#define PEERID_PREFIX             "$PEERID_PREFIX"
#define USERAGENT_PREFIX          "$USERAGENT_PREFIX"
#define SVN_REVISION              "$SVN_REVISION"
#define SHORT_VERSION_STRING      "$USERAGENT_PREFIX"
#define LONG_VERSION_STRING       "$USERAGENT_PREFIX ($SVN_REVISION)"

#define VERSION_STRING_INFOPLIST  $USERAGENT_PREFIX
#define BUNDLE_VERSION_INFOPLIST  $SVN_REVISION
EOF
replace_if_differs libtransmission/version.h.new libtransmission/version.h

exit 0
