# chef_ca_chef_ca

Appends a PEM certificate bundle to the `cacert.pem` trust store used by an existing Chef install.

## Actions

| Action | Description                                                |
|--------|------------------------------------------------------------|
| `:set` | Appends the bundle when it isn't already present (default) |

## Properties

| Property      | Type   | Default       | Description                                                            |
|---------------|--------|---------------|------------------------------------------------------------------------|
| `type`        | Symbol | `:chef`       | Target install type: `:chef`, `:chef_workstation`, or legacy `:chefdk` |
| `ca_bundle`   | String | none          | PEM-encoded certificate bundle to append                               |
| `cacert_path` | String | auto-detected | Explicit path override for the target `cacert.pem`                     |

## Examples

### Append to Chef Infra Client

```ruby
chef_ca 'internal-root-ca' do
  ca_bundle <<~PEM
    -----BEGIN CERTIFICATE-----
    ...
    -----END CERTIFICATE-----
  PEM
end
```

### Append to Chef Workstation

```ruby
chef_ca 'workstation-root-ca' do
  type :chef_workstation
  ca_bundle ::File.read('/etc/pki/ca-trust/source/anchors/workstation.pem')
end
```

### Use a custom target path

```ruby
chef_ca 'test certificate' do
  ca_bundle ::File.read('/tmp/test.pem')
  cacert_path '/tmp/cacert.pem'
end
```
