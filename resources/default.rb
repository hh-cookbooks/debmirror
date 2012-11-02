actions :mirror_now #, :schedule_via_cron?

attribute :target_dir, :name_attribute => true
attribute :host, :kind_of => String, :default => 'archive.ubuntu.com'
attribute :method, :kind_of => String, :equal_to => ['rsync', 'http']
attribute :dists, :kind_of => String, :default => 'precise'
attribute :arch, :kind_of => String, :default => 'amd64'
attribute :sections, :kind_of => String, :default => 'main,main/debian-installer,universe,restricted,multiverse'
attribute :source, :kind_of => [TrueClass, FalseClass], :default => false
attribute :progress, :kind_of => [TrueClass, FalseClass], :default => false
attribute :norsync, :kind_of => [TrueClass, FalseClass], :default => false
attribute :root, :kind_of => String, :default => 'ubuntu'

def initialize(name, run_context=nil)
  super
  set_platform_default_providers
  @action = :mirror_now
end

private
def set_platform_default_providers
  Chef::Platform.set(
    :platform => :ubuntu,
    :resource => :debmirror,
    :provider => Chef::Provider::DebmirrorUdebmirror
  )
end

#attribute :arch, :kind_of => Array, :default => ['amd64','i386']
#attribute :sections, :kind_of => Array, :default => ['main','main/debian-installer','universe','restricted','multiverse']
