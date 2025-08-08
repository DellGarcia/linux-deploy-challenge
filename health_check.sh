source $(dirname "$0")/discord_hook_notifier.sh

echo $(pwd)

now="$(date +"%D %T")"
log_folder=/var/log/ngx_server/
mkdir -p $log_folder
head=$(curl -I -s -# http://localhost:80 | head -n 1 | cut -d $' ' -f2) 

if [ -z $head ]
    then
        msg1="(SERVIDOR FORA DO AR)"
        msg2="Não foi possível estabelecer comunicação com o servidor"
        echo "[$now]: $msg1 $msg2" >> /var/log/ngx_server/health_check_error.log
        notifyOnDiscord NGX_DROID "$msg1" "$msg2"

elif [ $head -ne 200 ]
    then
        msg1="(PROBLEMA NO SERVIDOR)"
        msg2="Aplicação retornou status inesperado: $head"
        notifyOnDiscord NGX_DROID "$msg1" "$msg2" >> /var/log/ngx_server/health_check_error.log
else
    echo "[$now]: O servidor está funcionando como esperado." >> /var/log/ngx_server/health_check.log
fi