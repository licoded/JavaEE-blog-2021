# --- STAGE 1: Build ---
# 使用官方的 Node.js 镜像作为构建环境
FROM node:18-alpine AS builder

WORKDIR /app

# 配置 npm 镜像源并安装 pnpm
RUN npm config set registry https://registry.npmmirror.com && \
    npm install -g pnpm@10

# 复制 package.json 和 pnpm-lock.yaml 来利用缓存
COPY package.json pnpm-lock.yaml* ./

# 使用 pnpm 安装依赖
RUN pnpm install --frozen-lockfile

# 复制所有源代码
COPY . .

# 执行构建命令
RUN pnpm build

# --- STAGE 2: Serve ---
# 使用轻量的 Nginx 镜像来托管静态文件
FROM nginx:stable-alpine

# 设置时区为北京时间
RUN apk add --no-cache tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' > /etc/timezone && \
    apk del tzdata

# 将构建好的 dist 文件夹内容复制到 Nginx 的默认网站根目录
COPY --from=builder /app/dist /usr/share/nginx/html

# （可选）如果您使用 Vue Router 的 history 模式，需要添加一个 Nginx 配置来处理刷新404的问题
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露 Nginx 的默认端口
EXPOSE 80

# Nginx 镜像会自动启动 Nginx 服务，所以 CMD 不是必须的
CMD ["nginx", "-g", "daemon off;"]