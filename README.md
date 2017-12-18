# Docker Image for Oracle Enterprise Pack for Eclipse

This is the repository for creating a Docker Image from where you can running Enterprise Pack for Eclipse in Windows.

## Jenkins Pipeline for creating the image:
* At first your Linux VM should contain a local docker registry on port 5000, you can use the default docker registry image for this
* Download oepe-<Version>-<Eclipse-Release>-distro-linux-gtk-x86_64.zip to /software/Oracle/Enterprise Pack for Eclipse
* Create a Jenkins Job from provided Jenkinsfile and start it to build the image and put it to the local registry.

## Starting Enterprise Pack for Eclipse from Windows
* At first your Linux VM should contain the screen package, you install it like "sudo apt-get -y install screen"
* Start MobaXTerm and connect to your Linux VM via ssh
* Check in the MobaXTerm Banner that X-11 forwarding is enabled
* Mouse hover the MobaXTerm XServer Icon to find the DISPLAY Variable and export this in the shell
* Start SQL Developer via
    * export DISPLAY=&lt;X Server address>
    * sudo docker run -ti --rm --name="oepe.12.2.1.6" -e DISPLAY -v $HOME/.Xauthority:/home/oracle/.Xauthority --net=host localhost:5000/oracle/oepe:12.2.1.6
