# Linux Deploy Challenge :rocket:

Este é um projeto desenvolvido durante meu estágio na Compass UOL, ele tem como objetivo subir um servidor WEB com Nginx em uma máquina virtual utilizando sistema GNU/Linux.


## :wrench:  Preparando o ambiente
Para este projeto escolhi fazer a implantação no Ubuntu Server, então os comandos que vou descrever são voltados para essa distribuição, apesar ser semelhete o processo alguns comandos e passos podem variar conforme sua distribuição.

### Criando a máquina virtual
Para criar a máquina virtual utilizei o software do Virtual Box e baixei a imagem do Ubuntu Server, segue abaixo o link caso deseje conferir:

* [Virtual Box](https://www.virtualbox.org/)
* [Ubuntu Server](https://ubuntu.com/download/server)
 

Com a ISO do Ubuntu Server basta criar uma VM utilando ela no Virtual Box. A única configuração relevante foi fazer um redirecimento de portas para conseguir acessar a porta do servidor de fora da VM. Segue uma imagem de como ficou minha configuração.

<img width="991" height="586" alt="image" src="https://github.com/user-attachments/assets/12343ba3-f169-4424-a93a-046a0fb222c0" />

Siga o passo a passo do instalador do Ubuntu Server para poder prosseguir neste guia.

## :toolbox: Instalando Pacotes / Preparando Ambiente
Agora com a instalação do sistema na máquina virtual completa podemos instalar e configurar os pacotes que serão utilizados.

### Instalando o Nginx
O comando abaixo instala o Nginx no Ubuntu Server:
```bash
sudo apt install nginx

```

### Checando status do Nginx
Após a instalação normalmente o serviço do Nginx já esta ativo e funcionando, como comando abaixo é possível checar o status:
```bash
sudo systemctl status nginx
```

Caso deseje seguindo essa mesma estrutura é possível parar, iniciar ou reiniciar o Nginx, basta trocar a palavra **"status"** por **stop**, **start** ou **restart**.

### Arrumando a hora do servidor :watch:
Essa sessão é para ajustar o timezone para ficar condizente com o horário de brasilia.
Basta executar o seguinte comando:

```bash
sudo timedatectl set-timezone Etc/GMT+3
```

### Clonando esse repositório
Um dos jeitos mais práticos de colocar esse projeto para funcionar é clonando ele usando o git clone, então vai ser necessário instalar o git no servidor, o que pode ser feito com o seguinte comando:

```bash
sudo apt install git
```

Com o git instalado agora podemos clonar o repositório com o comando:

```bash
git clone https://github.com/DellGarcia/linux-deploy-challenge.git
```

Pronto agora o projeto já esta dentro do servidor!

### Configurando variáveis de ambiente
Para o correto funcionamento do servidor é necessário criar o arquivo .env.sh, onde ficaram armazenadas as variáveis de ambiente. Por razões de segurança esse tipo de arquivo não versionado, mas é bem simples criá-lo, basta ir na pasta do servidor criar um arquivo **.env.sh** e colar a seguint estrutura:

```bash
DISCORD_WEBHOOK=
```

Feito isso isso basta adicionar os valores necessário, por exemplo o endereço do DISCORD_WEBHOOK, basta colá-lo a frente da variável sem adição de espaços.

### Executando o script de deploy dos arquivos
O script **deploy.sh** automatiza o processo de copiar os arquivos para o local correto, no caso o **nginx.conf** e os arquivos dentro da pasta **website**. Basta executar o seguinte comando:

```bash
sudo bash ./deploy.sh
```

Com isso o nginx subirá na porta 80 (Mude no nginx.conf caso a porta esteja ocupada), e será possível visualizar o conteúdo do site acessando pelo navegador a porta onde foi realizado o port fowarding no meu caso foi na porta 8888, então acessei http://localhost:8888.

### Configurando o Crontab
Nessa sessão vamos agendar o script health_check.sh para executar a cada 1 minuto, dessa forma ele estará sempre checando se a aplicação esta funcionando.

Para isso vamos precisar editar o crontab do root, o seguinte comando permite editá-lo:

```bash
sudo crontab -e
```

Feito isso basta adicionar a linha abaixo:

```bash
* * * * * /usr/bin/bash /home/<user>/linux-deploy-challenge/health_check.sh
```

