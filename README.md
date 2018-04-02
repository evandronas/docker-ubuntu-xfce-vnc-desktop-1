evandronas/docker-ubuntu-xfce-vnc-desktop-1
=========================

### Do Docker Repository

``
$ docker pull evandronas/ubuntu-xfce-vnc-desktop-1
``

### construindo o seu
############################################################################
# Observação: O repositório no githup tem o login evandronascimento no lugar de evandronas #
############################################################################
``
$ git clone https://github.com/evandronascimento/docker-ubuntu-xfce-vnc-desktop-1.git
$ cd docker-ubuntu-xfce-vnc-desktop-1
$ docker build .
$ docker images
$ docker tag {IMAGE ID} docker.io/evandronas/ubuntu-xfce-vnc-desktop-1:latest

### Run

``
$ docker run -i -t -p 5901:5900 --privileged evandronas/ubuntu-xfce-vnc-desktop-1:latest
``

Use o vnc viewer para <O seu IP na porta>:5901


Problemas
=========
Verifique os logs em /var/log/ dentro do container.

Notas finais de créditos:
Este repositório foi construído baseado no repositório welkineins/docker-ubuntu-xfce-vnc-desktop
