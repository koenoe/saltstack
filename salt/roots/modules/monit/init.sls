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
        email_to: {{ pillar['mail.admin'] }}
        email_from: monit@{{ pillar['mail.hostname'] }}
    - user: root
    - group: root
    - mode: 600

{% from 'modules/monit/macros.sls' import monitor_service %}

{{ monitor_service('ssh', 'ssh') }}
{{ monitor_service('nginx', 'nginx') }}
{{ monitor_service('beanstalk', 'beanstalk') }}
{{ monitor_service('supervisor', 'supervisor') }}
{{ monitor_service('nullmailer', 'nullmailer') }}

{% if 'php' in grains['language'] %}
{{ monitor_service('php', 'php') }}
{% endif %}

{% if 'mysql' in grains['database'] %}
{{ monitor_service('mysql', 'mysql') }}
{% endif %}
