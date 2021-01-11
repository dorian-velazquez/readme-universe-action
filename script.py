#!/bin/python3

import json
from jinja2 import Environment, FileSystemLoader
import os


def get_output(base_path):
    output = {}
    try:
        output = json.load(open('{}/output.json'.format(base_path)))
    except json.decoder.JSONDecodeError:
        output = {}
    return output


project = os.environ.get('GITHUB_REPOSITORY').split('/')[1]
environments = [n for n in os.listdir(
        '{}/environments'.format(os.environ.get('GITHUB_WORKSPACE')))
        if os.path.isdir(
            '{}/environments/{}'.format(os.environ.get('GITHUB_WORKSPACE'), n))
        ]

data = {
        "project": project,
        "environments": {
            n: {
                s: get_output(
                    '{}/environments/{}/{}'.format(
                        os.environ.get('GITHUB_WORKSPACE'), n, s)
                    ) for s in os.listdir(
                        '{}/environments/{}'.format(
                            os.environ.get('GITHUB_WORKSPACE'), n)
                        ) if os.path.isdir(
                        '{}/environments/{}/{}'.format(
                            os.environ.get('GITHUB_WORKSPACE'), n, s)
                        )
                    }
            for n in environments}
        }


print("DATA: ",data)
env = Environment(loader=FileSystemLoader("/templates"))

readme = env.get_template("README.md")

print(readme.render(data))
