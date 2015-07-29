## esayr/ubuntu

ubuntu 基础镜像, 在官方 ubuntu 14.04 镜像的基础上:

1. 修改apt源为网易

2. 安装了 wget curl git

### Usage

#### Build

```bash
$ docker build -t esayr/ubuntu .
```

#### Download automated build

```bash
$ docker pull esayr/ubuntu
```

#### Running

```bash
$ docker run -it --rm esayr/ubuntu bash
```