#!/bin/sh

sudo docker pull croydon/notifico ;
sudo docker run -v $(pwd)':'/notifico/config --net=host -it --restart=on-failure:10 -p 5000:5000 croydon/notifico ;
