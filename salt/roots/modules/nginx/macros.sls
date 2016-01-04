{% macro nginx_conf(name, conf) %}
nginx-conf-{{ name }}:
  file.managed:
    - name: /etc/nginx/global/{{ conf|default(name) }}.conf
    - source: salt://modules/nginx/files/{{ conf|default(name) }}.conf
    - user: root
    - group: root
    - mode: 640
    - makedirs: true
{% endmacro %}
