#!/bin/bash -x
# Copyright (c) 2014-2016 Arduino LLC
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
CURR_DIR=$(pwd)

#OUTPUT_VERSION=0.9.0-arduino6-static

OPENOCD_MAIN_NAME=OpenOCD
OPENOCD_TYPE_NAME=_picoprobe
OPENOCD_DIR_NAME=${OPENOCD_MAIN_NAME}${OPENOCD_TYPE_NAME}

DATE_STR=$(date +"%Y_%m_%d")
OUTPUT_VERSION=${DATE_STR}-static

export OS=`uname -o || uname`
export TARGET_OS=$OS
export OPENOCD_SRC_PATH=${SCRIPT_DIR}/${OPENOCD_DIR_NAME}

pushd ${SCRIPT_DIR}

if [[ $CROSS_COMPILE == "mingw" ]] ; then

./win_clean_all.sh

else

./unix_clean_all.sh

fi

popd





