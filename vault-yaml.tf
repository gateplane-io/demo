
locals {
  accesses = yamldecode(
    # Change this filepath to the YAML file
    # containing a 'vault-yaml' schema
    file("./accesses.yaml")
  )
}

/* === Secrets Engines ===  */

module "ca" {
  source = "github.com/gateplane-io/vault-yaml.git//terraform/modules/secrets-engines/pki"

  mount = vault_mount.pki

  accesses  = local.accesses
  issuer_id = vault_pki_secret_backend_root_cert.this.issuer_id

  templated_common_names = {
    email = "{{identity.entity.aliases.${local.auth_methods["userpass"]["accessor"]}.name}}@example.gateplane.io"
  }
}


module "kubernetes" {
  source = "github.com/gateplane-io/vault-yaml.git//terraform/modules/secrets-engines/kubernetes"

  mount = vault_kubernetes_secret_backend.this

  role_directory = "./roles/kubernetes"
  accesses       = local.accesses
}


module "ssh" {
  source = "github.com/gateplane-io/vault-yaml.git//terraform/modules/secrets-engines/ssh"

  accesses = local.accesses

  mount = vault_mount.ssh

  allowed_users = "{{identity.entity.aliases.${local.auth_methods["userpass"]["accessor"]}.name}}"
  default_user  = "{{identity.entity.aliases.${local.auth_methods["userpass"]["accessor"]}.name}}"
}


locals {
  # == Definitions to be used when templating Vault Policies ==
  auth_methods = {
    (module.userpass.principal_key) : module.userpass.entry,
  }

  secrets_engines = {
    (module.ca.entry["path"])         = module.ca.entry,
    (module.kubernetes.entry["path"]) = module.kubernetes.entry,
    (module.ssh.entry["path"])        = module.ssh.entry,
  }
}


module "vault" {
  source = "github.com/gateplane-io/vault-yaml.git//terraform/modules/secrets-engines/vault"

  role_directory = "./roles/vault"
  accesses       = local.accesses

  # Maps used for templating Vault Policy documents under roles/vault
  auth_methods   = local.auth_methods
  secret_engines = local.secrets_engines
}

# Structured output to by used by the Auth Method modules
locals {
  policies_list = flatten([
    module.ca.access_list,
    module.kubernetes.access_list,
    module.ssh.access_list,
    module.vault.access_list,
    # ... <-- extend here for new Secrets Engine modules
  ])
}

module "userpass" {
  source = "github.com/gateplane-io/vault-yaml.git//terraform/modules/auth-methods/userpass"

  mount = module.userpass_tokens.mount

  policies_list = local.policies_list
  principal_key = "userpass"
}


locals {
  # Populates a mapping of principals
  # to attached created Vault Policies
  authorizations = [
    # module.identity.authorizations,
    module.userpass.authorizations,
  ]
}

output "authorizations" {
  value = local.authorizations
}
