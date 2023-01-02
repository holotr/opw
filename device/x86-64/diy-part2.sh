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

git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter

#rm -rf package/lean/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile

#sed -i "s/DISTRIB_REVISION='R2[0-9].[0-9].[0-9]/&-$(date +'D%y%m%dT%H%M')/" package/lean/default-settings/files/zzz-default-settings
sed -i "s/DISTRIB_DESCRIPTION='OpenWrt /&$(date +'%F') by Tau\\\'ri/" package/lean/default-settings/files/zzz-default-settings