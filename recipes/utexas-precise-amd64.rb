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
