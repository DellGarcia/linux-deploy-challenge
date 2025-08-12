source $(dirname "$0")/.env.sh

now="$(date +"%D %T")"
mkdir -p $log_folder


logToFile()
{
    filename=$1
    title=$2
    description=$3

    echo "[$now]: $msg1 $msg2" >> "$LOG_FOLDER/$filename"
}
