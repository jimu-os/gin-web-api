# syntax=docker/dockerfile:1

FROM golang:1.23 AS builder

# 设置工作区
WORKDIR /go_web

# 设置环境变量
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
ENV GOPROXY=https://goproxy.cn,direct

# 复制 go 依赖到容器
COPY go.mod go.sum ./

# 下载 go 依赖包
RUN go mod download

# 复制所有 项目文件
COPY . .

# 构建可执行文件
RUN  go build -o /main

# 创建更小的镜像
FROM alpine
WORKDIR /
COPY --from=builder /main /

# 配置暴露端口
EXPOSE 8080/tcp

# Run 容器运行默认命令
CMD [ "/main" ]
