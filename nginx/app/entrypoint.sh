#!/bin/sh

# 本地 DNS 配置文件
RESOLVER_CONF=/etc/resolv.conf
# 本地 DNS 配置信息
NAMESERVER=$(awk '/^nameserver/{print $2}' ${RESOLVER_CONF})
# 默认 DNS 地址
DEFAULT_NAMESERVER='127.0.0.11'
# Nginx 配置文件
NGINX_CONF=/etc/nginx/nginx.conf
# 鉴权服务文件
AUTH_FILE=/app/sign_check_nginx_linux_amd64
# 鉴权 Token
TOKEN='xxx'

# 判断本地 DNS 配置文件是否存在
if [ ! -e "${RESOLVER_CONF}" ]; then
  exit 0
fi

# 判断本地 DNS 配置信息是否为空
if [ -z "${NAMESERVER}" ]; then
  exit 0
fi

# 替换 Nginx 配置文件内的 DNS 地址
if [ "$(grep -c "${DEFAULT_NAMESERVER}" "${NGINX_CONF}")" -ne '0' ]; then
  sed -i "s/127.0.0.11/${NAMESERVER}/" "${NGINX_CONF}"
fi

# 启动鉴权服务
nohup ${AUTH_FILE} -bind '0.0.0.0:8287' -token ${TOKEN} > /dev/null 2>&1 &

# nginx 守护进程
nginx -g "daemon off;"
