# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'chef_ca' do
  step_into :chef_ca

  context 'on Ubuntu' do
    platform 'ubuntu', '22.04'

    recipe do
      bundle = <<~PEM.chomp
        -----BEGIN CERTIFICATE-----
        MIIFFTCCAv2gAwIBAgIQNo9XwT6QsblLA+3qdriHZTANBgkqhkiG9w0BAQsFADAd
        -----END CERTIFICATE-----
      PEM

      chef_ca 'test certificate' do
        ca_bundle bundle
      end
    end

    it 'appends to the default Chef Infra Client cacert path' do
      expect(chef_run).to run_ruby_block('add certificate bundle test certificate to /opt/chef/embedded/ssl/certs/cacert.pem')
    end
  end

  context 'with a custom target path' do
    platform 'ubuntu', '22.04'

    recipe do
      bundle = <<~PEM.chomp
        -----BEGIN CERTIFICATE-----
        MIIFFTCCAv2gAwIBAgIQNo9XwT6QsblLA+3qdriHZTANBgkqhkiG9w0BAQsFADAd
        -----END CERTIFICATE-----
      PEM

      chef_ca 'test certificate' do
        ca_bundle bundle
        cacert_path '/tmp/cacert.pem'
      end
    end

    it 'uses the explicit path override' do
      expect(chef_run).to run_ruby_block('add certificate bundle test certificate to /tmp/cacert.pem')
    end
  end

  context 'on Windows targeting Chef Workstation' do
    platform 'windows', '2019'

    recipe do
      bundle = <<~PEM.chomp
        -----BEGIN CERTIFICATE-----
        MIIFFTCCAv2gAwIBAgIQNo9XwT6QsblLA+3qdriHZTANBgkqhkiG9w0BAQsFADAd
        -----END CERTIFICATE-----
      PEM

      chef_ca 'test certificate' do
        type :chef_workstation
        ca_bundle bundle
      end
    end

    it 'computes the Chef Workstation cacert path' do
      expect(chef_run).to run_ruby_block('add certificate bundle test certificate to C:/opscode/chef-workstation/embedded/ssl/certs/cacert.pem')
    end
  end
end
