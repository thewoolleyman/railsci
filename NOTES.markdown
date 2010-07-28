SERVERS
=======
* ci.rubyonrails.org: slicehost VM, just runs Pivotal Pulse for Rails builds
* EC2 instances donated by EngineYard
  * mri186.ci.rubyonrails.org
    * 174.129.2.92
  * mri187.ci.rubyonrails.org
    * 174.129.2.242
  * mri19.ci.rubyonrails.org
    * 174.129.4.111
  * demo.ci.rubyonrails.org
    * 174.129.13.177

EC2 Info
========
* Current Base AMI: ami-4b4ba522 - Ubuntu 10.04 LTS (Lucid Lynx) (us-east-1)
* Current Rails CI AMI: ami-2d4aa444	(pre-boxbuilder)

* Alestic AMI list: http://alestic.com/
* Ubuntu AMI list: http://uec-images.ubuntu.com/releases/lucid/release/

Dev Environment Setup
=====================
* EC2 API Tools: http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88
* EC2 AMI Tools: http://developer.amazonwebservices.com/connect/entry.jspa?externalID=368&categoryID=88
* Install both to ~/bin/..., add their bin dirs to OSX /etc/paths.d/ec2

EC2 AMI Setup Notes:
================
* Creating image: http://github.com/thewoolleyman/amibuilder

TODO:
=====
Understand and use chef server to do all this, e.g.:

http://www.slideshare.net/rberger/chef-08-knife-and-amazon-ec2
http://blog.ibd.com/scalable-deployment/creating-an-amazon-ami-for-chef-0-8/