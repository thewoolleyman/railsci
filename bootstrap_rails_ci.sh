#!/bin/bash

echo "Setting up Rails Continuous Integration server..."

source ~/.railsci
# gem install right_aws --no-ri --no-rdoc
./create_ec2_instance.rb