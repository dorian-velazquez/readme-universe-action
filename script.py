#!/bin/python3

from jinja2 import Environment, FileSystemLoader
import os

project = os.environ.get('REPOSITORY_NAME')

data = {
        "project": project,
        "environments": {
            "dev": {},
            "test": {},
            "stage": {}
            }
        }

env = Environment(loader=FileSystemLoader("./templates"))

readme = env.get_template("README.md")

print(readme.render(data))
