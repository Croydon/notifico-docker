#!/bin/sh

sudo docker pull croydon/notifico ;
sudo docker run -v $(pwd)':'/notifico --net=host -it croydon/notifico ;
