#!/bin/bash -f

export SETTINGS=$HOME/hk8sLabsSettings

if [ -f $SETTINGS ]
  then
    echo "Loading existing settings information"
    source $SETTINGS
  else 
    echo "No existing settings cannot continue"
    exit 10
fi

source $SETTINGS

if [ -z $COMPARTMENT_OCID ]
then
  echo "Your COMPARTMENT_OCID has not been set, you need to run the compartment-setup.sh before you can run this script"
  exit 2
fi

if [ -z $USER_INITIALS ]
then
  echo "Your USER_INITIALS has not been set, you need to run the initials-setup.sh before you can run this script"
  exit 2
fi

cd ../common/dynamic-groups

FINAL_RESP="0"
bash ./dynamic-group-setup.sh "$USER_INITIALS"BuildDynamicGroup devopsbuildpipeline "This dynamic group identifies the DevOps Build Pipelines"
RESP=$?
if [ "$RESP" -ne 0 ]
then
  echo "Problem setting up dynamic group "$USER_INITIALS"BuildDynamicGroup response is $RESP"
  FINAL_RESP=$RESP
fi

bash ./dynamic-group-setup.sh "$USER_INITIALS"CodeReposDynamicGroup devopsrepository "This dynamic group identifies the OCI code repositories resources"
RESP=$?
if [ "$RESP" -ne 0 ]
then
  echo "Problem setting up dynamic group "$USER_INITIALS"CodeReposDynamicGroup response is $RESP"
  FINAL_RESP=$RESP
fi
bash ./dynamic-group-setup.sh "$USER_INITIALS"DeployDynamicGroup devopsdeploypipeline "This dynamic group identifies the deployment tools resources"
RESP=$?
if [ "$RESP" -ne 0 ]
then
  echo "Problem setting up dynamic group "$USER_INITIALS"DeployDynamicGroup response is $RESP"
  FINAL_RESP=$RESP
fi
exit $FINAL_RESP