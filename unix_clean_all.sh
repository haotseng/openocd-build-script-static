#!/bin/bash -x
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

rm -rf distrib

#disable pkg-config
export PKG_CONFIG_PATH=`pwd`

if [[ ${ARCH} != *darwin* ]]; then

cd eudev-3.1.5
export UDEV_DIR=`pwd`
make clean
cd ..

export CFLAGS="-I$UDEV_DIR/src/libudev/"
export LDFLAGS="-L$UDEV_DIR/src/libudev/.libs/"
export LIBS="-ludev"

fi

cd libusb-1.0.20
export LIBUSB_DIR=`pwd`
make clean
cd ..

export LIBUSB1_CFLAGS="-I$LIBUSB_DIR/libusb/"
export LIBUSB1_LIBS="-L$LIBUSB_DIR/libusb/.libs/ -lusb-1.0 -lpthread"

export LIBUSB_1_0_CFLAGS="-I$LIBUSB_DIR/libusb/"
export LIBUSB_1_0_LIBS="-L$LIBUSB_DIR/libusb/.libs/ -lusb-1.0 -lpthread"

cd libusb-compat-0.1.5
export LIBUSB0_DIR=`pwd`
make clean
cd ..

export libusb_CFLAGS="-I$LIBUSB_DIR/libusb/"
export libusb_LIBS="-L$LIBUSB_DIR/libusb/.libs/ -lusb-1.0 -lpthread"
export libudev_CFLAGS="-I$UDEV_DIR/src/libudev/"
export libudev_LIBS="-L$UDEV_DIR/src/libudev/.libs/ -ludev"

cd hidapi
export HIDAPI_DIR=`pwd`
make clean
cd ..

cd ${OPENOCD_SRC_PATH}
export LIBUSB0_CFLAGS="-I$LIBUSB0_DIR/libusb/"
export LIBUSB0_LIBS="-L$LIBUSB0_DIR/libusb/.libs/ -lusb -lpthread"
export LIBUSB1_CFLAGS="-I$LIBUSB_DIR/libusb/"
export LIBUSB1_LIBS="-L$LIBUSB_DIR/libusb/.libs/ -lusb-1.0 -lpthread"
export HIDAPI_CFLAGS="-I$HIDAPI_DIR/hidapi/"

if [[ ${ARCH} != *darwin* ]]; then

export HIDAPI_LIBS="-L$HIDAPI_DIR/linux/.libs/ -L$HIDAPI_DIR/libusb/.libs/ -lhidapi-hidraw -lhidapi-libusb"

else

export HIDAPI_LIBS="-L$HIDAPI_DIR/mac/.libs/ -L$HIDAPI_DIR/libusb/.libs/ -lhidapi"
fi

export CFLAGS="-DHAVE_LIBUSB_ERROR_NAME"
PKG_CONFIG_PATH=`pwd` ./configure --disable-werror --prefix=$PREFIX
make clean
cd -
