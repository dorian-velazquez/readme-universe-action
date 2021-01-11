#!/bin/python3

from jinja2 import Environment, FileSystemLoader
import os

project = os.environ.get('GITHUB_REPOSITORY').split('/')[1]
environments = os.listdir('{}/environments'.format(os.environ.get('GITHUB_WORKSPACE')))

for n in environments:
    with open('{}/environments/{}/output.json'.format(os.environ.get('GITHUB_WORKSPACE'), n), 'r') as data_file:
        output = data_file.read()
    print("**** {} ****".format(output))

data = {
        "project": project,
        "environments": { 
            n:{  s:{} for s in os.listdir('{}/environments/{}'.format(os.environ.get('GITHUB_WORKSPACE'), n)) }
            for n in environments 
            }
        }

env = Environment(loader=FileSystemLoader("/templates"))

readme = env.get_template("README.md")

print(readme.render(data))
