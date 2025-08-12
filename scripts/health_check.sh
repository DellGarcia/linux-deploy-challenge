source $(dirname "$0")/ping_server.sh
source $(dirname "$0")/discord_hook_notifier.sh
source $(dirname "$0")/logger.sh
source $(dirname "$0")/restart_server.sh

head=$( pingServer )

if [ -z $head ]
    then
        msg1="(SERVIDOR FORA DO AR)"
        msg2="Não foi possível estabelecer comunicação com o servidor."
        
        logToFile "$LOG_ERROR_FILENAME" "$msg1" "$msg2"
        notifyOnDiscord NGX_DROID "$msg1" "$msg2"

        tryRestartServer
elif [ $head -ne 200 ]
    then
        msg1="(PROBLEMA NO SERVIDOR)"
        msg2="Aplicação retornou status inesperado: $head"

        logToFile "$LOG_ERROR_FILENAME" "$msg1" "$msg2"
        notifyOnDiscord NGX_DROID "$msg1" "$msg2"
else
    msg1="(SERVIDOR OK)"
    msg2="O servidor está funcionando como esperado."
    logToFile "$LOG_FILENAME" "$msg1" "$msg2"
fi
