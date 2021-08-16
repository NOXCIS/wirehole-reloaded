# wirehole-reloaded
Wirehole like container setup with inclusion of wireguard control gui by WeeJeWel & Wordpress

  
  ## Installation
  ## Run these commands on clean server to set up
  
  1.
  ````
  $ sudo nano setup.sh
  `````
  2. copy script below into setup.sh, save and exit.
  ````bash
  
#!/bin/bash

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
    wget https://raw.githubusercontent.com/WeeJeWel/wg-easy/master/docker-compose.yml
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
4. Press Ctrl + C after every container install to continue the script.
````
#This is nessary for the time being. As i dont know how to force continue the script without stopping the containers after creation.
Also i want the script to negate the use of kil, so i cant use PID Ids. 
HELP NEEDED
````
