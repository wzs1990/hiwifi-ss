#!/bin/sh
#
echo 'Go!'
echo '==> 创建临时目录 /tmp/geewan'
mkdir -p /tmp/geewan
cd /tmp/geewan
echo 'Done! 成功创建临时目录!'
echo ''
echo '==> 下载插件...'

    curl -k https://raw.githubusercontent.com/wzs1990/hiwifi-ss/master/hiwifi-ss.tar.gz -o hiwifi-ss.tar.gz

echo 'Done! 下载完成'
echo ''
sleep 2
echo -n "==> 备份系统文件...."

if [ -f /usr/lib/lua/luci/view/admin_web/menu/menu_left.htm.ssbak ]; then
    echo -e "...[\e[31m备份已存在\e[0m]"
else
    cp -a /usr/lib/lua/luci/view/admin_web/menu/menu_left.htm /usr/lib/lua/luci/view/admin_web/menu/menu_left.htm.ssbak
    echo -e "....[\e[32m备份完成\e[0m]"
fi
echo ''
echo -n '==> 安装插件...'
tar xzvf hiwifi-ss.tar.gz -C / >>/dev/null
echo -e '...[\e[32m安装成功\e[0m]'

echo ''
sleep 2
echo '==> 清理临时文件...'
if test -e /var/run/luci-indexcache; then
    rm /var/run/luci-indexcache && echo 'Done! 清理完成 ' && echo '';
else
    echo 'luci-cache does not exist! 无法找到luci-cache,请确定是否是极路由环境' && echo ''
fi
rm -rf /tmp/geewan
sleep 2
echo ''
echo '插件成功安装!'


echo 'Done! Hello World! 一切就绪,你好世界!'
