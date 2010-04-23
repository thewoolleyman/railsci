RAILS CI
========
http://github.com/thewoolleyman/railsci - Chad Woolley - thewoolleyman@gmail.com
Continuous Integration for the Ruby on Rails framework itself - http://ci.rubyonrails.org.  Contains a script to run an standard Rails CI Instance on EC2, and another script to build an updated or customized Rails CI AMI Image on EC2.  Uses AMIBUILDER - http://github.com/thewoolleyman/amibuilder - to build the AMI

Running the standard Rails CI instance
======================================
Run a Rails CI instance:

    ./run_rails_ci_instance

Environment variables (~/.railscirc is automatically read):

    # RAILSCI_AMI:Optional. ID of Rails CI AMI to use
    RAILSCI_AMI='ami-0d729464'

Creating an updated or customized Rails CI AMI
==============================================
Create an updated/customized EBS boot AMI for Rails CI instance:

    ./create_ami

Local environment variables.  You can set them yourself, or paste this into ~/.amibuilderrc and they will be read automatically (replace with your proper values).

    # RAILSCI_CONFIG: Optional. Path to RAILSCI config.
    export RAILSCI_CONFIG=~/.railscirc
    # AMIBUILDER_URL: Optional. URL of AMIBuilder release to be run
    export AMIBUILDER_URL='http://github.com/thewoolleyman/amibuilder/raw/master/amibuilder' 
    # AMIBUILDER_CUSTOM_SETUP_URL: Optional. URL of script containing Rails CI custom AMI setup which AMIBuilder will run automatically.
    export AMIBUILDER_CUSTOM_SETUP_URL='http://github.com/thewoolleyman/railsci/raw/master/script/rails_ci_setup'
    # AMIBUILDER_CUSTOM_SETUP_VARS: Optional. Variables which AMIBUILDER will set before it runs AMIBUILDER_CUSTOM_SETUP_URL.  More info below.
    export AMIBUILDER_CUSTOM_SETUP_VARS="RAILSCI_RVM_RUBIES='1.8.7-p174 1.9.2-head' RAILSCI_RVM_DEFAULT_RUBY='1.8.7-p174'"
    # RAILSCI_AMIBUILDER_VARS: Optional.  Variables which create_ami will set before it runs the amibuilder script downloaded from AMIBUILDER_URL.  Executed locally, so you could do this: RAILSCI_AMIBUILDER_VARS="AMIBUILDER_CONFIG=~/.amibuilderrc_debug" 
    export RAILSCI_AMIBUILDER_VARS=""

You can also specify multiple 'remote' environment variables in the 'AMIBUILDER\_CUSTOM\_SETUP\_VARS' variable.  This is because AMIBUILDER remotely downloads and runs the script from 'AMIBUILDER\_CUSTOM\_SETUP\_URL', which points to 'rails\_ci\_setup' by default.  The following variables are supported by 'rails\_ci\_setup':

    RAILSCI_RVM_RUBIES: Optional. Space-delimited list of RVM ruby interpreters to install.  Default: RAILSCI_RVM_RUBIES='1.8.7-p174 1.9.2'
    RAILSCI_RVM_DEFAULT_RUBY: Optional.  Ruby interpreter to set as default.  Default: RAILSCI_RVM_DEFAULT_RUBY='1.8.7-p174'
    RAILSCI_CHEF_SOLO_CONFIG_URL: Optional.  URL to solo.rb (-c option to chef-solo).  Default: RAILSCI_CHEF_SOLO_CONFIG_URL='http://github.com/thewoolleyman/railsci/raw/master/chef/solo.rb'
    RAILSCI_CHEF_SOLO_JSON_URL: Optional.  URL to node.json (-j option to chef-solo).  Default: RAILSCI_CHEF_SOLO_JSON_URL='http://github.com/thewoolleyman/railsci/raw/master/chef/node.json'
    RAILSCI_CHEF_REPO_URL: Optional. URL to Rails CI custom chef repo.  Default: RAILSCI_CHEF_REPO_URL'http://github.com/thewoolleyman/railsci_chef_repo/tarball/master'    
    
Developers and Debugging
========================
The following environment variable flags are useful for debugging failing steps of the build without performing a full run each time.  These are also passed in 'AMIBUILDER\_CUSTOM\_SETUP\_VARS'.  Also see the supported AMIBUILDER debugging flags at http://github.com/thewoolleyman/amibuilder

    RAILSCI_NO_INSTALL_PACKAGES: if set, skip step to install packages.  Default: RAILSCI_NO_INSTALL_PACKAGES=false
    RAILSCI_NO_SETUP_RVM: if set, skip step to install RVM.  Default: RAILSCI_NO_SETUP_RVM=false
    RAILSCI_NO_INSTALL_CHEF: if set, skip step to install CHEF.  Default: RAILSCI_NO_INSTALL_CHEF=false
    RAILSCI_NO_RUN_CHEF: if set, skip step to run CHEF.  Default: RAILSCI_NO_RUN_CHEF=false

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