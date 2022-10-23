# 指定基础镜像
FROM nginx:alpine

# 复制执行文件
COPY nginx/app /app/

# 复制项目 nginx 配置文件
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# 执行脚本
ENTRYPOINT ["/app/entrypoint.sh"]
