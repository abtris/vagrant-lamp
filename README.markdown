What
====
Vagrant/Chef files for a LAMP server

How
===
1. Install [vagrant](http://vagrantup.com/)
    gem install vagrant
2. Download and Install [VirtualBox](http://www.virtualbox.org/)
3. Download a vagrant box (name of the box is supposed to be lucid32)
    vagrant box add lucid32 http://files.vagrantup.com/lucid32.box
4. Clone this repo
5. Go to the repo and launch the box
    cd [repo]
    vagrant init
    vagrant up
6. Add this line to your /etc/hosts (or windows equivalent)
    127.0.0.1 www.dev-site.com dev-site.com dev.dev-site-static.com    

7. 1st time after run vagrant up need for working couchdb port run vagrant reload for reload port forwarding

That's it, the file in [repo]/public/ are served here : [http://www.dev-site.com:8080/](http://www.dev-site.com:8080/)

You can add `XDEBUG_PROFILE` to your GET parameter to generate an xdebug trace, e.g. [http://www.dev-site.com:8080/?XDEBUG_PROFILE](http://www.dev-site.com:8080/?XDEBUG_PROFILE)

You can then investigate at [http://localhost:8080/webgrind/](http://localhost:8080/webgrind/)

Adminer (mysql tool) is available [http://localhost:8080/adminer/adminer/](http://localhost:8080/adminer/adminer/). User `myadmin`, Password `myadmin`

CouchDb console is is available [http://localhost:5984/](http://localhost:5984/).