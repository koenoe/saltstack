{% macro nginx_conf(name, conf) %}
nginx-conf-{{ name }}:
  file.managed:
    - name: /etc/nginx/global/{{ conf|default(name) }}.conf
    - source: salt://modules/nginx/files/{{ conf|default(name) }}.conf
    - user: www-data
    - group: root
    - mode: 644
    - makedirs: true
{% endmacro %}
