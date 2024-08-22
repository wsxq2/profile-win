## 使用说明

从 Dockerfile 构建（以 noetic 为例）：

```powershell
set http_proxy http://127.0.0.1:7890
docker build -t my_noetic . --build-arg https_proxy=$http_proxy --build-arg http_proxy=$http_proxy
docker run -it -d -p 12345:22 --name mn my_noetic
```

或者直接从 Dockerhub 拉取（以 noetic 为例）：

```powershell
docker pull wsxq2/my_noetic:added_diffbot_and_pallet
docker run -it -d -p 12345:22 --name mn wsxq2/my_noetic:added_diffbot_and_pallet
```

如果网络不好，则可能需要在 Docker Desktop 中设置代理，具体位置在`Settings->Resources->Proxies`
