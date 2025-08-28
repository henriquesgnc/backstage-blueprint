# terraform-${{ values.moduleName }}

${{ values.description }}

## Usage

```hcl
module "${{ values.moduleName }}" {
  source = "github.com/${{ values.githubOrg }}/terraform-${{ values.moduleName }}"

  name        = "my-resource"
  environment = "production"
  tags = {
    team = "platform"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
{% if values.provider == 'aws' %}
| terraform | >= 1.5.0 |
| aws | >= 5.0 |
{% elif values.provider == 'gcp' %}
| terraform | >= 1.5.0 |
| google | >= 5.0 |
{% elif values.provider == 'azure' %}
| terraform | >= 1.5.0 |
| azurerm | >= 4.0 |
{% endif %}

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| name | Resource name prefix | string | `${{ values.moduleName }}` |
| environment | Environment | string | `dev` |
| tags | Resource tags | map(string) | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| resource_name | Name of the created resource |
