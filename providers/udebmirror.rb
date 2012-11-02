require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

action :mirror_now do

  package 'debmirror'

  cmd = "debmirror --host=#{nr.host} --method=#{nr.method} --dist=#{nr.dists} --root=#{nr.root} "
  cmd << "--arch=#{nr.arch} "
  cmd << '--nosource ' if not nr.source
  cmd << '-p ' if nr.progress
  cmd << '--rsync-extra=none ' if nr.norsync
  cmd << nr.target_dir

  directory nr.target_dir do
    recursive true
  end


  execute cmd

  nr.updated_by_last_action(true)
  
end

private
def nr
  @new_resource
end

