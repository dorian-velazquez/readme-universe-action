# {{ project }}

## Environments
{% for env in environments %}
### {{ env }}
{% for service in environments[env] %}  - {{ service }}
{% with data = environments[env][service] %}    {% include "./services/"+service+".j2" ignore missing %}{% endwith %}
{% endfor %}
{% endfor %} 
