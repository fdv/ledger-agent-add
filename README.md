# Ledger Agent Add

(install https://www.xquartz.org/ to avoid Warning about DISPLAY var)

A wrapper using Ledger agent to:

* Generates a new SSH key for your user@host.
* Adds the new identity to the ~/.ssh/ledger.conf file
* Adds the new host to your ~/.ssh/config file
* Reloads the Ledger Agent with all your identities (in the current shell only)

Usage:

```
./ledger-agent-add user@host
```

Read more at [A Step by Step Guide to Securing your SSH Keys with the Ledger Nano S](https://thoughts.t37.net/a-step-by-step-guide-to-securing-your-ssh-keys-with-the-ledger-nano-s-92e58c64a005)
