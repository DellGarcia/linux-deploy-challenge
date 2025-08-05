head=$(curl -I -# http://localhost:80 | head -n 1 | cut -d $' ' -f2) 

if [ -z $head ]
    then
        echo "Não foi possível estabelecer comunicação com o servidor"

elif [ $head -ne 200 ]
    then
        echo "Aplicação retornou status inesperado: $head"
else [ $head]
    then
        echo "Aplicação rodando"
fi