#!/bin/python3

from jinja2 import Environment, FileSystemLoader
import os

project = os.environ.get('GITHUB_REPOSITORY').split('/')[1]
environments = os.listdir('{}/environments'.format(GITHUB_WORKSPACE))

data = {
        "project": project,
        "environments": { n:{} for n in environments }
        }

env = Environment(loader=FileSystemLoader("/templates"))

readme = env.get_template("README.md")

print(readme.render(data))
