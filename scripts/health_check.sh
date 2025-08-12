source $(dirname "$0")/.env.sh
source $(dirname "$0")/discord_hook_notifier.sh
source $(dirname "$0")/logger.sh

head=$(curl -I -s -# http://localhost:$SERVER_PORT | head -n 1 | cut -d $' ' -f2)

if [ -z $head ]
    then
        msg1="(SERVIDOR FORA DO AR)"
        msg2="Não foi possível estabelecer comunicação com o servidor."
        
        logToFile health_check_error.log "$msg1" "$msg2"
        notifyOnDiscord NGX_DROID "$msg1" "$msg2"

elif [ $head -ne 200 ]
    then
        msg1="(PROBLEMA NO SERVIDOR)"
        msg2="Aplicação retornou status inesperado: $head"
        echo "[$now]: $msg1 $msg2" >> /var/log/ngx_server/health_check_error.log

        logToFile health_check_error.log "$msg1" "$msg2"
        notifyOnDiscord NGX_DROID "$msg1" "$msg2"
else
    msg1="(SERVIDOR OK)"
    msg2="O servidor está funcionando como esperado."
    logToFile health_check.log "$msg1" "$msg2"
fi
