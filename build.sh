# 要检查的镜像名称

IMAGE_NAME="app"
CONTAINER_NAME="app_test"

pwd
# 查询镜像是否存在
container_exists=$(docker ps -aq --filter $CONTAINER_NAME)

if [ -n "$container_exists" ]; then
    echo "容器存在"
    docker rm -f app_test
else
    echo "容器不存在"
fi

# 使用docker images命令列出所有镜像，然后用grep检查镜像是否存在
if docker images | grep -q "$IMAGE_NAME"; then
    echo "镜像 $IMAGE_NAME 存在"
    docer rmi $IMAGE_NAME
else
    echo "镜像 $IMAGE_NAME 不存在"
fi

docker build -t $IMAGE_NAME .
docker run -d --name=$CONTAINER_NAME --restart=always -p 8080:8080 app