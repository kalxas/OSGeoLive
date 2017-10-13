#!/bin/sh
#
# install_hale.sh
#
#############################################################################
# Created by Johan Van de Wauw on 2017-10-12
# Copyright (c) 2017 Open Source Geospatial Foundation (OSGeo)
#
# Licensed under the GNU LGPL version >= 2.1.
#
# This library is free software; you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 2.1 of the License,
# or any later version.  This library is distributed in the hope that
# it will be useful, but WITHOUT ANY WARRANTY, without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Lesser General Public License for more details, either
# in the "LICENSE.LGPL.txt" file distributed with this software or at
# web page "http://www.fsf.org/licenses/lgpl.html".
#############################################################################

if [ "$#" -lt 1 ] || [ "$#" -gt 1 ]; then
    echo "Wrong number of arguments"
    echo "Usage: install_gvsig.sh ARCH(i386 or amd64)"
    exit 1
fi

if [ "$1" != "i386" ] && [ "$1" != "amd64" ] ; then
    echo "Did not specify build architecture, try using i386 or amd64 as an argument"
    echo "Usage: install_gvsig.sh ARCH(i386 or amd64)"
    exit 1
fi
ARCH="$1"

./diskspace_probe.sh "`basename $0`" begin
####
BUILD_DIR=`pwd`

if [ -z "$USER_NAME" ] ; then
   USER_NAME="user"
fi
USER_HOME="/home/$USER_NAME"

mkdir -p /opt/hale
cd /opt/hale

wget -N --progress=dot:mega \
    "https://github.com/halestudio/hale/releases/download/3.3.1/hale-studio-3.3.1-linux.gtk.x86_64.tar.gz"
tar xf hale-studio-3.3.1-linux.gtk.x86_64.tar.gz
rm -rf hale-studio-3.3.1-linux.gtk.x86_64.tar.gz

wget http://gisky.be/osgeolive-inspire/data/HALE.desktop
cp HALE.desktop "$USER_HOME/Desktop/" # For OSGeo live menu
mv HALE.desktop /usr/share/applications # For standard menu
chown "$USER_NAME:$USER_NAME" "$USER_HOME/Desktop/HALE.desktop"
####
# install some data files
cd /usr/local/share/data
mkdir -p inspire
cd inspire
wget http://gisky.be/osgeolive-inspire/data/Dutch_Addresses_gml32.gml
wget http://gisky.be/osgeolive-inspire/data/Dutch_Addresses_json.json
wget http://gisky.be/osgeolive-inspire/data/Malta_FloodriskAreas_data.xml

####
"$BUILD_DIR"/diskspace_probe.sh "`basename $0`" end
