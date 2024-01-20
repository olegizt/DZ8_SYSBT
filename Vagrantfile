# -*- mode: ruby -*-
# vi: set ft=ruby :
home = ENV['HOME']
ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure(2) do |config|
	config.vm.box = "cdaf/CentOSLVM"
	config.vm.box_version = "2022.10.09"
	config.vm.provider "virtualbox" do |v|
	v.memory = 512
	v.cpus = 2
	end
	config.vm.define "sysboot" do |sysboot|
		sysboot.vm.hostname = "sysboot"
		sysboot.vm.provision "shell", path: "lvmrename.sh"
    end
end