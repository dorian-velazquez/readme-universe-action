#!/bin/python3

from jinja2 import Template
import os

REPOSITORY_NAME = os.environ.get('REPOSITORY_NAME')
ENVIRONMENTS = ['dev','test','stage','prod']

data = {
        'REPOSITORY_NAME':REPOSITORY_NAME,
        'ENVIRONMENTS':ENVIRONMENTS
        }

with open('./templates/README.md.j2') as f:
    readme_j2 = f.read()

template = Template(readme_j2)
print(template.render(data))

