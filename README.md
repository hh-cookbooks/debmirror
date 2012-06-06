Description
===========

Installes debmirror package and provides the debmirror lwrp.

Requirements
============

Tested on Ubuntu 12.04, but it would be desireable to get this on more platforms.
Debmirror basically one big perl script with a few dependencies.

Attributes
==========

attribute :target_dir, :name_attribute => true
attribute :host, :kind_of => String, :default => 'archive.ubuntu.com'
attribute :method, :kind_of => String, :equal_to => ['rsync']
attribute :dists, :kind_of => String, :default => 'precise'
attribute :arch, :kind_of => String, :default => 'amd64'
attribute :sections, :kind_of => String, :default => 'main,main/debian-installer,universe,restricted,multiverse'
attribute :source, :kind_of => Bool, :default => false

# defaults documented in:
/usr/share/doc/debmirror/examples/debmirror.conf 

$host="archive.ubuntu.com";
@dists="oneiric";
@sections="main,main/debian-installer,universe,restricted,multiverse";
$do_source=1;

# -p for progress
/usr/bin/debmirror is a perl script, so the definitive source is there

Usage
=====

debmirror '/shared/ubuntu-amd64' do
  host 'ftp.utexas.edu'
  method 'rsync'
  dist 'precise'
  arch 'amd64'
  source false
end
