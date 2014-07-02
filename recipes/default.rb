nodes = []
nodes = search(:node, "name:* AND chef_environment:#{node[:admin][:chef_env]}")

if nodes.empty?
  Chef::Log.info('No nodes found')
  nodes << node
end

template File.join(node[:admin][:ssh_conf_dir], node[:admin][:ssh_conf_file]) do
  source "ssh_config.erb"
  mode 0600
  variables :nodes => nodes
end
