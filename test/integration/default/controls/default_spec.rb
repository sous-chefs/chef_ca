# frozen_string_literal: true

require_relative '../../spec_helper'

control 'chef_ca-default-01' do
  impact 1.0
  title 'The configured CA bundle is appended to the Chef cacert store'

  describe file(chef_cacert_path) do
    it { should exist }
    its('content') { should match(/Cert Bundle - test certificate/) }
    its('content') { should match(/MIIFFTCCAv2gAwIBAgIQNo9XwT6QsblLA\+3qdriHZTANBgkqhkiG9w0BAQsFADAd/) }
  end
end
