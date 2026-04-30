# chef_ca cookbook

`chef_ca` appends a PEM-encoded certificate bundle to the `cacert.pem` file used by an existing
Chef Infra Client, Chef Workstation omnibus install, or legacy ChefDK install.

This cookbook exposes a custom resource only. There are no cookbook recipes or attributes.

## Resource

### `chef_ca`

#### Actions

- `:set` appends the bundle when it isn't already present

#### Properties

- `type` selects the target install. Accepted values are `:chef`, `:chef_workstation`, and legacy `:chefdk`. Default: `:chef`
- `ca_bundle` is the PEM-encoded certificate bundle to append
- `cacert_path` overrides automatic path detection when you need a nonstandard target

#### Examples

```ruby
chef_ca 'internal-root-ca' do
  ca_bundle <<~PEM
    -----BEGIN CERTIFICATE-----
    ...
    -----END CERTIFICATE-----
  PEM
end
```

```ruby
chef_ca 'workstation-root-ca' do
  type :chef_workstation
  ca_bundle lazy { ::File.read('/etc/pki/ca-trust/source/anchors/internal.pem') }
end
```

Resource documentation lives in [`documentation/chef_ca_chef_ca.md`](documentation/chef_ca_chef_ca.md).
