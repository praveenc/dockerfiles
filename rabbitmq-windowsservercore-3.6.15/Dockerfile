# escape=`
FROM praveenc/erlang-windowsservercore:20.2
SHELL [ "powershell" ]

LABEL Description="RabbitMQ for Windows" Version="3.6.15" Vendor="RabbitMQ" MAINTAINER="Praveen Chamarthi"

ENV RABBITMQ_VERSION=3.6.15 `
    RABBITMQ_NODENAME="rabbit" `
    RMQ_ADMIN_USERNAME="rmquser" `
    RMQ_ADMIN_PASSWORD="11P@ssw0rd11" `
    RMQ_DIR=c:\rabbitmq `
    RMQ_VHOST_NAME="MYVIRTUALHOST" `
    HOMEDRIVE=C: `
    HOMEPATH=\Users\ContainerAdministrator `
    DOWNLOADS_DIR=C:\Downloads

RUN New-Item -ItemType Directory -Force -Path $env:DOWNLOADS_DIR; `
    Set-Location $env:DOWNLOADS_DIR; `
    Invoke-WebRequest https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_15/rabbitmq-server-windows-3.6.15.zip -OutFile rabbitmq-server-windows-3.6.15.zip; `
    Expand-Archive rabbitmq-server-windows-3.6.15.zip -DestinationPath $env:RMQ_DIR -Force;

ADD configure-rmq.ps1 .

# Erlang Cookie Mismatch Hack
# https://stackoverflow.com/questions/40528775/rabbitmq-node-authentification-failed-after-changing-cookie-file
# WindowsServer2016 Erlang Cookie Resides here C:\Windows\System32\config\systemprofile
# RMQ Defaults user cookie here %HOMEDRIVE%%HOMEPATH% C:\users\[username]
# Copy the cookie from C:\windows\SYSTEM32\..\systemprofile\.erlang.cookie
# Enable RabbitMQ Managment plugins, Start, Add new user rmquser, delete default vhost and default user (guest)

# Enable Management Plugin, add new management user (RMQ_USERNAME) - Finally Stop and Uninstall service
# This container starts as an executable using rabbitmq-server.bat
# Also Remove downloads folder

ADD configure-rmq.ps1 .

# Expose RMQ Default Ports
EXPOSE 4369 5671 5672 25672 15672

## Entrypoint will be the Powershell Script
ENTRYPOINT [ "powershell.exe" ]
CMD [ "./configure-rmq.ps1" ]