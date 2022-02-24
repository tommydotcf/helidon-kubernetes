#!/bin/bash -f

export SETTINGS=$HOME/hk8sLabsSettings

if [ -f $SETTINGS ]
  then
    echo Loading existing settings information
    source $SETTINGS
  else 
    echo No existing settings cannot contiue
    exit 10
fi

source $SETTINGS

if [ -z $COMPARTMENT_OCID ]
then
  echo Your COMPARTMENT_OCID has not been set, you need to run the compartment-setup.sh before you can run this script
  exit 2
fi

if [ -z $USER_INITIALS ]
then
  echo Your USER_INITIALS has not been set, you need to run the initials-setup.sh before you can run this script
  exit 2
fi

cd ../common/policies

bash ./policy-setup.sh "$USER_INITIALS"DevOpsCodeRepoPolicy dynamic-group "$USER_INITIALS"CodeReposDynamicGroup "This policy allows the dynamic group of code repo resources resources to create trigger the build process"
bash ./policy-setup.sh "$USER_INITIALS"DevOpsBuildPolicy dynamic-group "$USER_INITIALS"BuildDynamicGroup "This policy allows the dynamic group of build resources resources to create build runners, and trigger deployments"
bash ./policy-setup.sh "$USER_INITIALS"DevOpsDeployPolicy dynamic-group "$USER_INITIALS"DeployDynamicGroup "This policy allows the deployment tooling to interact with the destination systems (OKE, Functions etc.)"