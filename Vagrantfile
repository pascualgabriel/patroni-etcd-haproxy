Vagrant.configure("2") do |config|

  #
  # GLOBAL
  #

  config.disksize.size = "15GB"

  #
  # HAPROXY
  #

  config.vm.define "haproxy_01" do |haproxy_01|

    haproxy_01.vm.box = "rockylinux/8"

    haproxy_01.vm.box_version = "4.0.0"

    haproxy_01.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "1024"
    end

    haproxy_01.vm.hostname = "haproxy-01"

    haproxy_01.vm.synced_folder ".", "/opt/patroni-etcd-haproxy"

    haproxy_01.vm.network "private_network", ip: "10.10.0.2"

    haproxy_01.vm.provision :shell,
      inline: "bash /opt/patroni-etcd-haproxy/HAProxy/vm/bootstrap.sh"

  end

  config.vm.define "haproxy_02" do |haproxy_02|

    haproxy_02.vm.box = "rockylinux/8"

    haproxy_02.vm.box_version = "4.0.0"

    haproxy_02.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "1024"
    end
    
    haproxy_02.vm.hostname = "haproxy-02"

    haproxy_02.vm.synced_folder ".", "/opt/patroni-etcd-haproxy"

    haproxy_02.vm.network "private_network", ip: "10.10.0.3"

    haproxy_02.vm.provision :shell,
      inline: "bash /opt/patroni-etcd-haproxy/HAProxy/vm/bootstrap.sh"

  end

  #
  # DOCKER
  #

  config.vm.define "dockyard" do |dockyard|

    dockyard.vm.box = "rockylinux/8"

    dockyard.vm.box_version = "4.0.0"

    dockyard.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "4096"
    end

    dockyard.vm.synced_folder ".", "/opt/patroni-etcd-haproxy"

    dockyard.vm.network "private_network", ip: "10.10.0.30"

    dockyard.vm.provision :shell, path: "dockyard-bootstrap.sh"

  end

  #
  # ETCD
  #

  config.vm.define "etcd_01" do |etcd_01|

    etcd_01.vm.box = "rockylinux/8"

    etcd_01.vm.box_version = "4.0.0"

    etcd_01.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "1024"
    end

    etcd_01.vm.hostname = "etcd-01"

    etcd_01.vm.synced_folder ".", "/opt/patroni-etcd-haproxy"

    etcd_01.vm.network "private_network", ip: "10.10.0.10"

    etcd_01.vm.network "forwarded_port", guest: 2379, host: 2371, auto_correct: true
    etcd_01.vm.network "forwarded_port", guest: 2380, host: 2381, auto_correct: true

    etcd_01.vm.provision :shell,
      inline: "bash /opt/patroni-etcd-haproxy/etcd/vm/bootstrap.sh"

  end

  config.vm.define "etcd_02" do |etcd_02|

    etcd_02.vm.box = "rockylinux/8"

    etcd_02.vm.box_version = "4.0.0"

    etcd_02.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "1024"
    end

    etcd_02.vm.hostname = "etcd-02"

    etcd_02.vm.synced_folder ".", "/opt/patroni-etcd-haproxy"

    etcd_02.vm.network "private_network", ip: "10.10.0.11"

    etcd_02.vm.network "forwarded_port", guest: 2379, host: 2372, auto_correct: true
    etcd_02.vm.network "forwarded_port", guest: 2380, host: 2382, auto_correct: true

    etcd_02.vm.provision :shell,
      inline: "bash /opt/patroni-etcd-haproxy/etcd/vm/bootstrap.sh"

  end

  config.vm.define "etcd_03" do |etcd_03|

    etcd_03.vm.box = "rockylinux/8"

    etcd_03.vm.box_version = "4.0.0"

    etcd_03.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "1024"
    end

    etcd_03.vm.hostname = "etcd-03"

    etcd_03.vm.synced_folder ".", "/opt/patroni-etcd-haproxy"

    etcd_03.vm.network "private_network", ip: "10.10.0.12"

    etcd_03.vm.network "forwarded_port", guest: 2379, host: 2373, auto_correct: true
    etcd_03.vm.network "forwarded_port", guest: 2380, host: 2383, auto_correct: true

    etcd_03.vm.provision :shell,
      inline: "bash /opt/patroni-etcd-haproxy/etcd/vm/bootstrap.sh"

  end

  #
  # PATRONI
  #

  config.vm.define "patroni_01" do |patroni_01|

    patroni_01.vm.box = "rockylinux/8"

    patroni_01.vm.box_version = "4.0.0"

    patroni_01.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "2048"
    end

    patroni_01.vm.hostname = "patroni-01"

    patroni_01.vm.synced_folder ".", "/opt/patroni-etcd-haproxy"

    patroni_01.vm.network "private_network", ip: "10.10.0.20"

    patroni_01.vm.network "forwarded_port", guest: 5432, host: 5432, auto_correct: true
    patroni_01.vm.network "forwarded_port", guest: 8008, host: 8008, auto_correct: true

    patroni_01.vm.provision :shell,
      inline: "bash /opt/patroni-etcd-haproxy/patroni/vm/bootstrap.sh",
      env: {"OS_PATRONI_USER_PASS" => "example"}

  end

  config.vm.define "patroni_02" do |patroni_02|

    patroni_02.vm.box = "rockylinux/8"

    patroni_02.vm.box_version = "4.0.0"

    patroni_02.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "2048"
    end

    patroni_02.vm.hostname = "patroni-02"

    patroni_02.vm.synced_folder ".", "/opt/patroni-etcd-haproxy"

    patroni_02.vm.network "private_network", ip: "10.10.0.21"

    patroni_02.vm.network "forwarded_port", guest: 5433, host: 5432, auto_correct: true
    patroni_02.vm.network "forwarded_port", guest: 8009, host: 8009, auto_correct: true

    patroni_02.vm.provision :shell,
      inline: "bash /opt/patroni-etcd-haproxy/patroni/vm/bootstrap.sh",
      env: {"OS_PATRONI_USER_PASS" => "example"}

  end

end
