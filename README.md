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

## 📥 Instalando pacotes
Agora com a instalação do sistema na máquina virtual completa podemos instalar e configurar os pacotes que serão utilizados.

#### Instalando o Nginx
O comando abaixo instala o Nginx no Ubuntu Server:
```bash
sudo apt install nginx

```

#### Checando status do Nginx
Após a instalação normalmente o serviço do Nginx já esta ativo e funcionando, como comando abaixo é possível checar o status:
```bash
sudo systemctl status nginx
```

Caso deseje seguindo essa mesma estrutura é possível parar, iniciar ou reiniciar o Nginx, basta trocar a palavra **"status"** por **stop**, **start** ou **restart**.



