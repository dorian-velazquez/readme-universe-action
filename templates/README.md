# {{ project }}

## Environments
{% for env in environments %}
### {{ env }}
{% for service in environments[env] %}  - [{{ service }}](./environments/{{ service }})
{% with data = environments[env][service] %}{% if data != {} %}    | Name | value |
    | ---- | ----- |{% for prop in data%}{% if 'sensitive' not in data[prop] or ('sensitive' in data[prop] and data[prop]['sensitive'] == false ) %}
    | **{{ prop }}** | `{{data[prop]['value']}}` |{% endif %}{% endfor %}{% endif %}{% endwith %}
{% endfor %}{% endfor %} 
