# Docker-Container: php-nginx-oci8

## PHP 7.1.15 ( oci8, ldap, soap ) + Nginx + Redis + Mailhog

Este é um ambiente de desenvolvimento PHP Laravel em containers Docker. Ele foi criado principalmente para rodar em ambientes Windows com VirtualBox, mas funciona normalmente em outras plataformas.

### Estrutura ###

A estrutura de pastas foi construida para facilitar o desenvolvimento.

| Pasta | Descrição |
| ------ | ------ |
| desenv | Pasta com os arquivos PHP em desenvolvimento local ( faça o git clone dos repositorios aqui ) |
| infra | Arquivos de configuração dos serviços. ( Virtual host, logs e etc... )|

# Instalação Windows 7
### Pré-requisitos  #####
 ---------------------------------
#### 1 - Git SCM for Windows
###### Pode ser baixado no link abaixo:
https://git-scm.com/download/win
### 2 - VirtualBox
###### Pode ser baixado no link abaixo:
https://www.virtualbox.org/wiki/Downloads
### 3 - Docker ToolBox
###### Pode ser baixado no link abaixo:
https://download.docker.com/win/stable/DockerToolbox.exe (link direto) | https://docs.docker.com/toolbox/toolbox_install_windows/

> **Nota:**
> Baixe as versões mais atualizadas.
>Os aplicativos devem ser instalados na ordem conforme apresentação acima (1,2,3), isso ajuda na associação automatica das ferramentas durante a instalação.


## Instalação #####

Após a instalação dos pré-requisitos, acesse o "Docker Quickstart Terminal" e aguarde ele provisionar automaticamente uma máquina virtual Linux no virtual box.

O ambiente estará disponível assim que você visualizar o docker ascii art:

```sh
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""\___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
         \    \        __/
          \____\______/


Docker is configured to use the default machine with IP 192.168.99.100.
```
> **Nota:**
>Repare no IP informado na mensagem acima, é através dele que iremos acessar os serviços que estão rodando nos containers.
>Para verificar novamente esse IP, basta executar o comando: **docker-machine ip**
>Caso não for utilizar o caminho abaixo para clonar o projeto, não se esqueça de mapear a unidade/diretório onde ficará seu projeto no Virtualbox.

Agora vamos clonar o projeto e levantar os containers do docker, veja os comandos abaixo:

```bash
$ pwd
> /c/Users/nomedousuario
$ _
### O terminal deve ficar sempre com nomedousuario@nomedocomputador MINGW64 ~
### O sinal de Til (~) no final, significa que você esta dentro do perfil do usuário
$ _
$ git clone https://github.com/rcngo/docker-php-nginx-oci8.git
$ cd docker-php-nginx-oci8
$ docker-compose up -d --build
```
Após terminar o Build, realize os testes e veja se seu ambiente esta funcionando corretamente.

> **Nota:**
>
>1- O primeiro Build é demorado, pois o Docker irá baixar as imagens e configurar os containers.
>
> 2- O ambiente possui um arquivo **.env** onde você pode configurar algumas opções. Sempre que você alterar esse arquivo, será necessário rodar o comando com a flag ``--build`` novamente: **docker-compose up -d --build**

# Instalação Mac OS
### Pré-requisitos  #####
 ---------------------------------
#### 1 - Docker Desktop for Mac
###### Pode ser baixado no link abaixo:
https://hub.docker.com/editions/community/docker-ce-desktop-mac

> **Nota:**
> Baixe as versões mais atualizadas.
> Na versão Docker Desktop não é necessário instalar os outros softwares.

## Instalação #####
Após a instalação, verifique se o Docker já está rodando em seu Mac Ios.
Abra o terminal e acesso o diretório onde ficará seu projeto.

```bash
$ git clone https://github.com/rcngo/docker-php-nginx-oci8.git
$ cd docker-php-nginx-oci8
$ docker-compose up -d --build
```
> **Nota:**
No caso do Docker-Desktop o IP é o 127.0.0.1, e você não consiguirá utilizar o docker-machine ip para visualização do mesmo, pois não é necessário virtualização da mesma forma que é necessário com o Docker-toolbox.

## Serviços

> **Nota:** Lembre de verificar o ip com o comando: **docker-machine ip**

| Serviço | Link | Acesso e Porta | Descrição
| ------ | ------ | ---- | ---- |
| Web | http://192.168.99.100  | definidos no arquivo .env | Servidor Nginx
| Mailhog | http://192.168.99.100:8025 | definidos no arquivo .env | Sevidor de e-mails Fake
| Cache (Redis) | - | definidos no arquivo .env | Servidor de cache

## Comandos

Utilize o **docker-compose** para redirecionar os comandos para o container do serviço. Por exemplo:

```sh
docker-compose run web php artisan list
```

Caso queira rodar os comandos de dentro do container, faça da seguinte forma:

```sh
docker-compose exec web bash
```

Depois disso, basta executar o comando desejado.

## Dúvidas?
Fale com o Rafael Nascimento <cruz.rafael@hotmail.com>
