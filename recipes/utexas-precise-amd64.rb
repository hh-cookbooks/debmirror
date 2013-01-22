#
# Cookbook Name:: debmirror
# Recipe:: utexas-precise-amd64
#
# Copyright 2012, Chris McClimans
#


root=node['debmirror']['root']

include_recipe 'apache2'

directory '/root/.gnupg' do
  mode 0700
end

web_app "local_ubuntu_mirror" do
  server_name node['ipaddress'] #node['hostname']
  server_aliases [node['fqdn'], "localhost"]
  docroot "#{root}"
  template 'local_ubuntu_mirror.conf.erb'
end

# might be interesting to wrap this in an lwrp of some sort
execute "gpg --keyring /usr/share/keyrings/ubuntu-archive-keyring.gpg --export |\
         gpg --no-default-keyring --keyring trustedkeys.gpg --import" do
  not_if "gpg --no-default-keyring --keyring trustedkeys.gpg --list-keys 79164387"
end

# install/bootstrap may not need i386 really... just make an empty Release file?
debmirror "#{root}/ubuntu" do
  host 'ftp.utexas.edu'
  method 'rsync'
  dists 'precise,precise-updates' #,lucid,lucid-updates'
  arch 'amd64' #,i386'
  source false
  progress true
  retries 10000
end

debmirror "#{root}/ubuntu-security" do
  host 'ftp.utexas.edu'
  method 'rsync'
  dists 'precise-security' # ,lucid-security'
  arch 'amd64' #,i386'
  source false
  progress true
  retries 10000
end

debmirror "#{root}/opscode" do
  host 'apt.opscode.com'
  root '/'
  method 'http'
  dists 'precise-0.10' #,lucid-0.10'
  arch 'amd64,i386'
  source false
  progress true
  norsync true
  retries 10000
end

#css and such
debmirror "#{root}/medibuntu" do
  host 'packages.medibuntu.org'
  root '/medibuntu'
  method 'rsync'
  dists 'precise,lucid'
  arch 'amd64' #,i386'
  source false
  progress true
  retries 10000
end

directory "#{root}/chef"

remote_file "#{root}/chef/chef-full_0.10.10-1_amd64.deb" do
  source 'http://s3.amazonaws.com/opscode-full-stack/ubuntu-11.04-x86_64/chef-full_0.10.10-1_amd64.deb'
  not_if {::File.exists? "#{root}/chef/chef-full_0.10.10-1_amd64.deb" }
end
