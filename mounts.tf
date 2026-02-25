/*
  These are mock mounts that populate
  the demo instance, used to showcase
  GatePlane WebUI.

  No access can be granted by using them.
*/

/* The "server -dev" deployments automatically turn on this Secrets Engine  */
# resource "vault_mount" "secret" {
#   path        = "secret"
#   description = "[GatePlane-Demo] KVv2 Secrets Storage"

#   type = "kv"
#   options = {
#     version = "2"
#     type    = "kv-v2"
#   }
# }


resource "vault_mount" "ssh" {
  path        = "ssh"
  description = "[GatePlane-Demo] SSH Access"

  type = "ssh"
}


resource "vault_kubernetes_secret_backend" "this" {
  path        = "kubernetes"
  description = "[GatePlane-Demo] Kubernetes Access"

  default_lease_ttl_seconds = 43200
  max_lease_ttl_seconds     = 86400
  kubernetes_host           = "https://127.0.0.1:61233"
  kubernetes_ca_cert        = ""
  disable_local_ca_jwt      = false
}


resource "vault_mount" "pki" {
  path        = "pki/ca"
  description = "[GatePlane-Demo] Certificate Authority"

  type                      = "pki"
  default_lease_ttl_seconds = 600
  max_lease_ttl_seconds     = 86400
}

resource "vault_pki_secret_backend_root_cert" "this" {
  depends_on   = [vault_mount.pki]
  backend      = vault_mount.pki.path
  type         = "internal"
  common_name  = "GatePlane Demo"
  organization = "GatePlaneDemo"
  # Set Verbatim End Date instead of 'ttl'
  # not_after            = "2027-01-23T18:46:42Z"
  not_after            = "2031-05-10T12:00:00Z"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
}


# CSP mounts
resource "vault_aws_secret_backend" "this" {
  path        = "aws"
  description = "[GatePlane-Demo] AWS Access"

  access_key = "AKIA....."
  secret_key = "<AWS_SECRET_KEY>"
}


resource "vault_gcp_secret_backend" "this" {
  path        = "gcp"
  description = "[GatePlane-Demo] GCP Access"

  identity_token_key      = "example-key"
  identity_token_ttl      = 1800
  identity_token_audience = "<TOKEN_AUDIENCE>"
  service_account_email   = "<SERVICE_ACCOUNT_EMAIL>"
}


resource "vault_azure_secret_backend" "this" {
  path        = "azure"
  description = "[GatePlane-Demo] Azure Access"

  subscription_id = "11111111-2222-3333-4444-111111111111"
  tenant_id       = "11111111-2222-3333-4444-222222222222"
  client_id       = "11111111-2222-3333-4444-333333333333"
}
