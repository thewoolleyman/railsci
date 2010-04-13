RAILS CI
========
Continuous Integration for the Ruby on Rails framework.

Running the standard Rails CI instance
======================================
Run a Rails CI instance:

    ./run_rails_ci_instance

Environment variables (~/.railscirc is automatically read):

    # RAILSCI_AMI:Optional. ID of Rails CI AMI to use
    RAILSCI_AMI='ami-0d729464'

Creating a new or customized Rails CI AMI
=========================================
Create an updated/customized EBS boot AMI for Rails CI instance:

    ./create_ami

Environment variables (~/.railscirc is automatically read):

    # AMIBUILDER_URL: Optional. URL of AMIBuilder release to be run
    AMIBUILDER_URL='http://github.com/thewoolleyman/amibuilder/raw/master/amibuilder' 
    # AMIBUILDER_CUSTOM_SETUP_URL: Optional. URL of script containing Rails CI custom AMI setup which AMIBuilder will run automatically.
    AMIBUILDER_CUSTOM_SETUP_URL='http://github.com/thewoolleyman/railsci/raw/master/script/rails_ci_setup' 
    # RVM_RUBIES: Optional. Space-delimited list of RVM rubies to install.
    RVM_RUBIES='1.8.6 1.8.7 1.9.2'

