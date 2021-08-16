## What is this?
Wirehole Reloaded is an iprovement on Wirehole by IAmStoxe.

WireHole is a combination of WireGuard, PiHole, and Unbound in a docker-compose project with the intent of enabling users to quickly and easily create and deploy a personally managed full or split-tunnel WireGuard VPN with ad blocking capabilities (via Pihole), and DNS caching with additional privacy options (via Unbound).

# wirehole-reloaded
Wirehole-like container stack setup with inclusion of ...


+ Portainer-CE                - serves as overall gui control panel for enviorment variables once setup is complete. 
  -Runs on   "your.server.ip":9000 . 
  
+ wg-easy by WeeJeWel         - to control user and server configs, with automatic update of configs                  
  -Runs on   "your.server.ip":51821 
  
+ nginx-proxy-manager by jc21 - to limit open ports on server to a minimum via reverse proxy over 80 & 443 with ssl certs by Lets Encrypt.                     
  -Runs on   "your.server.ip":81 
                                
+ wordpress by wordpress      - addilional site hosting or whatever.                                                 
  -Runs on   "your.server.ip":2095   (for Cloudflare Proxy Support)

# NOTES
All paswords are sored as enviorment varibales in the docker-compose file. By default they are set to changeme. See setup.sh comments for more.

## Author of Wirehole Reloaded

👤 **Shamar Lee**

## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](https://github.com/NOXCIS/wirehole-reloaded/issues). 

## Show your support

Give a ⭐ if this project helped you!


<a href="https://www.paypal.com/donate?business=986V5GH5R5T4G&no_recurring=0&item_name=Buy+me+a+Coffee&currency_code=USD" target="_blank"><img src="https://i.imgur.com/6JvV0aR.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>


  
  ## Installation
  ## Run these commands on clean server to set up
  
  1.
  ````
  $ sudo nano setup.sh
  `````
  2. copy script below into setup.sh, save and exit.
  ````bash
  
#!/bin/bash

echo " __      __.__               .__           .__           ";
echo "/  \    /  \__|______   ____ |  |__   ____ |  |   ____   ";
echo "\   \/\/   /  \_  __ \_/ __ \|  |  \ /  _ \|  | _/ __ \  ";
echo " \        /|  ||  | \/\  ___/|   Y  (  <_> )  |_\  ___/  ";
echo "  \__/\  / |__||__|    \___  >___|  /\____/|____/\___  > ";
echo "       \/                  \/     \/                 \/  ";
echo "__________       .__                    .___         .___";
echo "\______   \ ____ |  |   _________     __| _/____   __| _/";
echo " |       _// __ \|  |  /  _ \__  \   / __ |/ __ \ / __ | ";
echo " |    |   \  ___/|  |_(  <_> ) __ \_/ /_/ \  ___// /_/ | ";
echo " |____|_  /\___  >____/\____(____  /\____ |\___  >____ | ";
echo "        \/     \/                \/      \/    \/     \/ ";
echo "___.            _______                      .__         ";
echo "\_ |__ ___.__.  \      \   _______  ___ ____ |__| ______ ";
echo " | __ <   |  |  /   |   \ /  _ \  \/  // ___\|  |/  ___/ ";
echo " | \_\ \___  | /    |    (  <_> >    <\  \___|  |\___ \  ";
echo " |___  / ____| \____|__  /\____/__/\_ \\___  >__/____  > ";
echo "     \/\/              \/            \/    \/        \/  ";
echo "               Script wirtten by Shamar Lee              ";         
echo "                                                         ";
echo "                        Thanks to                        ";
echo "                                                         ";
echo "                   IAmStoxe on Github                    ";
echo "                     jc21 on Github                      ";
echo "                   WeeJeWel on Github                    ";
echo "                                                         ";

sleep 5s


# Prereqs and docker
sudo apt-get update &&
    sudo apt-get install -yqq \
        curl \
        git \
        apt-transport-https \
        ca-certificates \
        gnupg-agent \
        software-properties-common

# Install Docker repository and keys
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable" &&
    sudo apt-get update &&
    sudo apt-get install docker-ce docker-ce-cli containerd.io -yqq

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
    sudo chmod +x /usr/local/bin/docker-compose &&
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


# Portainer -LOCATION -> host-ip:9000
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

# Pihole
git clone https://github.com/NOXCIS/wirehole.git
    cd wirehole &&
    docker-compose up --detach &&

# Wireguard Easy  -LOCATION -> host-ip:51821 -LOGIN changeme * can be change in portaier env varables.
mkdir ~/.wg-easy
    cd ~/.wg-easy &&
    wget https://raw.githubusercontent.com/NOXCIS/wg-easy/master/docker-compose.yml
    docker-compose up --detach &&

# Nginx_Proxy_Manager -LOGIN admin@example.com: changeme
git clone https://github.com/NOXCIS/Docker-nginx-proxy-manager.git
    cd Docker-nginx-proxy-manager &&
    docker-compose up --detach &&

# Wordpress
git clone https://github.com/NOXCIS/Docker-Wordpress.git
    cd Docker-Wordpress &&
    docker-compose up --detach &&
    cd ..
````
 
3. Run these commands
````
$ sudo chmod +x setup.sh
$ sudo ./setup.sh
`````
4. Press Ctrl + C after every container install to continue the script. If Needed.
````
Edit: This is no longer nessary. 
#This is nessary for the time being. As i dont know how to force continue the script without stopping the containers after creation.
Also i want the script to negate the use of kil, so i cant use PID Ids. 
HELP NEEDED
````
<a href="https://www.paypal.com/donate?business=986V5GH5R5T4G&no_recurring=0&item_name=Buy+me+a+Coffee&currency_code=USD" target="_blank"><img src="https://i.imgur.com/6JvV0aR.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
