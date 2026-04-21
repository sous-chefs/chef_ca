# frozen_string_literal: true

def chef_cacert_path
  os.windows? ? 'C:/opscode/chef/embedded/ssl/certs/cacert.pem' : '/opt/chef/embedded/ssl/certs/cacert.pem'
end
