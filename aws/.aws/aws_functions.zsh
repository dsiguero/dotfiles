# This function sets the AWS_PROFILE environment variable interactively, using fzf. It skips the long-term profiles,
# as this is part of my setup using aws-mfa (https://github.com/broamski/aws-mfa)
function awsprof() {
  export AWS_PROFILE=$(awk '!/-long-term/' ~/.aws/credentials | awk -F '[][]' 'NF > 1 {print $2}' | fzf)
}