# SecurityLearningProgram

Setup for the Mozaic Works Security Learning Program.

It contains a:

* virtual machine set up with Kali Linux
* docker containers for various applications to use for exercises
* the docker containers are set up as services that start automatically

## Setup

* Install vagrant
* Install virtualbox
* Clone the repo
* Go in the directory and run `vagrant up`

This will start the virtual machine, run the provisioning process that gets all the containers and installs them, and start the services. This process last a few minutes, since it downloads a lot of things.

On Ubuntu:

```
sudo apt install vagrant
sudo apt install virtualbox
git clone git@github.com:MozaicWorks/SecurityLearningProgram.git
cd SecurityLearningProgram
vagrant up
```

## How to Use

* Login with `vagrant`/`vagrant`
* Check that the web apps are started on localhost:8080 and localhost:3000
* Launch ThreatDragon
* Have fun with security testing!

