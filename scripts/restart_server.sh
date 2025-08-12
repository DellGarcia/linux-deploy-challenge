source $(dirname "$0")/ping_server.sh
source $(dirname "$0")/discord_hook_notifier.sh
source $(dirname "$0")/logger.sh
source $(dirname "$0")/.env.sh

tryRestartServer()
{
    msg1="(REINICIANDO)"
    msg2="Tentando reiniciar o Servidor."
    logToFile "$LOG_ERROR_FILENAME" "$msg1" "$ms2"
    notifyOnDiscord NGX_DROID "$msg1" "$msg2"

    systemctl restart nginx

    head=$( pingServer )

    if [ -z $head ]
        then
            msg1="(FALHA)"
            msg2="Não foi possíveil reiniciar o servidor."
            logToFile "$LOG_ERROR_FILENAME" "$msg1" "$msg2"
            notifyOnDiscord NGX_DROID "$msg1" "$msg2"
    elif [ $head -ne 200 ]
        then
            logToFile "$LOG_ERROR_FILENAME" "(STATUS INESPERADO)" "Servidor retornou código $head"
    else      
        msg1="(SERVIDOR REINICIADO)"
        msg2="O servidor voltou a ativa"
        logToFile "$LOG_ERROR_FILENAME" "$msg1" "$msg2"
        notifyOnDiscord NGX_DROID "$msg1" "$msg2"
    fi
}
