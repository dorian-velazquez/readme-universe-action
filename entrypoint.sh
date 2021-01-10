#!/bin/bash

non_prod=(dev-centralus)
prod=(stage-centralus prod-centralus)
for environment in $(ls environments)
do
	if [[ " ${prod[@]} " =~ " ${environment} " ]]; then
		# use prod env variables
	fi
done
echo $(terraform --version )
python /script.py
