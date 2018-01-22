# escape=`
FROM microsoft/windowsservercore:latest

LABEL Description="Erlang for Windows" Version="20.2.2" Vendor="Erlang" MAINTAINER="Praveen Chamarthi"

ENV OTP_VERSION="20.2" `
    ERLANG_HOME="C:\\Program Files\\erl9.2\\" `
    ERLANG_SERVICE_MANAGER_PATH="C:\\Program Files\\erl9.2\\erts-9.2\\bin"

# Install Chocolatey first
RUN powershell -NoProfile -Command `
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Erlang    
RUN choco install -y erlang;

ENTRYPOINT [ "C:\\Program Files\\erl9.2\\erts-9.2\\bin\\erl.exe" ]