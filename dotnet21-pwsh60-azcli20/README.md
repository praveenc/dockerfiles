# Build Container - .NET Core 2.1 SDK , Azure-cli 2.0 and Powershell Core 6.0.2

* Based off of microsoft/powershell (core) image
* Installs Python 3.5.4 and then installs azure-cli
* Installs dotnet-2.1 sdk 
* image published to praveenc/dotnet21-pwsh60-azcli20 on docker hub
* image could be used as build container in bitbucket pipelines

## BITBUCKET-PIPELINES.YML
```
image: praveenc/dotnet21-pwsh60-azcli20
pipelines:
  default:
    - step:
        name: Build and upload artifacts
        script:
          - export AZ_SP_USERNAME=${AZ_SP_USERNAME}
          - export AZ_SP_PASSWORD=${AZ_SP_PASSWORD}
          - export AZ_TENANT_ID=${AZ_TENANT_ID}
          - cd netcoreapp
          - dotnet restore
          - dotnet build $NETCORE_PROJECT_NAME
          - dotnet publish -c release -o out
          # Run upload_build.py to create storage account in azure and upload build artifacts
          - python ../scripts/upload_build.py

```
