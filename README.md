# Linux Deploy Challenge :rocket:

Este é um projeto desenvolvido durante meu estágio na Compass UOL, ele tem como objetivo subir um servidor WEB com Nginx em uma máquina virtual utilizando sistema GNU/Linux.


## :wrench:  Preparando o ambiente
Para este projeto escolhi fazer a implantação no Ubuntu Server, então os comandos que vou descrever são voltados para essa distribuição, apesar ser semelhete o processo alguns comandos e passos podem variar conforme sua distribuição.

### Criando a máquina virtual
Para criar a máquina virtual utilizei o software do Virtual Box e baixei a imagem do Ubuntu Server, segue abaixo o link caso deseje conferir:

* [Virtual Box](https://www.virtualbox.org/)
* [Ubuntu Server](https://ubuntu.com/download/server)
 

Com a ISO do Ubuntu Server basta criar uma VM utilando ela no Virtual Box. A única configuração relevante foi fazer um redirecimento de portas para conseguir acessar a porta do servidor de fora da VM, e se desejar pode fazer o mesmo com a porta SSH. Segue uma imagem de como ficou minha configuração.

<img width="1272" height="572" alt="image" src="https://github.com/user-attachments/assets/f99a9fee-2c84-40d3-8aa3-868b77331a57" />

Siga o passo a passo do instalador do Ubuntu Server para poder prosseguir neste guia.

## :toolbox: Instalando o projeto
Agora com a instalação do sistema na máquina virtual completa podemos instalar e configurar os pacotes que serão utilizados.

### 1 - Instalando o Nginx
O comando abaixo instala o Nginx no Ubuntu Server:
```bash
sudo apt install nginx
```

### 2 - Checando status do Nginx
Após a instalação normalmente o serviço do Nginx já esta ativo e funcionando, como comando abaixo é possível checar o status:
```bash
sudo systemctl status nginx
```

Caso deseje seguindo essa mesma estrutura é possível parar, iniciar ou reiniciar o Nginx, basta trocar a palavra **"status"** por **stop**, **start** ou **restart**.

### 3 - Arrumando a hora do servidor
Essa sessão é para ajustar o timezone para ficar condizente com o horário de brasilia.
Basta executar o seguinte comando:

```bash
sudo timedatectl set-timezone Etc/GMT+3
```

### 4 - Clonando esse repositório
Um dos jeitos mais práticos de colocar esse projeto para funcionar é clonando ele usando o git clone, então vai ser necessário instalar o git no servidor, o que pode ser feito com o seguinte comando:

```bash
sudo apt install git
```

Com o git instalado agora podemos clonar o repositório com o comando:

```bash
git clone https://github.com/DellGarcia/linux-deploy-challenge.git
```

Utilize o cd para entrar na pasta do projeto:

```bash
cd linux-deploy-challenge
```

Pronto agora o projeto já esta dentro do servidor!

### 5 - Configurando variáveis de ambiente
Para o correto funcionamento do servidor é necessário criar o arquivo **.env.sh** na pasta **/scripts**, onde ficaram armazenadas as variáveis de ambiente. Por razões de segurança esse tipo de arquivo não versionado, mas é bem simples criá-lo, basta ir na pasta do servidor criar um arquivo **.env.sh** e colar a seguinte estrutura:

```bash
SERVER_PORT=
DISCORD_WEBHOOK=
LOG_FOLDER=
LOG_FILENAME=
LOG_ERROR_FILENAME=
```

Feito isso isso basta adicionar os valores necessários de acordo com seu projeto, por exemplo o endereço do DISCORD_WEBHOOK, basta colá-lo a frente da variável sem adição de espaços.

### 6 - Executando o script de deploy dos arquivos
O script **deploy.sh** automatiza o processo de copiar os arquivos para o local correto, no caso o **nginx.conf** e os arquivos dentro da pasta **website**. Basta executar o seguinte comando:

```bash
sudo bash ./scripts/deploy.sh
```

Com isso o nginx subirá na porta 80 (Mude no nginx.conf caso a porta esteja ocupada), e será possível visualizar o conteúdo do site acessando pelo navegador a porta onde foi realizado o port fowarding no meu caso foi na porta 8888, então acessei http://localhost:8888. 

Segue abaixo imagem do resultado no navegador:
<img width="1843" height="946" alt="image" src="https://github.com/user-attachments/assets/aa609066-c423-4907-a4a9-da06133f595f" />


## :computer: Monitorando funcionamento do Servidor

### Configurando o Crontab
Nessa sessão vamos agendar o script de monitoramento o **health_check.sh** para executar a cada 1 minuto, dessa forma ele estará sempre checando se a aplicação esta funcionando.

Para isso vamos precisar editar o crontab do root, o seguinte comando permite editá-lo:

```bash
sudo crontab -e
```

Feito isso basta adicionar a linha abaixo:

```bash
* * * * * /usr/bin/bash /home/<user>/linux-deploy-challenge/scritps/health_check.sh
```

Em caso da aplicação estar offline, o **health_check.sh** chama o **restart_server.sh** que vai tentar reiniciar o Nginx automaticamente, ambos os scripts geram logs referentes a sua execução e enviam notificações no webhook do Discord quando necessário.

Resultado das notificações no Discord:
<img width="1814" height="851" alt="image" src="https://github.com/user-attachments/assets/f078b45d-2c78-4435-a5ec-b3b18ee96f57" />


Logs gerados no servidor:
<img width="951" height="622" alt="image" src="https://github.com/user-attachments/assets/66461588-0d30-46ca-96f9-0daab22f0900" />

