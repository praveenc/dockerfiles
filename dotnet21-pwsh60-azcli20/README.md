# What's in the image
* dotnet core 2.1 sdk
* Azure-cli 2.0
* powershell core 6.0.2 (pwsh)
* python 3.5.4
* Based off of microsoft/powershell (core) image
* Installs Python 3.5.4 and then installs azure-cli
* Installs dotnet-2.1 sdk 

# Reference docs
* [Install Azure CLI 2.0 with apt](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest)
* [Install .NET Core SDK on Linux Ubuntu 16.04](https://www.microsoft.com/net/download/linux-package-manager/ubuntu16-04/sdk-current)

## Build this image using docker
```$ docker build -t dotnetcorebuild .```

## Running this image as a container in docker
```$ docker run -it dotnetcorebuild```

## using this image as your build container in bitbucket pipelines (bitbucket cloud)
* sample ```bitbucket-pipelines.yml``` file
```
image: praveenc/dotnet21-pwsh60-azcli20
pipelines:
default:
    - step:
        name: Build and upload artifacts
        script:
        # Build dotnet apps with dotnet restore, build and publish commands
        - dotnet restore
        - dotnet build $NETCORE_PROJECT_NAME
        - dotnet publish -c release -o out
        # Run python 3 scripts
        - python ../scripts/upload_build.py
        # Run powershell scripts
        - pwsh ../scripts/env-init.ps1

```
