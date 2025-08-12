source $(dirname "$0")/ping_server.sh
source $(dirname "$0")/discord_hook_notifier.sh
source $(dirname "$0")/logger.sh
source $(dirname "$0")/.env.sh

tryRestartServer()
{
    msg1="(Reiniciando)"
    msg2="Tentando reiniciar o Servidor."
    logToFile "$LOG_ERROR_FILENAME" \(Reiniciando\) "$ms2"
    notifyOnDiscord NGX_DROID "$msg1" "$msg2"

    systemctl restart nginx

    head=$( pingServer )

    if [ -z $head ]
        then
            logToFile "$LOG_ERROR_FILENAME" "(Falha)" "Não foi possíveil reiniciar."
    elif [ $head -ne 200 ]
        then
            logToFile "$LOG_ERROR_FILENAME" "(Status inesperado)" "Servidor retornou código $head"
    else      
        logToFile "$LOG_FILENAME" "(Servidor Reiniciado)" "O servidor voltou a ativa"
    fi
}