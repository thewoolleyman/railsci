RAILS CI
========
http://github.com/thewoolleyman/railsci - Chad Woolley - thewoolleyman@gmail.com

Scripts to support Continuous Integration for the Ruby on Rails framework itself - [http://ci.rubyonrails.org](http://ci.rubyonrails.org):

* run\_rails\_ci\_instance: a script to run an standard Rails CI Instance on EC2
* create\_ami: a script to build an updated or customized Rails CI AMI Image on EC2.  Uses [AMIBUILDER](http://github.com/thewoolleyman/amibuilder) to build the AMI
* install\_rails\_ci: a script to build a Rails CI instance under Ubuntu on a local box or Virtual Machine

Issue Trackers:

* Scripts and docs: [http://github.com/thewoolleyman/railsci/issues](http://github.com/thewoolleyman/railsci/issues)
* Supporting Chef repo: [http://github.com/thewoolleyman/railsci_chef_repo/issues](http://github.com/thewoolleyman/railsci_chef_repo/issues)

Running the standard Rails CI instance on a new EC2 instance
============================================================
Run a Rails CI instance on your EC2 account:

    ./run_rails_ci_instance

Environment variables (~/.railscirc is automatically read):

    # RAILSCI_AMI:Optional. ID of Rails CI AMI to use
    RAILSCI_AMI='ami-0d729464'

Running the standard Rails CI instance on a Local Box or Virtual Machine
========================================================================
Install Ubuntu 10.04 Server on a clean local box or virtual machine.  You can use [VMWare Fusion or Workstation](http://www.vmware.com/products/) and
and the [Ubuntu Server](http://www.ubuntu.com/server) ISO image.

Log in or SSH to the new box, then wget and run the 'install\_rails\_ci' script.

    wget -O /tmp/install_rails_ci http://github.com/thewoolleyman/railsci/raw/master/install_rails_ci && chmod +x /tmp/install_rails_ci && /tmp/install_rails_ci
    # If you want to poke around, log out or source ~/.bashrc after the first build

To use custom settings, set any of the RAILSCI\_* variables directly before invoking the script, or 
in $RAILSCI_CONFIG (~/.railscirc)

Hacking
=======
Rails moves fast, and various aspects of this CI setup will become outdated periodically.  Other people will want to tweak the CI 
environment to their liking.  So, the scripts and process have been designed to make it easy to rebuild a new Rails CI AMI image 
or server from scratch.

Wherever possible, setup and configuration is performed via [Chef](http://www.opscode.com/chef/) using 
the [Rails CI Chef Repo](http://github.com/thewoolleyman/railsci_chef_repo).  This means you can update an existing
Rails CI environment without rebuilding it:

    cd ~/chef/railsci_chef_repo
    git pull # Or checkout from your own fork
    chef-solo -c ~/solo.rb -j ~/node.json

Environment Variables to cuistomize how the Rails CI server Will Be Built
=========================================================================
The following variables are supported by 'rails\_ci\_setup':

    # RAILSCI_RVM_RUBIES: Optional. Space-delimited list of RVM ruby interpreters to install.  Default: RAILSCI_RVM_RUBIES='1.8.7-p174 1.9.2'
    export RAILSCI_RVM_DEFAULT_RUBY='1.8.7-p174'
    # RAILSCI_CHEF_DIR: Optional.  Directory in which to store the Chef repo.  Default: RAILSCI_CHEF_DIR=$HOME/chef
    export RAILSCI_CHEF_DIR=$HOME/chef
    # RAILSCI_CHEF_SOLO_CONFIG_URL: Optional.  URL to solo.rb (-c option to chef-solo).  Default: RAILSCI_CHEF_SOLO_CONFIG_URL='http://github.com/thewoolleyman/railsci/raw/master/chef/solo.rb'
    export RAILSCI_CHEF_SOLO_CONFIG_URL='http://github.com/thewoolleyman/railsci/raw/master/chef/solo.rb'
    # RAILSCI_CHEF_SOLO_JSON_URL: Optional.  URL to node.json (-j option to chef-solo).  Default: RAILSCI_CHEF_SOLO_JSON_URL='http://github.com/thewoolleyman/railsci/raw/master/chef/node.json'
    export RAILSCI_CHEF_SOLO_JSON_URL='http://github.com/thewoolleyman/railsci/raw/master/chef/node.json'
    # RAILSCI_CHEF_REPO_URL: Optional. Git download URL to Rails CI custom chef repo.  Default: RAILSCI_CHEF_REPO_URL='git://github.com/thewoolleyman/railsci_chef_repo.git'    
    export RAILSCI_CHEF_REPO_URL='git://github.com/thewoolleyman/railsci_chef_repo.git'
    # RAILSCI_CHEF_GEM_INSTALL_OPTIONS: Optional. Options to pass to 'gem install chef'.  Useful if you want to install a custom or prerelease Chef gem, e.g. ''--version=x.y.z.a1 --source=http://my.gem.server --prerelease'  Default: RAILSCI_CHEF_REPO_URL=''    
    export RAILSCI_CHEF_GEM_INSTALL_OPTIONS=''

Creating an updated or customized Rails CI AMI
==============================================
Create an updated/customized EBS boot AMI for Rails CI instance:

    ./create_ami

This will automatically download the and run the amibuilder script, which will spin up an EC2 instance, 
which will be used to create an AMI image.

Operation of create\_ami and  ami\_builder is controlled by environment variables.  The following 
environment variables are used directly by create_ami.  You can set them yourself, or paste this into ~/.railscirc and 
they will be read automatically (replace with your proper values).

    # AMIBUILDER_URL: Optional. URL of AMIBuilder release to be run
    export AMIBUILDER_URL='http://github.com/thewoolleyman/amibuilder/raw/master/amibuilder' 
    # AMIBUILDER_CUSTOM_SETUP_URL: Optional. URL of script containing Rails CI custom AMI setup which AMIBuilder will run automatically.
    export AMIBUILDER_CUSTOM_SETUP_URL='http://github.com/thewoolleyman/railsci/raw/master/script/rails_ci_setup'
    # AMIBUILDER_CUSTOM_SETUP_VARS: Optional. Variables which AMIBUILDER will set in the remote chroot AMI image before it runs AMIBUILDER_CUSTOM_SETUP_URL.  More info below.
    export AMIBUILDER_CUSTOM_SETUP_VARS="RAILSCI_RVM_RUBIES='1.8.7-p174 1.9.2-head' RAILSCI_RVM_DEFAULT_RUBY='1.8.7-p174'"
    # RAILSCI_AMIBUILDER_VARS: Optional.  Variables which create_ami will set before it runs the amibuilder script downloaded from AMIBUILDER_URL.  Executed locally, so you could do this: RAILSCI_AMIBUILDER_VARS="AMIBUILDER_CONFIG=~/.amibuilderrc_debug" 
    export RAILSCI_AMIBUILDER_VARS=""

You can also specify multiple 'remote' environment variables in the 'AMIBUILDER\_CUSTOM\_SETUP\_VARS' variable.  This is 
because AMIBUILDER remotely downloads and runs the script from 'AMIBUILDER\_CUSTOM\_SETUP\_URL', which points 
to 'rails\_ci\_setup' by default.  Any of the 'RAILSCI\_*' variables can be used.

Environment Variables for Developers and Debugging
==================================================

The 'rails\_ci\_setup' script itself should rarely need to be changed, unless it is being ported to a new platform, distro, 
or release.  This section will help you when it necessary.

The following environment variable flags are useful for debugging failing steps of the CI server build without performing a full run each time.  For EC2 AMI builds, these 
are also passed in 'AMIBUILDER\_CUSTOM\_SETUP\_VARS'.  Also see the supported [AMIBUILDER debugging flags](http://github.com/thewoolleyman/amibuilder)

    # RAILSCI_NO_INSTALL_PACKAGES: if set, skip step to install packages.  Default: RAILSCI_NO_INSTALL_PACKAGES=false
    export RAILSCI_NO_INSTALL_PACKAGES=false
    # RAILSCI_NO_SETUP_RVM: if set, skip step to install RVM.  Default: RAILSCI_NO_SETUP_RVM=false
    export RAILSCI_NO_SETUP_RVM=false
    # RAILSCI_NO_INSTALL_CHEF: if set, skip step to install CHEF.  Default: RAILSCI_NO_INSTALL_CHEF=false
    export RAILSCI_NO_INSTALL_CHEF=false
    # RAILSCI_NO_DOWNLOAD_CHEF_CONFIG: if set, skip step to download custom chef configs and repos.  Default: RAILSCI_NO_DOWNLOAD_CHEF_CONFIG=false
    export RAILSCI_NO_DOWNLOAD_CHEF_CONFIG=false
    # RAILSCI_NO_RUN_CHEF: if set, skip step to run CHEF.  Default: RAILSCI_NO_RUN_CHEF=false
    export RAILSCI_NO_RUN_CHEF=false

You can hack the 'rails\_ci\_setup' script directly on the virtual machine.  Just make sure you use git to 
switch ~/chef/railsci\_chef\_repo to a local checkout your remote fork of [railsci\_chef\_repo](http://github.com/thewoolleyman/railsci_chef_repo), so you can
check in your changes and [open issues](http://github.com/thewoolleyman/railsci_chef_repo/issues) or 
send pull requests for your improvements and fixes.

You could also download the scripts from your local machine if you want to debug or hack them using your favorite editor
locally (But this is slow and you are better off learning use vi and git from the machine itself).  For example, here's how you 
could serve them from a local rails instance:

    # From host development machine
    cd
    git clone http://github.com/thewoolleyman/railsci.git
    rails webserver
    cd webserver
    ln -s ~/railsci/install_rails_ci public/install_rails_ci
    ln -s ~/railsci/script/rails_ci_setup public/rails_ci_setup
    script/server
    
    # From remote Rails CI virtual machine, box, or EC2 instance
    export RAILSCI_SETUP_URL='http://<host ip>:3000/webserver/rails_ci_setup' && wget -O /tmp/install_rails_ci && chmod +x /tmp/install_rails_ci && /tmp/install_rails_ci

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
