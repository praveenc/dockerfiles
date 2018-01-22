$erl_cookie_windir = "${env:windir}\System32\config\systemprofile"
$erl_cookie_rmqdir = "${env:HOMEDRIVE}${env:HOMEPATH}"
$cname = $env:COMPUTERNAME
$rmq_bin_dir = "${env:RMQ_DIR}\rabbitmq_server-${env:RABBITMQ_VERSION}\sbin"
$rmq_vhost_name = "${env:RMQ_VHOST_NAME}"
$rmq_pass = "${env:RMQ_ADMIN_PASSWORD}"
$rmq_user = "${env:RMQ_ADMIN_USERNAME}"

Set-Location $rmq_bin_dir
./rabbitmq-service.bat install
./rabbitmq-service.bat enable
./rabbitmq-service.bat start

Write-Output "[$cname]: -- Checking Status of RabbitMQ Service ..."
Get-Service -Name RabbitMQ

do {
    Write-Output "[$cname]: -- Waiting for .erlang.cookie ..."

} while (-not (Test-Path ("$erl_cookie_windir" + "\.erlang.cookie")))

if(Test-Path ("$erl_cookie_windir"+"\.erlang.cookie")) 
{
    Write-Output "[$cname]: -- Copying Erlang Cookie (.erlang.cookie) to $erl_cookie_rmqdir ..."
    Copy-Item "$erl_cookie_windir\.erlang.cookie" -Destination "$erl_cookie_rmqdir\.erlang.cookie" -Force

}else {
    Write-Output "[$cname]: -- .erlang.cookie not found"
}

Write-Output "[$cname]: -- Enabling Management Plugins ..."
./rabbitmq-plugins.bat enable rabbitmq_management

Write-Output "[$cname]: -- Adding Virtual Host: ${env:RMQ_VHOST_NAME} ..."
./rabbitmqctl.bat add_vhost $rmq_vhost_name

Write-Output "[$cname]: -- Adding User: $rmq_user ..."
./rabbitmqctl.bat add_user $rmq_user $rmq_pass
./rabbitmqctl.bat set_user_tags $rmq_user administrator
./rabbitmqctl.bat set_permissions -p $rmq_vhost_name $rmq_user ".*" ".*" ".*"
./rabbitmqctl.bat set_permissions -p / $rmq_user ".*" ".*" ".*"

Write-Output "[$cname]: -- Stopping, Uninstalling RMQ Service ..."
./rabbitmq-service.bat stop
./rabbitmq-service.bat disable
./rabbitmq-service.bat remove 

Write-Output "[$cname]: -- Starting RMQ Server as Application (rabbitmq-server.bat)..."
./rabbitmq-server.bat start_app