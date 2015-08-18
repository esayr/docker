docker build -t erlang ./erlang/
docker run -d --name erlang -v $HOME/erlang-project:/data/project erlang