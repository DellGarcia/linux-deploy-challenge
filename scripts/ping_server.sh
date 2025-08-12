source $(dirname "$0")/.env.sh

pingServer() 
{
    head=$(curl -I -s -# http://localhost:$SERVER_PORT | head -n 1 | cut -d $' ' -f2)
    echo $head
}
