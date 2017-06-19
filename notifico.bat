

docker pull croydon/notifico
docker run -v %cd%:/notifico/config --name=notifico -d --restart=on-failure:10 -p 5000:5000 croydon/notifico
