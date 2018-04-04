FROM microsoft/powershell

LABEL maintainer="Praveen Chamarthi"

# Install Python3, make soft link to /usr/bin/python3
# then install azure-cli
RUN apt-get install -y python3 && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ xenial main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893 && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y azure-cli

# Install Dotnet core 2.1.103 sdk
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    export DOTNET_CLI_TELEMETRY_OPTOUT=true && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list && \
    apt-get update && \
    apt-get install -y dotnet-sdk-2.1.103

CMD [ "bash" ]