---Server Setup Script---

  Meant to be run on a clean installation of Ubuntu Server 20. 
  
  Does all the intitial setup that I usually need done on every server.
  Configures my LAMP Stack,
  creates a new virtual host in apache
  creates the servername.conf file and enables it
  runs mysql_secure_installation
  Removes indexes for the Web Root directory
  assigns www-data as the owner of Web Root recursively
  and installs phpmyadmin.
  
  If you see anything I could have done differently PLEASE let me know.. I am always interested in learning new ways of doing things
  and I welcome constructive criticism. You can contact me at postmaster@localserver.network. 
