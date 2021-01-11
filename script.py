#!/bin/python3

import json
from jinja2 import Environment, FileSystemLoader
import os


def get_output(base_path):
    output = {}
    try:
        output = json.load('{}/output.json'.format(base_path))
    except json.decoder.JSONDecodeError:
        output = {}
    return output


project = os.environ.get('GITHUB_REPOSITORY').split('/')[1]
environments = os.listdir(
        '{}/environments'.format(os.environ.get('GITHUB_WORKSPACE'))
        )

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
                        )}
            for n in environments}
        }


env = Environment(loader=FileSystemLoader("/templates"))

readme = env.get_template("README.md")

print(readme.render(data))
