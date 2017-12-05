# hiwifi-ss

> We shall fight on the beaches.

极路由+ss配置, 适应新版极路由，支持的极路由版本有(__因为没办法测试所有的极路由，所以你能运行的极路由不在这个列表，请在[issue#38](https://github.com/qiwihui/hiwifi-ss/issues/38)中回复，谢谢！__):

现在项目使用的是大陆白名单模式，适用大陆白名单和gfwlsit的处理。项目中的gfw规则使用项目生成的规则修改而成，最后更新日期为2017.08.08。

### 安装方法

1. 新版hiwifi => 使用项目根目录下的 `shadow.sh` 脚本进行安装, 建议使用以下一键命令:
v1.4.5.19222s

```bash
    cd /tmp && curl -k -o shadow.sh https://raw.githubusercontent.com/wzs1990/hiwifi-ss/master/shadow.sh && sh shadow.sh && rm shadow.sh
```
### 本地更新dnsmasq.conf

使用项目 [gfwlist2dnsmasq](https://github.com/cokebar/gfwlist2dnsmasq.git) 中的脚本即可

```bash
git clone https://github.com/cokebar/gfwlist2dnsmasq.git
cd gfwlist2dnsmasq
./gfwlist2dnsmasq.sh --port 53535 -o gw-shadowsocks.dnslist

# 复制 gw-shadowsocks.dnslist 到 hiwifi-ss/etc/gw-shadowsocks/gw-shadowsocks.dnslist 打包
# 或者，直接复制到极路由 etc/gw-shadowsocks/gw-shadowsocks.dnslist 上
```

### 本地安装/开发

以 tag `v1.0.6` 为例

```bash
# 本地生成 tar 包
git clone git@github.com:qiwihui/hiwifi-ss.git
cd hiwifi-ss
git checkout v1.0.5
tar -C ./ -czvf hiwifi-ss.tar.gz etc lib usr
scp -P 1022 hiwifi-ss.tar.gz root@192.168.199.1:/tmp

# ssh登录极路由
tar xzvf /tmp/hiwifi-ss.tar.gz -C /
```

### 如何在服务器端启用`chacha20`的支持：

1. 编译并安装libsodium:

   ```
   apt-get update
   apt-get install build-essential
   wget https://github.com/jedisct1/libsodium/releases/download/1.0.3/libsodium-1.0.3.tar.gz
   tar xf libsodium-1.0.3.tar.gz && cd libsodium-1.0.3
   ./configure && make && make install
   ```

2. 修复动态链接库:

编辑 `/etc/ld.so.conf` 文件， 加入一行 `/usr/local/lib` 并保存。运行命令 `ldconfig`

3. 在ss配置中修改为 `chacha20` 即可


### 常见问题

0. 支持哪些加密方法？

  理论上 ss-local 2.4.7 能支持的算法都支持。

1. 安装后显示`请求的接口不存在`?

  请重启路由器.

2. 适用极路由版本有哪些?


3. 如何卸载脚本?

  将`/usr/lib/lua/luci/view/admin_web/network/index.htm.ssbak` 重命名为 `/usr/lib/lua/luci/view/admin_web/network/index.htm`, 并移除ss: `opkg remove geewan-ss`

4. 如果出现类似下面的报错，请确保你是登录到极路由后台执行脚本: `ssh root@192.168.199.1 -p 1022`， 不要在自己的电脑上执行 :(


5. 项目如何开机自动运行？

  项目在 `/etc/rc.d/` 下添加了 `S99gw-shadowsocks` 指向 `/etc/init.d/gw-shadowsocks`，所以会开机自动运行的。

