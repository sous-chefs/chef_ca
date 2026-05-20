# frozen_string_literal: true

module ChefCA
  module Helpers
    def bundle_entry(name, bundle)
      <<~CERT.chomp
        Cert Bundle - #{name}
        ===========================
        #{bundle}
      CERT
    end

    def bundle_installed?(path, bundle)
      return false unless ::File.exist?(path)

      ::File.read(path).include?(bundle)
    end

    def cacert_path_for(type, platform_family:, cacert_path: nil)
      return cacert_path if cacert_path

      "#{cacert_root_for(type, platform_family: platform_family)}/embedded/ssl/certs/cacert.pem"
    end

    def cacert_root_for(type, platform_family:)
      prefix = platform_family == 'windows' ? 'C:/opscode' : '/opt'

      "#{prefix}/#{install_directory_name(type)}"
    end

    def install_directory_name(type)
      case type
      when :chef
        'chef'
      when :chef_workstation
        'chef-workstation'
      when :chefdk
        'chefdk'
      else
        raise ArgumentError, "Unsupported chef_ca type #{type.inspect}"
      end
    end
  end
end
