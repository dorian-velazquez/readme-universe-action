# {{ project }}

## Environments
{% for env in environments %}
### {{ env }}
{% for service in environments[env] %}  - [{{ service }}](./environments/{{ service }})
{% with data = environments[env][service] %}{% filter indent(4, true) %}{% include "./services/"+service+".j2" ignore missing %}{% endfilter %}{% endwith %}
{% endfor %}
{% endfor %} 
