iptables -t raw -F
iptables -t raw -I PREROUTING -j DROP -p tcp -m string --string "HEAD" --algo kmp --to 65535 -m tcp --dport 30120   
iptables -t raw -I PREROUTING -j DROP -p tcp -m string --string "Mozilla" --algo kmp --to 65535 -m tcp --dport 30120
iptables -t raw -I PREROUTING -j DROP -p tcp -m string --string "Edge" --algo kmp --to 65535 -m tcp --dport 30120
iptables -t raw -I PREROUTING -j DROP -p tcp -m string --string "Chrom" --algo kmp --to 65535 -m tcp --dport 30120
iptables -t raw -I PREROUTING -j DROP -p tcp -m string --string "Gecko" --algo kmp --to 65535 -m tcp --dport 30120
iptables -t raw -I PREROUTING -j DROP -p tcp -m string --string "Linux" --algo kmp --to 65535 -m tcp --dport 30120
iptables -t raw -I PREROUTING -j DROP -p tcp -m string --string "Firefox" --algo kmp --to 65535 -m tcp --dport 30120
iptables -t raw -I PREROUTING -j DROP -p tcp -m string --string "Gecko" --algo kmp --to 65535 -m tcp --dport 30120
# You can change the port here
echo -e "\033[32;5mStarting Attack Logs \033[0m"
interface=eth0
 url='https://ptb.discord.com/api/webhooks/xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxx' #change to your webhook
while /bin/true; do
  pkt_old=`grep $interface: /proc/net/dev | cut -d :  -f2 | awk '{ print $2 }'`
  sleep 1
  pkt_new=`grep $interface: /proc/net/dev | cut -d :  -f2 | awk '{ print $2 }'`
 
  pkt=$(( $pkt_new - $pkt_old ))
  echo -ne "\r$pkt packets/s\033[0K"
  if [ $pkt -gt 30000 ]; then ## Attack alert will display after incoming traffic reach 30000 PPS
  echo 
    echo "Attack Detected"
    curl -H "Content-Type: application/json" -X POST -d '{
      "embeds": [{
      	"inline": true,
        "title": "Attack Detected",
        "username": "Attack Alerts",
        "color": 15158332,
         "thumbnail": {
          "url": "https://media.discordapp.net/attachments/836188792800149525/863893774379778068/am0ngsusxh-36.gif"
        },
         "footer": {
            "text": "Credit by sokin#6666 | sokin.eu",
            "icon_url": "https://cdn.discordapp.com/icons/765929030171754537/a_5b7ad63a01061fedb81a7a76850a8116.gif?size=2048"
          },
    
        "description": "Detection of an attack ",
         "fields": [
      {
        "name": "**Packets**",
        "value": "'$pkt'",
        "inline": true
      }
    ]
      }]
    }' $url
    echo "Paused for 500 sec"
    sleep 500
  fi
done
