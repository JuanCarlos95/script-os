#!/bin/bash
echo "Iniciando script de preparacao de estacoes linux, Aguarde..."
echo " "
#Criando os diretorios Trabin
echo "Criando diretorios Trabin, Aguarde..."
sudo mkdir -p /opt/Trabin-Software/
sudo chmod -R 777 /opt/Trabin-Software/
sudo mkdir -p /opt/Imagens/
sudo chmod -R 777 /opt/Imagens/
sudo mkdir -p /media/TSC-Arquivos
sudo chmod -R 777 /media/TSC-Arquivos
sudo mkdir -p /media/TSC-ERPs
sudo chmod -R 777 /media/TSC-ERPs
sudo mkdir -p /media/TSC-Diversos
sudo chmod -R 777 /media/TSC-Diversos
sudo mkdir -p /media/TSC-Trabin
sudo chmod -R 777 /media/TSC-Trabin
echo "Diretorios criados com sucesso!"
#Montando compartilhamento para uso dos sistema trabin
echo "Iniciando montagem do compartilhamento entre a maq e o servidor, Aguarde..."
echo " " >> /etc/fstab
echo "#Particao para uso Trabin" >> /etc/fstab
echo "//192.168.0.250/TSC-Arquivos/ /media/TSC-Arquivos/ cifs username=administrador,password=pro@info_jouglard 0 0" >> /etc/fstab
echo "//192.168.0.250/TSC-ERPs/ /media/TSC-ERPs/ cifs username=administrador,password=pro@info_jouglard 0 0" >> /etc/fstab
echo "//192.168.0.250/TSC-Diversos/ /media/TSC-Diversos/ cifs username=administrador,password=pro@info_jouglard 0 0" >> /etc/fstab
echo "//192.168.0.250/TSC-Trabin/ /media/TSC-Trabin/ cifs username=administrador,password=pro@info_jouglard 0 0" >> /etc/fstab
sudo mount -a
echo "Montagem executada com sucesso"
#Preparando e instalando wine + ssh
echo "Preparando para instalar o wine1.8, Aguarde..."
echo "Adicionando repositorio wine, Aguarde..."
sudo add-apt-repository ppa:ubuntu-wine/ppa -y;
echo "Aplicando ao sistema e atualizando a tabela de repositorios, Aguarde.."
sudo apt-get update;
echo "Instalando wine e playonlinux, Aguarde.."
sudo apt-get install wine1.8 -y;
sudo apt-get install playonlinux -y;

echo "Instalando SSH, Aguarde.."
sudo apt-get install ssh -y
#Copiando as imagens e gerando um agendamento das 8 as 18hs todos os dias
echo "Inciando a copia das imagens do servidor, Aguarde..."
rsync -Cravzp /media/TSC-Arquivos/Imagens/ /opt/Imagens/
echo "Criando agendamento da 8 as 18hs todos os dias, Aguarde..."
echo " " >> /etc/crontab
echo "# Agendamento Trabin para atualizacoes das imagens nas estacoes" >> /etc/crontab
echo "00 08-18 * * * root rsync -Cravzp --delete /media/TSC-Arquivos/Imagens/ /opt/Imagens/" >> /etc/crontab
echo "Agendamento criado com sucesso!"

echo "Instalando Tight VNC Server"
sudo apt-get install tightvncserver -y;
echo "Instalando D-Conf. Editor"
sudo apt-get install dconf-editor;

echo "Criando diretórios p/ TSC-Pedido"
mkdir /opt/Trabin-Software/TSC-Pedido
mkdir /opt/Trabin-Software/TSC-Pedido/Atalhos_Linux
mkdir /opt/Trabin-Software/TSC-Pedido/Imagens
mkdir /opt/Trabin-Software/TSC-Pedido/Logs
mkdir /opt/Trabin-Software/TSC-Pedido/REGs
mkdir /opt/Trabin-Software/TSC-Pedido/Controles
echo "Criando diretórios p/ TSC-EnterpriseXE5"
mkdir /opt/Trabin-Software/TSC-EnterpriseXE5
mkdir /opt/Trabin-Software/TSC-EnterpriseXE5/Atalho_Linux
mkdir /opt/Trabin-Software/TSC-EnterpriseXE5/Controles
mkdir /opt/Trabin-Software/TSC-EnterpriseXE5/Imagens
mkdir /opt/Trabin-Software/TSC-EnterpriseXE5/Imagens2
mkdir /opt/Trabin-Software/TSC-EnterpriseXE5/PDFs
mkdir /opt/Trabin-Software/TSC-EnterpriseXE5/Regs
mkdir /opt/Trabin-Software/TSC-EnterpriseXE5/'dlls atuais'
mkdir /opt/Trabin-Software/TSC-EnterpriseXE5/'dlls email novas'
echo "Copiando arquivos referentes ao TSC-Pedido"
cp /media/TSC-ERPs/TSC-Pedido7/* /opt/Trabin-Software/TSC-Pedido
#cp /media/TSC-ERPs/TSC-Pedido7/Atalhos_Linux/* /opt/Trabin-Software/TSC-Pedido/Atalhos_Linux
cp /media/TSC-ERPs/TSC-Pedido7/Imagens/* /opt/Trabin-Software/TSC-Pedido/Imagens
cp /media/TSC-ERPs/TSC-Pedido7/Logs/* /opt/Trabin-Software/TSC-Pedido/Logs
#cp /media/TSC-ERPs/TSC-Pedido7/REGs/* /opt/Trabin-Software/TSC-Pedido/REGs
cp /media/TSC-ERPs/TSC-Pedido7/Controles/* /opt/Trabin-Software/TSC-Pedido/Controles
echo "Copiando arquivos referentes ao TSC-EnterpriseXE5"
cp /media/TSC-ERPs/TSC-EnterpriseXE5/* /opt/Trabin-Software/TSC-EnterpriseXE5
cp /media/TSC-ERPs/TSC-EnterpriseXE5/Atalho_Linux/* /opt/Trabin-Software/TSC-EnterpriseXE5/Atalho_Linux
cp /media/TSC-ERPs/TSC-EnterpriseXE5/Controles/* /opt/Trabin-Software/TSC-EnterpriseXE5/Controles
cp /media/TSC-ERPs/TSC-EnterpriseXE5/Imagens/* /opt/Trabin-Software/TSC-EnterpriseXE5/Imagens
cp /media/TSC-ERPs/TSC-EnterpriseXE5/Imagens2/* /opt/Trabin-Software/TSC-EnterpriseXE5/Imagens
cp /media/TSC-ERPs/TSC-EnterpriseXE5/PDFs/* /opt/Trabin-Software/TSC-EnterpriseXE5/PDFs
cp /media/TSC-ERPs/TSC-EnterpriseXE5/Regs* /opt/Trabin-Software/TSC-EnterpriseXE5/Regs
cp /media/TSC-ERPs/TSC-EnterpriseXE5/'dlls atuais'/* /opt/Trabin-Software/TSC-EnterpriseXE5/'dlls atuais'
cp /media/TSC-ERPs/TSC-EnterpriseXE5/'dlls emails novas'/* /opt/Trabin-Software/TSC-EnterpriseXE5/'dlls emails novas'
echo "Alterando executáveis pela última versão"
cp /media/TSC-Trabin/Enterprise.exe /opt/Trabin-Software/TSC-EnterpriseXE5
cp /media/TSC-Trabin/Pedido.exe /opt/Trabin-Software/TSC-Pedido
echo "Estacao linux preparada com sucesso!"

echo "Baixando Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

echo "Instalando Chrome..."
sudo apt install ./google-chrome-stable_current_amd64.deb -y

echo "Removendo Download do Chrome..."
rm -rf /home/posvenda/Documentos/google-chrome-stable_current_amd64.deb

echo "Baixando Anydesk..."
wget https://download.anydesk.com/linux/anydesk_6.1.0-1_amd64.deb -O anydesk.deb

echo "Instalando Anydesk..."
sudo apt install ./anydesk.deb -y

echo "Removendo Download do Anydesk..."
rm -rf /home/posvenda/Documentos/anydesk.deb

echo "Removendo Chaveiros de sessão..."
sudo apt remove --purge gnome-keyring -y

echo "Executando Wine p/ criação de partições..."
winecfg
