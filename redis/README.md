## esayr/redis

Docker image to run an out of the box Redis server.

### Usage

#### Build

```bash
$ docker build -t esayr/redis .
```

#### Download automated build

```bash
$ docker pull esayr/redis
```

#### Running the Redis server

```bash
$ docker run -d -p 6379:6379 --name redis esayr/redis
```

#### Running the Redis server with persistent directory

```bash
$ docker run -d -p 6379:6379 --name redis -v /path/to/local/db:/var/lib/redis esayr/redis
```

#### Link

```bash
$ docker run -d -p 6379:6379 --name app -v --link db:db /path/to/local/db:/var/lib/redis esayr/redis
```

### Tips

#### VirtualBox (boot2docker-vm)

```bash
$ boot2docker halt
$ VBoxManage modifyvm boot2docker-vm --natpf1 "tcp-port6379,tcp,,6379,,6379"
$ boot2docker up
```

OR
```bash
VBoxManage controlvm "boot2docker-vm" natpf1 "tcp-port6379,tcp,,6379,,6379";
```