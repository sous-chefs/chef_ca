# frozen_string_literal: true

bundle = <<~PEM.chomp
  -----BEGIN CERTIFICATE-----
  MIIFFTCCAv2gAwIBAgIQNo9XwT6QsblLA+3qdriHZTANBgkqhkiG9w0BAQsFADAd
  -----END CERTIFICATE-----
PEM

chef_ca 'test certificate' do
  ca_bundle bundle
end
