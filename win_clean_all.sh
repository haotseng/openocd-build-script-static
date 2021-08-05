#!/bin/bash -ex
# Copyright (c) 2016 Arduino LLC
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd ${SCRIPT_DIR}

# check directory
if [ X"${OPENOCD_SRC_PATH}" == "X" ]; then
    echo "environment var 'OPENOCD_SRC_PATH' not found !"
    exit 1
fi
if [ ! -d ${OPENOCD_SRC_PATH} ]; then
    echo "OpenOCD source directory not found ! : ${OPENOCD_SRC_PATH} "
    exit 1
fi

ARCH=`i686-w64-mingw32-gcc -v 2>&1 | awk '/Target/ { print $2 }'`
#ARCH=`gcc -v 2>&1 | awk '/Target/ { print $2 }'`

rm -rf distrib

cd libusb-1.0.20
make clean
cd ..

cd libusb-compat-0.1.5
make clean
cd ..

#cd kmod-22
#make clean
#cd ..

#cd eudev-3.1.5
#make clean
#make -j4
#cd ..

cd hidapi
make clean
cd ..

cd ${OPENOCD_SRC_PATH}
make clean
