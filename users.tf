
# Creates 'demo-{0,1,2...}' users under
# the /userpass auth method
module "userpass_tokens" {
  source = "github.com/gateplane-io/terraform-test-modules.git//tokens?ref=1.1.0"

  # Used to make the HTTP calls to create tokens
  vault_api_url = "${var.vault_addr}/v1"

  entity_groups = {
    "demo" = {
      "quantity" = 3
      "policies" = [
        module.setup.ui_policy,
      ],
    },
  }
}
