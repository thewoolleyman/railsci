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
* AMI (old): ami-0d729464 - alestic/ubuntu-9.04-jaunty-base-20090614.manifest.xml
* AMI: ami-19a34270 - alestic/ubuntu-9.10-karmic-base-20090623.manifest.xml - AKI - aki-a71cf9ce - ARI - ari-a51cf9cc


Dev Environment Setup
=====================
* EC2 API Tools: http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88
* EC2 AMI Tools: http://developer.amazonwebservices.com/connect/entry.jspa?externalID=368&categoryID=88
* Install both to ~/bin/..., add their bin dirs to OSX /etc/paths.d/ec2



EC2 AMI Setup Notes:
================
* Format EBS (yes, entire device): sudo mkfs -t ext3 /dev/sdc
* Mount EBS (create /ebs first): sudo mount -t ext3 /dev/sdc /ebs
* Creating image: http://www.capsunlock.net/2009/12/create-ebs-boot-ami.html


MOTD:

Image Customized to run Ruby On Rails Continuous Integration
Version 1.0.0pre
http://github.com/thewoolleyman/railsci