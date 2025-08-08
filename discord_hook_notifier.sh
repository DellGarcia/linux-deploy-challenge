source ./.env.sh

notifyOnDiscord() 
{
    username=$1
    title=$2
    description=$3

    json=$(jq -n \
    --arg username "$username" \
    --arg title "$title" \
    --arg description "$description" \
    '{
        username: $username,
        embeds: [
        {
            title: $title,
            description: $description
        }
        ]
    }')

    res=$(curl  -X POST \
                -H "Content-Type: application/json" \
                -d "$json" \
                -s \
                $DISCORD_WEBHOOK)
}

# {
#   "content": "This is a test message sent from Postman!",
#   "username": "Postman Bot",
#   "embeds": [
#     {
#       "title": "API Test Result",
#       "description": "The test was successful."
#     }
#   ]
# }