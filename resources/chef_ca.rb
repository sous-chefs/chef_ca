# frozen_string_literal: true

provides :chef_ca
unified_mode true

default_action :set

property :type, Symbol, equal_to: %i(chef chef_workstation chefdk), default: :chef
property :ca_bundle, String, required: true
property :cacert_path, String

action_class do
  include ChefCA::Helpers
end

action :set do
  resolved_cacert_path = cacert_path_for(
    new_resource.type,
    platform_family: node['platform_family'],
    cacert_path: new_resource.cacert_path
  )

  ruby_block "add certificate bundle #{new_resource.name} to #{resolved_cacert_path}" do
    block do
      ::File.open(resolved_cacert_path, 'a') do |file|
        file.puts bundle_entry(new_resource.name, new_resource.ca_bundle)
      end
    end
    not_if { bundle_installed?(resolved_cacert_path, new_resource.ca_bundle) }
  end
end
