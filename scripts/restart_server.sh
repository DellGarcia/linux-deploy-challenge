source $(dirname "$0")/ping_server.sh
source $(dirname "$0")/logger.sh
source $(dirname "$0")/.env.sh

tryRestartServer()
{
    logToFile $LOG_ERROR_FILENAME "(Reiniciando)" "Tentando reiniciar o Servidor."
    systemctl restart nginx

    head=$( pingServer )

    if [ -z $head ]
        then
            logToFile $LOG_ERROR_FILENAME "(Falha)" "Não foi possíveil reiniciar."
    elif [ $head -ne 200 ]
        then
            logToFile $LOG_ERROR_FILENAME "(Status inesperado)" "Servidor retornou código $head"
    else      
        logToFile $LOG_FILENAME "(Servidor Reiniciado)" "O servidor voltou a ativa"
    fi
}