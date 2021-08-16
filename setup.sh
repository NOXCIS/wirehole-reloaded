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
echo "___.          _______                      .__           ";
echo "\_ |__ ___.__.\      \   _______  ___ ____ |__| ______   ";
echo " | __ <   |  |/   |   \ /  _ \  \/  // ___\|  |/  ___/   ";
echo " | \_\ \___  /    |    (  <_> >    <\  \___|  |\___ \    ";
echo " |___  / ____\____|__  /\____/__/\_ \\___  >__/____  >   ";
echo "     \/\/            \/            \/    \/        \/    ";
echo "               Script wirtten by Shamar Lee              ";         
echo "                                                         ";
echo "                        Thanks to                        ";
echo "                                                         ";
echo "                   IAmStoxe on Github                    ";
echo "                     jc21 on Github                      ";
echo "                   WeeJeWel on Github                    ";
echo "                                                         ";


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
