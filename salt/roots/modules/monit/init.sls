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
        username: {{ pillar['sendgrid.username'] }}
        password: {{ pillar['sendgrid.password'] }}
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
{{ monitor_service('php', 'php') }}
{{ monitor_service('mysql', 'mysql') }}
