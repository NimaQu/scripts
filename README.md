## 自用日常维护脚本
### cert.sh

配合 [acme.sh](https://acme.sh) 使用，一键把签发的证书放到 nginx 中供其他服务器下载证书

用法:

```bash
./cert.sh example.com
```

### ssl.sh

从自建的 nginx 服务器下载并安装证书进本地 nginx 

用法:

```bash
./ssl.sh (init|renew|getcert|getkey|setcron) domain_name
```

init: 下载证书重载 nginx 配置文件并添加好 cron 进行续期

renew: 下载最新的证书并重载 nginx 配置文件，在 cron 中使用

getcert: 只下载证书

getkey: 只下载密钥

setcron: 只设置 cron 定时任务
