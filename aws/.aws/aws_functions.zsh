#!/usr/bin/env bash

# This function sets the AWS_PROFILE environment variable interactively, using fzf.
# It skips the long-term profiles, as this is part of my setup using aws-mfa
# (https://github.com/broamski/aws-mfa)
function awsprof() {
  export AWS_PROFILE=$(awk '!/-long-term/' ~/.aws/credentials | awk -F '[][]' 'NF > 1 {print $2}' | fzf)
}

# Functions to help handle STS manipulation of IAM credentials from
# a shell console for AWS CLI, and other things - especially things
# that don't support IAM roles being specific in boto profile config
#
# When you use the mfa() function, we assume that you do not have your
# credentials defined with AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
# variables in the environment. The credentials must be configured elsewhere
# in the boto search path such as ~/.aws/credentials or an EC2 Instance Profile
#
# If you get in a muddle, use the unset-sts command and start again
# (or mfa, which issues unset-sts before doing anything)

# Function to clear current STS configuration.
#
# Use this to reset your session to your static AWS_PROFILE configuration
# removing any time-limited temporary credentials from your environment
function unset-sts() {
  unset AWS_ACCESS_KEY_ID;
  unset AWS_SECRET_ACCESS_KEY;
  unset AWS_SESSION_TOKEN;
  unset AWS_MFA_EXPIRY;
  unset AWS_SESSION_EXPIRY;
  unset AWS_ROLE;

  unset MFA_STS_DURATION;
}

# Authenticate with an MFA Token Code
function mfa() {
  # Remove any environment variables previously set by sts()
  unset-sts;

  export MFA_STS_DURATION=64800

  if [[ -z ${AWS_PROFILE+x} ]]; then
    echo "You need to provide the AWS profile using the environment variable 'AWS_PROFILE'";
    return 1;
  fi

  # Get MFA Serial
  #
  # Assumes "iam list-mfa-devices" is permitted without MFA
  mfa_serial="$(aws iam list-mfa-devices --query 'MFADevices[*].SerialNumber' --output text --profile "${AWS_PROFILE}-long-term")";
  if ! [ "${?}" -eq 0 ]; then
    echo "Failed to retrieve MFA serial number" >&2;
    return 1;
  fi;
  
  # Call AWS-MFA to get the session credentials
  # https://github.com/broamski/aws-mfa
  # Assumes "sts get-session-token" is permitted without MFA
  aws-mfa --device ${mfa_serial} --profile "${AWS_PROFILE}"

  if ! [ "${?}" -eq 0 ]; then
    echo "STS MFA Request Failed" >&2;
    return 1;
  fi;

  # Verifies a short term profile has been created
  temp_profile=$(cat ~/.aws/credentials | grep "\[${AWS_PROFILE}]" | sed 's/[][]//g')

  if [ "${temp_profile}" == "${AWS_PROFILE}" ]; then
    echo "You can now use the profile ${AWS_PROFILE}"
  else
    echo "aws-mfa failed generating the short-term profile ${AWS_PROFILE}"
    return 1;
  fi
}
