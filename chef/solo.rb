chef_dir ||= ENV["RAILSCI_CHEF_DIR"] || File.join(ENV["HOME"],'chef')
file_cache_path chef_dir
file_store_path chef_dir
log_level :info
Chef::Log::Formatter.show_time = false
cookbook_path [File.join(chef_dir,"railsci_chef_repo/cookbooks/opscode"),File.join(chef_dir,"railsci_chef_repo/site-cookbooks/railsci")]
