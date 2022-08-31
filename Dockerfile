# 指定基础镜像
FROM nginx:stable-alpine

# 复制项目 nginx 配置文件
COPY nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf