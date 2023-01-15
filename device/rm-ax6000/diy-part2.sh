#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/wpad-basic-wolfssl/wpad-wolfssl/' package/feeds/NueXini_Packages/luci-app-easymesh/Makefile

# Add Package
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-turboacc feeds/luci/applications/luci-app-turboacc
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe package/lean/shortcut-fe

./scripts/feeds update -i && ./scripts/feeds install -a -p luci

#sed -i "s/DISTRIB_REVISION='R2[0-9].[0-9].[0-9]/&-$(date +'D%y%m%dT%H%M')/" package/lean/default-settings/files/zzz-default-settings
#sed -i "s/DISTRIB_DESCRIPTION='OpenWrt /&$(date +'%F') by Tau\\\'ri/" package/lean/default-settings/files/zzz-default-settings

cp /usr/bin/upx staging_dir/host/bin
cp /usr/bin/upx-ucl staging_dir/host/bin

date=`date +%m.%d.%Y`
sed -i -e "/\(# \)\?REVISION:=/c\REVISION:=$date" -e '/VERSION_CODE:=/c\VERSION_CODE:=$(REVISION)' include/version.mk
rm -rf package/feeds/holotr/my-default-settings/files/usr
sed -i "s/%D %V, %C/%D %C by Tau'ri/" package/base-files/files/etc/banner
sed -i "s/%D %V %C/%D %C by Tau\'ri/" package/base-files/files/etc/openwrt_release
sh -c "curl -sfL https://github.com/holotr/opw/raw/master/device/rm-ax6000/patch/base-file.patch | patch -d './' -p1 --forward" || true
