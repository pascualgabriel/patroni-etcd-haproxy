Vagrant.configure("2") do |config|

  config.vm.define "haproxy_01" do |haproxy_01|

    haproxy_01.vm.box = "rockylinux/8"

    config.vm.box_version = "4.0.0"

    haproxy_01.vm.provider "libvirt" do |libvirt|
      libvirt.cpus = 1
      libvirt.memory = "1024"
    end

    haproxy_01.vm.network "private_network", ip: "192.168.7.11"

    config.vm.synced_folder "HAProxy/", "/vagrant"

    haproxy_01.vm.provision :shell, path: "HAProxy/haproxy-01-bootstrap.sh"

  end

  config.vm.define "haproxy_02" do |haproxy_02|

    haproxy_02.vm.box = "rockylinux/8"

    config.vm.box_version = "4.0.0"

    haproxy_02.vm.provider "libvirt" do |libvirt|
      libvirt.cpus = 1
      libvirt.memory = "1024"
    end

    haproxy_02.vm.network "private_network", ip: "192.168.7.12"

    config.vm.synced_folder "HAProxy/", "/vagrant"

    haproxy_02.vm.provision :shell, path: "HAProxy/haproxy-01-bootstrap.sh"

  end

end
