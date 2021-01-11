#!/bin/bash

eval $GIT_SSH_COMMAND
non_prod=(dev-centralus)
prod=(stage-centralus prod-centralus)

for environment in $(ls environments)
do
	export tf_working_dir="environments/$environment"
	
	cd environments/$environment
	echo "::${environment}::"
	if [[ " ${prod[@]} " =~ " ${environment} " ]]; then
		export ARM_ACCESS_KEY=$PROD_ARM_ACCESS_KEY
		export ARM_CLIENT_ID=$PROD_ARM_CLIENT_ID
		export ARM_CLIENT_SECRET=$PROD_ARM_CLIENT_SECRET
		export ARM_SUBSCRIPTION_ID=$PROD_ARM_SUBSCRIPTION_ID
		export ARM_TENANT_ID=$PROD_ARM_TENANT_ID
	else
		export ARM_ACCESS_KEY=$NONPROD_ARM_ACCESS_KEY
		export ARM_CLIENT_ID=$NONPROD_ARM_CLIENT_ID
		export ARM_CLIENT_SECRET=$NONPROD_ARM_CLIENT_SECRET
		export ARM_SUBSCRIPTION_ID=$NONPROD_ARM_SUBSCRIPTION_ID
		export ARM_TENANT_ID=$NONPROD_ARM_TENANT_ID
	fi
	
	terragrunt init
	terragrunt output-all -json
	
	cd ../../
done
python /script.py
