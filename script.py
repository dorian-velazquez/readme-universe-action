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


def get_services(base_path):
    services = os.listdir(base_path)
    services = [s for s in services if os.path.isdir(
        '{}/{}'.format(base_path, s))
        ]
    services.sort()
    return services


workspace = os.environ.get('GITHUB_WORKSPACE')
project = os.environ.get('GITHUB_REPOSITORY').split('/')[1]
environments = [n for n in os.listdir(
        '{}/environments'.format(workspace))
        if os.path.isdir(
            '{}/environments/{}'.format(workspace, n))
        ]


data = {
        "project": project,
        "environments": {
            n: {
                s: get_output(
                    '{}/environments/{}/{}'.format(workspace, n, s)
                    ) for s in get_services(
                        '{}/environments/{}'.format(workspace, n))
                    }
            for n in environments}
        }

env = Environment(loader=FileSystemLoader("/templates"))

readme = env.get_template("README.md")

print(readme.render(data))
