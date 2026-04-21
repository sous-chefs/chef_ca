# Testing

Run lint and unit tests with:

```text
cookstyle
chef exec rspec --format documentation
```

Run the default integration suite with Dokken:

```text
KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen test default-ubuntu-2204 --destroy=always
```
