# syntax=docker/dockerfile:1

FROM golang:1.23

# 设置工作区
WORKDIR /app

# 设置环境变量
ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
    GOPROXY=https://goproxy.cn,direct

# 复制 go 依赖到容器
COPY go.mod go.sum ./

# 下载 go 依赖包
RUN go mod download

# 复制所有 go文件到容器
COPY ./ ./

# Build
RUN  go build -o /main

# 配置暴露端口
EXPOSE 8080/tcp

# Run 容器运行默认命令
CMD [ "/main" ]
