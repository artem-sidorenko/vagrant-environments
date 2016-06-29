config.vm.provision 'shell', inline: <<-EOS
dist=`grep ^ID= /etc/*-release | awk -F '=' '{print $2}' | tr -d '"'`
if [ "$dist" == "ubuntu" ]; then
  apt-get update
  apt-get install -y software-properties-common
  apt-add-repository -y ppa:rael-gc/rvm
  apt-get update
  apt-get install -y rvm
  source /etc/profile.d/rvm.sh
  rvm install 2.1
  gem install bundler
else
  echo "Distro $dist isn't supported"
  exit 1
fi
EOS
