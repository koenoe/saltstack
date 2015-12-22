{% macro monitor_service(name, service) %}
monitor-service-{{ name }}:
  file.managed:
    - name: /etc/monit/conf.d/{{ service|default(name) }}
    - source: salt://modules/monit/files/{{ service|default(name) }}.conf
    - template: jinja
    - watch_in:
      - service: monit
{% endmacro %}
