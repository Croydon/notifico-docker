

docker pull croydon/notifico
docker run -v %cd%:/notifico/config --net=host -it --restart=on-failure:10 -p 5000:5000 croydon/notifico
