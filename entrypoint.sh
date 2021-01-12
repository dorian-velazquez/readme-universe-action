#!/bin/bash

eval $GIT_SSH_COMMAND

non_prod=(dev-centralus)
prod=(stage-centralus prod-centralus)

export ARM_ACCESS_KEY=$NONPROD_ARM_ACCESS_KEY
export ARM_CLIENT_ID=$NONPROD_ARM_CLIENT_ID
export ARM_CLIENT_SECRET=$NONPROD_ARM_CLIENT_SECRET
export ARM_SUBSCRIPTION_ID=$NONPROD_ARM_SUBSCRIPTION_ID
export ARM_TENANT_ID=$NONPROD_ARM_TENANT_ID

export tf_working_dir="environments/dev-centralus"
cd environments/dev-centralus/01-subnet
terragrunt output-all -json 2>&1 >/dev/null | tee output.json
cat output.json

: '
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
	
	# terragrunt output-all -json | tee output.json
	for service in $(ls -d -- */)
	do
		cd $service
		terragrunt output-all -json 2> >(grep -v "\[terragrunt]" >&2) | tee output.json

		# terraform output -json | tee output.json
		cd ..
	done
	
	cd ../../
done
'

