# RabbitMQ 3.6.15 on WindowsServerCore

* Installs from public Erlang image on dockerhub ```praveenc/erlang-windowsservercore:20.2```
* Sets the following Environment Variables
  ```
  	RABBITMQ_VERSION=3.6.15
    RABBITMQ_NODENAME="rabbit"
    RMQ_ADMIN_USERNAME="rmquser"
    RMQ_ADMIN_PASSWORD="11P@ssw0rd11"
    RMQ_DIR=c:\rabbitmq
    RMQ_VHOST_NAME="MYVIRTUALHOST"
    HOMEDRIVE=C:
    HOMEPATH=\Users\ContainerAdministrator
    DOWNLOADS_DIR=C:\Downloads
  ```
* Downloads and Expands Rabbitmq server 3.6.15 archive from github ```https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_15/rabbitmq-server-windows-3.6.15.zip```

* Adds script ```configure-rmq.ps1``` to the image
	* ```configure-rmq.ps1``` script performs the hack for fixing "Authentication Mismatch (.erlang.cookie)" error
	* Installs rabbitmq-service using CLI tools (rabbitmq-service.bat) under <INSTALL_PATH>\sbin directory
	* Adds a new ```administrator``` user as defined in ```RMQ_ADMIN_USERNAME```
	* Adds a new Virtual Host as defined in ```RMQ_VHOST_NAME```
	* Sets User permission on this VHOST
	* Shutsdown, Disables and Removes the RabbitMQ Service
	* Starts RabbitMQ application using cmd ```rabbitmq-server.bat start_app```
	
* Exposes the following ports 
	```
	 4369 
	 5671 
	 5672 
	 25672 
	 15672
	```
* Sets Entrypoint as ```powershell.exe```
* Runs the script ```configure-rmq.ps1```
