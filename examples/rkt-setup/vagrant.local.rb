ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

repo = ENV['TESTING']? 'home:artem_sidorenko:rkt:testing' : 'home:artem_sidorenko:rkt'

config.vm.provider 'virtualbox' do |v,override|
  v.memory = 2048
  v.cpus = 2
end

config.vm.network 'forwarded_port', guest: 3080, host: 3080, auto_correct: true
config.vm.provision 'shell', inline: <<-EOS
dist=`grep ^ID= /etc/*-release | awk -F '=' '{print $2}' | tr -d '"'`
if [ "$dist" == "ubuntu" ]; then
  sh -c "echo 'deb http://download.opensuse.org/repositories/#{repo}/Ubuntu_16.04/ /' >> /etc/apt/sources.list.d/rkt.list"
  wget -O - http://download.opensuse.org/repositories/#{repo}/Ubuntu_16.04/Release.key | apt-key add -
  apt-get update
  apt-get -y install rkt acbuild
elif [ "$dist" == "debian" ]; then
  sh -c "echo 'deb http://download.opensuse.org/repositories/#{repo}/Debian_8.0/ /' >> /etc/apt/sources.list.d/rkt.list"
  wget -O - http://download.opensuse.org/repositories/#{repo}/Debian_8.0/Release.key | apt-key add -
  apt-get update
  apt-get -y install rkt acbuild02
elif [ "$dist" == "centos" ]; then
  wget -O /etc/yum.repos.d/rkt.repo http://download.opensuse.org/repositories/#{repo}/CentOS_7/#{repo}.repo
  yum -y install rkt acbuild02
elif [ "$dist" == "fedora" ]; then
  wget -O /etc/yum.repos.d/rkt.repo http://download.opensuse.org/repositories/#{repo}/Fedora_23/#{repo}.repo
  dnf -y install rkt acbuild02
else
  echo "Distro $dist isn't supported"
  exit 1
fi

usermod -a -G rkt vagrant
chgrp rkt /usr/bin/acbuild
chmod 750 /usr/bin/acbuild
chmod u+s /usr/bin/acbuild
EOS
