start: .ALWAYS
	vagrant up

stop: .ALWAYS
	vagrant halt

clean: .ALWAYS
	vagrant destroy -f

install: install-deb

install-deb:
	wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
	apt update && apt install -y vagrant

provision: .ALWAYS
	vagrant provision

.ALWAYS:
