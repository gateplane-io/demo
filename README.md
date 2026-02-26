# GatePlane Enterprise Demo

The configuration of the public Demo GatePlane Enterprise instance.

---

## Usage

This instance is created to showcase the WebUI under [`https://demo.app.gateplane.io`](https://demo.app.gateplane.io),
which uses the public Vault instance under [`https://vault.demo.gateplane.io`](https://vault.demo.gateplane.io)

Additionally, the Gates are configured through RBAC using [`vault-yaml`](https://github.com/gateplane-io/vault-yaml)
Terraform modules, and are defined under [`accesses.yaml`](https://github.com/gateplane-io/vault.demo.gateplane.io/blob/main//accesses.yaml)

## Users

This instance contains the following users, accessible through [`auth/userpass`](https://vault.demo.gateplane.io/ui/vault/auth?with=userpass):

Username: `demo-{0,1,2}`

Password: `passwd`

## Notifications

The *GatePlane Enterprise* instance is set up to work with the public [`ntfy.sh`](https://ntfy.sh) instance.

Using the [Demo Instance](https://demo.app.gateplane.io) will send notifications to the publicly accessible [`https://ntfy.sh/gateplane-demo`](https://ntfy.sh/gateplane-demo) feed.
