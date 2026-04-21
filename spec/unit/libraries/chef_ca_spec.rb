# frozen_string_literal: true

require 'spec_helper'
require 'tempfile'

RSpec.describe ChefCA::Helpers do
  subject(:helper_host) do
    Class.new do
      include ChefCA::Helpers
    end.new
  end

  let(:bundle) do
    <<~PEM.chomp
      -----BEGIN CERTIFICATE-----
      MIIFFTCCAv2gAwIBAgIQNo9XwT6QsblLA+3qdriHZTANBgkqhkiG9w0BAQsFADAd
      -----END CERTIFICATE-----
    PEM
  end

  describe '#cacert_path_for' do
    it 'computes the Chef Infra Client path on Linux' do
      expect(helper_host.cacert_path_for(:chef, platform_family: 'rhel')).to eq('/opt/chef/embedded/ssl/certs/cacert.pem')
    end

    it 'computes the Chef Workstation path on Windows' do
      expect(helper_host.cacert_path_for(:chef_workstation, platform_family: 'windows')).to eq('C:/opscode/chef-workstation/embedded/ssl/certs/cacert.pem')
    end

    it 'retains legacy ChefDK targeting' do
      expect(helper_host.cacert_path_for(:chefdk, platform_family: 'mac_os_x')).to eq('/opt/chefdk/embedded/ssl/certs/cacert.pem')
    end

    it 'uses an explicit cacert path override' do
      expect(helper_host.cacert_path_for(:chef, platform_family: 'ubuntu', cacert_path: '/tmp/cacert.pem')).to eq('/tmp/cacert.pem')
    end
  end

  describe '#bundle_installed?' do
    it 'returns false when the target file is missing' do
      expect(helper_host.bundle_installed?('/tmp/chef-ca-missing.pem', bundle)).to be(false)
    end

    it 'returns true when the bundle already exists' do
      file = Tempfile.new('cacert')
      file.write(bundle)
      file.close

      expect(helper_host.bundle_installed?(file.path, bundle)).to be(true)
    ensure
      file.unlink
    end
  end

  describe '#bundle_entry' do
    it 'formats the appended certificate block' do
      expect(helper_host.bundle_entry('internal-root-ca', bundle)).to eq(
        "Cert Bundle - internal-root-ca\n===========================\n#{bundle}"
      )
    end
  end
end
