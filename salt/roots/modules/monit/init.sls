monit:
  pkg:
    - latest
  service:
    - running

{% from 'modules/monit/macros.sls' import monitor_service %}

{{ monitor_service('nginx', 'nginx') }}
{{ monitor_service('beanstalk', 'beanstalk') }}
{{ monitor_service('supervisor', 'supervisor') }}

{% if grains['roles'] == 'wordpress' %}
{{ monitor_service('php', 'php') }}
{{ monitor_service('mysql', 'mysql') }}
{% endif %}
