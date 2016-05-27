ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

config.vm.provider 'virtualbox' do |v,override|
  v.memory = 4098
  v.cpus = 2
end

config.vm.network 'forwarded_port', guest: 2080, host: 2080, auto_correct: true
config.vm.provision 'shell', inline: <<-EOS
dist=`grep ^ID= /etc/*-release | awk -F '=' '{print $2}' | tr -d '"'`
if [ "$dist" == "ubuntu" ]; then
  curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
elif [ "$dist" == "centos" ]; then
  curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash
else
  echo 'Only centos and ubuntu are implemented for GitLab autosetup'
  exit 1
fi
EOS
