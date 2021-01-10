#!/bin/bash

non_prod=(dev-centralus)
prod=(stage-centralus prod-centralus)

for environment in $(ls environments)
do
	cd environments/$environment
	#if [[ " ${prod[@]} " =~ " ${environment} " ]]; then
		tf_working_dir="environments/$environment"
		echo $(terragrunt init)
	#fi
	cd ../../
done
python /script.py
