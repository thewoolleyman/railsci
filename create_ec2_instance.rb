#!/usr/bin/env ruby

require 'right_aws'

class CreateEc2Instance
  def run
    ec2 = create_ec2
    instances_data = ec2.run_instances('ami-0d729464', 1, 1, ['default'], @aws_ssh_key_name, '', 'public')
    puts "EC2 instance starting.  Hit enter when it is started..."
    gets
    instance_data = instances_data.first
  end
  
  def load_credentials
    raise "set AWS_ACCESS_KEY_ID" unless @aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
    raise "set AWS_SECRET_ACCESS_KEY" unless @aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    raise "set AWS_SSH_KEY_NAME" unless @aws_ssh_key_name = ENV['AWS_SSH_KEY_NAME']
  end
  
  def create_ec2
    load_credentials
    @ec2 = RightAws::Ec2.new(@aws_access_key_id, @aws_secret_access_key)
  end
end

# = RightAWS::EC2 -- RightScale Amazon EC2 interface
# The RightAws::EC2 class provides a complete interface to Amazon's
# Elastic Compute Cloud service, as well as the associated EBS (Elastic Block
# Store).
# For explanations of the semantics
# of each call, please refer to Amazon's documentation at
# http://developer.amazonwebservices.com/connect/kbcategory.jspa?categoryID=87
#
# Examples:
#
# Create an EC2 interface handle:
#
#   @ec2   = RightAws::Ec2.new(aws_access_key_id,
#                               aws_secret_access_key)
# Create a new SSH key pair:
#  @key   = 'right_ec2_awesome_test_key'
#  new_key = @ec2.create_key_pair(@key)
#  keys = @ec2.describe_key_pairs
#
# Create a security group:
#  @group = 'right_ec2_awesome_test_security_group'
#  @ec2.create_security_group(@group,'My awesome test group')
#  group = @ec2.describe_security_groups([@group])[0]
#
# Configure a security group:
#  @ec2.authorize_security_group_named_ingress(@group, account_number, 'default')
#  @ec2.authorize_security_group_IP_ingress(@group, 80,80,'udp','192.168.1.0/8')
#
# Describe the available images:
#  images = @ec2.describe_images
#
# Launch an instance:
#  ec2.run_instances('ami-9a9e7bf3', 1, 1, ['default'], @key, 'SomeImportantUserData', 'public')
#
#
# Describe running instances:
#  @ec2.describe_instances
#
# Error handling: all operations raise an RightAws::AwsError in case
# of problems. Note that transient errors are automatically retried.
