#
# Cookbook Name:: debmirror
# Recipe:: default
#
# Copyright 2012, Chris McClimans
#


debmirror '/share/ubuntu-amd64' do
  host 'ftp.utexas.edu'
  method 'rsync'
  dists 'precise'
  arch 'amd64'
  source false
  progress true
end

include_recipe 'apache2'

apache2_web_app "local_ubuntu_mirror" do
  server_name node['hostname']
  server_aliases [node['fqdn'], "localhost"]
  docroot "/share/ubuntu-amd64"
end
