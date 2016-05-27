config.vm.provision 'shell', inline: <<-EOS
dist=`grep ^ID= /etc/*-release | awk -F '=' '{print $2}' | tr -d '"'`
if [ "$dist" == "ubuntu" -o "$dist" == 'debian' ]; then
  apt-get update
  apt-get install -y dh-make
elif [ "$dist" == "centos" ]; then
  yum install -y rpm-build
elif [ "$dist" == "fedora" ]; then
  dnf install -y rpm-build
else
  echo "Distro $dist isn't supported"
  exit 1
fi
EOS
