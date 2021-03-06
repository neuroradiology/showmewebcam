#!/bin/bash

ORIGIN_PIZEROW_CAM="raspberrypi0cam"
target_defconfig="$ORIGIN_PIZEROW_CAM"_defconfig

case "$1" in
        raspberrypi0)
			target_defconfig="$1_defconfig"
			target_defconfig_loc="configs/$target_defconfig"
			# post-image.sh will gen corresponding image depend on basename path
			ln -sfrn "board/$ORIGIN_PIZEROW_CAM" "board/$1"
			cp -f "configs/$ORIGIN_PIZEROW_CAM"_defconfig "$target_defconfig_loc"

			sed "1i ### DO NOT EDIT, this is generated file from $ORIGIN_PIZEROW_CAM defconfig" -i "$target_defconfig_loc"
			# change path
			sed "s/board\/raspberrypi0cam/board\/$1/g" -i "$target_defconfig_loc"
			# change dts file
			sed "s/bcm2708-rpi-zero-w/bcm2708-rpi-zero/g" -i "$target_defconfig_loc"
            ;;
        *)
			target_defconfig="$ORIGIN_PIZEROW_CAM"_defconfig
esac

cd ../buildroot
BR2_EXTERNAL=../showmewebcam/ make $target_defconfig
make all
