ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

config.vm.provision 'shell', inline: <<-EOS
dist=`grep ^ID= /etc/*-release | awk -F '=' '{print $2}' | tr -d '"'`
if [ "$dist" == "ubuntu" -o "$dist" == 'debian' ]; then
  apt-get update
  apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  apt-get update
  apt-get install -y docker-ce
elif [ "$dist" == "centos" ]; then
  yum install -y yum-utils device-mapper-persistent-data lvm2
  yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
  yum install -y docker-ce
  systemctl start docker
fi
usermod -a -G docker vagrant
curl -LO https://omnitruck.chef.io/install.sh && sudo bash ./install.sh -P chefdk && rm install.sh
chef gem install kitchen-dokken
EOS
