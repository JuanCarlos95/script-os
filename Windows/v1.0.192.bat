@echo off

echo "Preparando Máquina para instalção..."
net use T: \\192.168.0.250\TSC-Arquivos\Imagens
net use R: \\192.168.0.250\TSC-Arquivos
net use P: \\192.168.0.250\TSC-Trabin

echo "Criando Mapeamento temporário para Cópia de Softwares..."
net use W: \\192.168.0.250\TSC-ERPs

echo "Criando pasta Trabin-Software"
cd "C:\Program Files (x86)"
mkdir Trabin-Software

echo "Copiando Programas..."
xcopy W:\TSC-Pedido7 "C:\Program Files (x86)\Trabin-Software\TSC-Pedido\" /E /Y
xcopy W:\TSC-EnterpriseXE5 "C:\Program Files (x86)\Trabin-Software\TSC-EnterpriseXE5\" /E /Y

echo "Alterando mapeamento Temporário (I:\)"
cd W:\
net use W: /delete
net use W: \\192.168.0.250\TSC-Trabin

echo "Atualizando Programas..."
xcopy W:\Enterprise.exe "C:\Program Files (x86)\Trabin-Software\TSC-EnterpriseXE5" /Y /F
xcopy W:\Pedido.exe "C:\Program Files (x86)\Trabin-Software\TSC-Pedido" /Y /F

echo "Removendo mapeamento Temporário (I:\)"
net use W: /delete

cd "C:\Users\juan.latallada\Desktop"
start explorer.exe "C:\Program Files (x86)\Trabin-Software"