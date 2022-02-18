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
sed -i 's/192.168.100.3/192.168.50.5/g' package/base-files/files/bin/config_generate

## integration clash core 实现编译更新后直接可用，不用手动下载clash内核
curl -sL -m 30 --retry 2 https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-amd64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p openwrt/package/lean/luci-app-openclash/files/etc/openclash/core
mv /tmp/clash openwrt/package/lean/luci-app-openclash/files/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
#Backup OpenClash cofig
echo '/etc/openclash/' >> openwrt/package/base-files/files/etc/sysupgrade.conf
