# GatePlane Enterprise Demo

The configuration of the public **Demo GatePlane Enterprise** instance.

<img src="https://raw.githubusercontent.com/gateplane-io/gateplane-io.github.io/main/assets/logo-trans-light.svg#gh-dark-mode-only" alt="logo-darkmode" width="45%" align="right">
<img src="https://raw.githubusercontent.com/gateplane-io/gateplane-io.github.io/main/assets/logo-trans-dark.svg#gh-light-mode-only" alt="logo-lightmode" width="45%" align="right">

---

## 📖 Usage

This demo instance is designed to showcase the **GatePlane WebUI** in action:

- 🔗 **WebUI**: [`https://demo.app.gateplane.io`](https://demo.app.gateplane.io)
- 🔐 **Public Vault Instance**: [`https://vault.demo.gateplane.io`](https://vault.demo.gateplane.io)

### ⚙️ Configuration Details

The Gates are configured using the powerful [`vault-yaml`](https://github.com/gateplane-io/vault-yaml) Terraform modules. All access policies are defined in [`accesses.yaml`](https://github.com/gateplane-io/vault.demo.gateplane.io/blob/main//accesses.yaml).

---

## 👥 Demo Users

Explore the system with these pre-configured demo accounts. Access them through [`auth/userpass`](https://vault.demo.gateplane.io/ui/vault/auth?with=userpass):

| Username | Password | Access Level |
|----------|----------|--------------|
| `demo-0` | `passwd` | Approver |
| `demo-1` | `passwd` | Requestor |
| `demo-2` | `passwd` | Requestor |

> 💡 **Tip**: Try logging in with different users to see how RBAC policies control access!

---

## 🔔 Notifications

The *GatePlane Enterprise* instance is integrated with the public [`ntfy.sh`](https://ntfy.sh) notification service.

- **Live Notification Feed**: [`https://ntfy.sh/gateplane-demo`](https://ntfy.sh/gateplane-demo)

When you interact with the [Demo Instance](https://demo.app.gateplane.io), all events and notifications are pushed to this publicly accessible feed in real-time.

---

## 🛠️ Tech Stack

- **Vault** - Secure secrets storage
- **Terraform** - Infrastructure as Code
- **vault-yaml** - YAML-based Vault configuration
- **ntfy.sh** - Real-time notifications

---

## 📚 Resources

- 🌐 [GatePlane Website](https://gateplane.io)
- 🌐 [GatePlane WebUI](https://app.gateplane.io)
- 💻 [`vault-yaml` Repository](https://github.com/gateplane-io/vault-yaml)
- 🐛 [Report Issues](https://github.com/gateplane-io/demo/issues)

---

<div align="center">

**Made with ❤️ by the GatePlane Team**

[⬆ Back to Top](#-gateplane-enterprise-demo)

</div>
