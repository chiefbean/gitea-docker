sudo docker kill gitea_1
sudo docker rm gitea_1

sudo docker build -t gitea .
sudo docker run --privileged -d --name gitea_1 --mount type=bind,source="$(pwd)"/data,target=/data gitea
