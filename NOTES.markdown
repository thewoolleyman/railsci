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
* Current AMI: ???


Dev Environment Setup
=====================
* EC2 API Tools: http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88
* EC2 AMI Tools: http://developer.amazonwebservices.com/connect/entry.jspa?externalID=368&categoryID=88
* Install both to ~/bin/..., add their bin dirs to OSX /etc/paths.d/ec2

EC2 AMI Setup Notes:
================
* Creating image: http://github.com/thewoolleyman/amibuilder
