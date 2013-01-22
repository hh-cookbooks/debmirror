{
  'host' => 'archive.ubuntu.com',
  'method' => 'rsync',
  'dists' => 'precise',
  'arch' => 'amd64',
  'sections' => "main,main/debian-installer,universe,restricted,multiverse",
  # universe is 29G in precise!
  'target_dir' => '/share/ubuntu',
  'source' => nil
}.each do |k,v| 
  default['debmirror'][k]=v
end

default['debmirror']['root']='/srv/mirror'
