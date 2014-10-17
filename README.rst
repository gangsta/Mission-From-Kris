Here is Mission from Kris
=========================

Kris-(Your mission, if you choose to accept it,is to build a set of  puppetized
vagrant boxen which deploy Rundeck on one node.   Then create a runbook on
Rundeck which restart a simple service (sshd) on the other node.)



So first I must learn  to make commands with Rundeck to restart sshd,
then use Vagrant to make Vagrantfile were is too installed CentosBox
(why Centos?because most people use it) and make too  many of Rundeck machines,
exp. Rundeck_master & Rundeck_slave.  In the end I must
make Rundeck_master.pp & Rundeck_slave.pp for config Puppet(also site.pp) ,
if after installing, I can run my Vagrant without problem,then i must have job 
in Rundeck wich restart service sshd.  
