docker build -t nginx-php ./nginx-php5/
docker run -d --name erlang -v $HOME/www:/var/www nginx-php

或者直接用线上的镜像

docker run -d --name erlang -v $HOME/www:/var/www docker.v909.com/nginx-php