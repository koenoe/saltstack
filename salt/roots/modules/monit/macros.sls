{% macro monitor_service(name, service) %}
monitor-service-{{ name }}:
  file.managed:
    - name: /etc/monit/conf.d/{{ service|default(name) }}
    - source: salt://modules/monit/files/{{ service|default(name) }}.conf
    - watch_in:
      - service: monit
{% endmacro %}
