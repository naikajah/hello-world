VAGRANTFILE_API_VERSION = "2"
require 'yaml'
# node.yaml file to keep the list of nodes to be created via vagrant up command
nodes = YAML.load_file('nodes.yaml')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false

  # Box to be used for vagrant machines
  config.vm.box = "puppetlabs/ubuntu-16.04-64-nocm"
  config.vm.box_url = "https://app.vagrantup.com/puppetlabs/boxes/ubuntu-16.04-64-nocm"

  # looping through the nodes for nodes.yaml
  nodes.each do |server,cfgOptions|
    config.vm.define server do |node|
      # setting hostname
      node.vm.hostname = cfgOptions['hostname']

      # default: stdin: is not a tty
      # Ubuntu's default /root/.profile contains a line that prevents messages
      # from being written to root's console by other users.
      node.vm.provision "bootstrap", type: "shell" do |s|
          s.privileged = false
          s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
      end

      # Bootstrap shell provisioner will install the latest version of puppet in the virtual machines
      node.vm.provision "shell", path: "bootstrap.sh"

      # Option to provide IP address. If no ip is provided then the ip address
      # is allocated via dhcp
      if cfgOptions['ip']
        node.vm.network 'private_network', ip: cfgOptions['ip']
      else
        node.vm.network "private_network", type: "dhcp"
      end

      # We want to serve the application via nginx loadbalancer. Using the
      # below code the host machine's port 8080 will be forwarded to the
      # guest machine's 80 (default Nginx). This is used to run browser with
      # http://localhost:8080/ in the host machine.
      if cfgOptions['nodetype'] == "loadbalancer" then
        node.vm.network 'forwarded_port', guest: 80, host: 8080
      end

      # Option to configure the memory and cpu for the guest machine.
      node.vm.provider "virtualbox" do |v|
        v.memory = cfgOptions['memory'] ? cfgOptions['memory'] : 1024
        v.cpus = cfgOptions['vcpu'] ? cfgOptions['vcpu'] : 1
      end

      # Vagrant's puppet provisioner.
      node.vm.provision 'puppet' do |puppet|
        puppet.hiera_config_path = 'puppet/hiera.yaml'
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'site.pp'
        puppet.module_path = 'puppet/modules'
        puppet.facter = {
          "nodetype" => cfgOptions['nodetype']
        }
      end

      # Shell provisioner for loadbalancer tests
      if cfgOptions['nodetype'] == "loadbalancer" then
        node.vm.provision :shell, path: 'loadbalancer-test.sh'
      end
    end
  end
end
