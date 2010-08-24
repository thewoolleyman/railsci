RAILS CI
========
http://github.com/thewoolleyman/railsci - Chad Woolley - thewoolleyman@gmail.com

Scripts to support Continuous Integration for the Ruby on Rails framework itself - [http://ci.rubyonrails.org](http://ci.rubyonrails.org):

* railsci\_run\_ec2\_instance: Runs an EC2 instance from the latest official Rails CI AMI. (TODO: link)
* railsci\_build\_ami: Builds an updated or customized Rails CI AMI image on EC2.  Uses [boxbuilder](http://github.com/thewoolleyman/boxbuilder) to build the AMI
* railsci\_build: Builds a Rails CI instance on a local box or Virtual Machine

Issue Trackers:

* Scripts and docs: [http://github.com/thewoolleyman/railsci/issues](http://github.com/thewoolleyman/railsci/issues)
* Supporting Chef repo: [http://github.com/thewoolleyman/railsci_chef_repo/issues](http://github.com/thewoolleyman/railsci_chef_repo/issues)

**WARNING! RAILSCI INCURS EC2 RESOURCE CHARGES!
The 'railsci\_build\_ami' and 'railsci\_run\_ec2\_instance' scripts will run boxbuilder to automatically create EC2 instances, EBS volumes and EBS snapshots.
Boxbuilder will ATTEMPT TO automatically terminate any EC2 instance it has automatically started,
but if the scripts fail or are killed the might not be removed.
It is YOUR RESPONSIBILITY to confirm that any EC2 resources which boxbuilder creates are
terminated even if boxbuilder fails to terminate them automatically.
If you do not YOU WILL BE CHARGED BY AMAZON FOR ANY RESOURCES UNTIL THEY ARE TERMINATED.
Learn how to delete any unused resources via the the EC2 AWS Management Console
before using the 'build\_ami' scripts: [https://console.aws.amazon.com/ec2/home](https://console.aws.amazon.com/ec2/home) .
Resources which boxbuilder automatically starts will be identified by the string
'boxbuilder\_temp\_builder\_instance\_safe\_to\_terminate' in the resource's
User Data instance attribute or Snapshot Description.
The User Data instance attribute is not visible via the EC2 AWS Management Console,
but can be seen using this command:
'ec2-describe-instance-attribute {instance id} --user-data'.**

Goals
=====

* To create a standardized, modern, and full-featured Continuous Integration build environment for the Ruby on Rails framework.
* To support running the Rails CI build under multiple ruby interpreters.
* To make it very easy for anyone to quickly start up their own dedicated Rails CI server from the same EC2 AMI
  used for the official Rails CI environment.
* To make it very easy for anyone to quickly install their own dedicated Rails CI server on a local box or Virtual Machine,
  which should be as identical as possible to the EC2 AMI (because they are both built with the same scripts and chef cookbooks)
* To make it easy to recreate updated versions of the official AMI image as the Rails ecosystem evolves.
* To make it easy to hack on and improve the scripts and chef repository which are used to build the AMIs/servers.

Running the standard Rails CI instance on a new EC2 instance
============================================================
Run a Rails CI instance on your EC2 account:

    ./railsci_run_ec2_instance

Environment variables (~/.railscirc is automatically read):

    # RAILSCI_AMI: Optional. ID of Rails CI AMI to use
    RAILSCI_AMI='ami-0d729464'

Running the standard Rails CI instance on a Local Box or Virtual Machine
========================================================================
Install Ubuntu 10.04 Server on a clean local box or virtual machine.  You can use [VMWare Fusion or Workstation](http://www.vmware.com/products/) and
and the [Ubuntu Server](http://www.ubuntu.com/server) ISO image.

Log in or SSH to the new box, then wget and run the 'install\_rails\_ci' script.

    wget -O /tmp/railsci_build http://github.com/thewoolleyman/railsci/raw/master/railsci_build && chmod +x /tmp/railsci_build && /tmp/railsci_build
    # If you want to poke around, log out or source ~/.bashrc after the first build

Customizing a Rails CI instance
===============================

To use custom settings, set any of the railsci\_* variables directly, in a downloadable config 
specified at boxbuilder\_url, in $HOME/.boxbuilderrc, or in boxbuilder_config.  See the boxbuilder project
for more details on configuration options.

Hacking
=======
Rails moves fast, and various aspects of this CI setup will become outdated periodically as Rails moves forward, and
package/gem upgrades cause breakages.  Other people will want to tweak the CI environment to their liking.  So, 
the scripts and process have been designed to make it easy to rebuild and test a new Rails CI AMI image 
or server from scratch.

Setup and configuration is performed via [chef-solo](http://www.opscode.com/chef/) using 
the [Rails CI Chef Repo](http://github.com/thewoolleyman/railsci_chef_repo).  Chef is bootstrapped onto
boxes or AMI images with boxbuilder.  This allows you to automatically update an existing Rails CI
environment without rebuilding it or starting a new instance from a newer AMI:

    cd ~/chef/railsci_chef_repo
    git pull && git submodule update # Or checkout from your own fork
    rvmsudo chef-solo -c ~/chef/railsci_chef_repo/config/solo.rb -j ~/chef/railsci_chef_repo/config/node.json

You can also use git to switch ~/.chef/railsci\_chef\_repo to a local checkout of your remote 
fork of [railsci\_chef\_repo](http://github.com/thewoolleyman/railsci_chef_repo), or override
override boxbuilder\_chef\_repos when you are originally running the setup script.  This will allow you to
hack the Chef cookbooks in-place, and commit/push any improvements or fixes directly from the machine.

Please [open issues](http://github.com/thewoolleyman/railsci_chef_repo/issues) or send pull requests for
your improvements.

Environment Variables to customize how the Rails CI server Will Be Built
=========================================================================
The following variables are supported by 'rails\_ci\_setup':

    # railsci_rvm_rubies: Optional. Space-delimited list of RVM ruby interpreters to install.  Default: railsci_rvm_rubies='1.8.7-p174 1.9.2'
    export railsci_rvm_default_ruby='1.8.7-p174'
    # railsci_chef_repo_url: Optional. Git repo URL to Rails CI custom chef repo.  Default: railsci_chef_repo_url='git://github.com/thewoolleyman/railsci_chef_repo.git'    
    export railsci_chef_repo_url='git://github.com/thewoolleyman/railsci_chef_repo.git'
    # railsci_chef_gem_install_options: Optional. Options to pass to 'gem install chef'.  Useful if you want to install a custom or prerelease Chef gem, e.g. ''--version=x.y.z.a1 --source=http://my.gem.server --prerelease'  Default: railsci_chef_repo_url=''    
    export railsci_chef_gem_install_options=''

Creating an updated or customized Rails CI AMI
==============================================
**WARNING: It is YOUR RESPONSIBILITY to ensure that any EC2 resources which railsci and boxbuilder creates are
automatically shut down.  If you do not YOU WILL BE CHARGED BY AMAZON UNTIL THEY ARE SHUT DOWN.  See
the detailed warning at the top of this README.**

Create an updated/customized EBS boot AMI for Rails CI instance:

    ./railsci_build_ami

This will automatically download the and run the boxbuilder\_remote\_build\_ami script, which will run an EC2 instance, 
which will be used to create an AMI image.

Any of the 'railsci\_*' variables can be passed on via boxbuilder to customize how the AMI is built.  See the
'Customizing a Rails CI instance' section above for details..

License
=======
    (The MIT License)

    Copyright (c) 2010 Chad Woolley

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
    documentation files (the 'Software'), to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
    to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of
    the Software.

    THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
    THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
    CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
