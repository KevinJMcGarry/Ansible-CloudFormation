PATH=$PATH:/home/ansible/.local/bin
AWS_ACCESS_KEY_ID="$(aws ssm get-parameters --names "AnsibleAccessKeyID" --with-decryption --region=us-west-2 | jq '.Parameters[0].Value' | sed -e 's/^"//' -e 's/"$//')"
AWS_SECRET_ACCESS_KEY="$(aws ssm get-parameters --names "AnsibleSecretAccessKey" --with-decryption --region=us-west-2 | jq '.Parameters[0].Value' | sed -e 's/^"//' -e 's/"$//')"
export AWS_ACCESS_KEY_ID && export AWS_SECRET_ACCESS_KEY