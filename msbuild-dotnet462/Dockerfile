# escape=`
FROM microsoft/dotnet-framework:4.6.2

LABEL Maintainer="Praveen Chamarthi <praveen.chamarthi@outlook.com>"

ENV TOOLS_DIR=c:\tools

RUN powershell -NoProfile -Command `
    New-Item -ItemType Directory -Force -Path $env:TOOLS_DIR; `
    Invoke-WebRequest "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile $env:TOOLS_DIR\nuget.exe

ENV PATH=${TOOLS_DIR};c:\Windows\Microsoft.NET\Framework64\v4.0.30319;${PATH}

ENTRYPOINT [ "cmd.exe" ]


