#!/bin/bash

VAULT_POLICY="concourse-vault-policy.yml"
export VAULT_ADDR='http://127.0.0.1:8200'

vault secrets enable -version=1 -path=concourse kv

cat << 'EOF' > ${VAULT_POLICY}
path "concourse/*" {
  policy = "read"
}
EOF

vault policy write $VAULT_POLICY
vault token create --policy concourse --period 1h 
