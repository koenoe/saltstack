monit:
  pkg:
    - latest
  service:
    - running

/etc/monit/monitrc:
  file.managed:
    - source: salt://modules/monit/files/monitrc
    - template: jinja
    - context:
        username: {{ pillar['mandrill.username'] }}
        password: {{ pillar['mandrill.password'] }}
        alert: {{ pillar['mail.admin'] }}
    - user: root
    - group: root
    - mode: 600

{% from 'modules/monit/macros.sls' import monitor_service %}

{{ monitor_service('ssh', 'ssh') }}
{{ monitor_service('nginx', 'nginx') }}
{{ monitor_service('beanstalk', 'beanstalk') }}
{{ monitor_service('supervisor', 'supervisor') }}
{{ monitor_service('nullmailer', 'nullmailer') }}

{% if grains['roles'] == 'wordpress' %}
{{ monitor_service('php', 'php') }}
{{ monitor_service('mysql', 'mysql') }}
{% endif %}
