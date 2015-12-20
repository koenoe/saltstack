{% for host, ip in pillar.get('hosts', {}).iteritems() %}
{{ host }}:
  host.present:
    - ip: {{ ip }}
{% endfor %}