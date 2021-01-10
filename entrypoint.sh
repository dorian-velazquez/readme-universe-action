#!/bin/bash

non_prod=(dev-centralus)
prod=(stage-centralus prod-centralus)

cd environments
for environment in $(ls)
do
	#if [[ " ${prod[@]} " =~ " ${environment} " ]]; then
		tf_working_dir="environments/$environment"
		echo $(terragrunt init)
	#fi
done
python /script.py
