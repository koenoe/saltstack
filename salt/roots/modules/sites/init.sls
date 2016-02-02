{% for site, args in pillar['sites'].iteritems() %}
/etc/nginx/sites-enabled/{{ site }}.vhost:
  file.symlink:
    {% if pillar.get('environment') == 'development' %}
    - target: /home/koen/sites/{{ site }}/vhosts/{{ site }}.vhost
    {% else %}
    - target: /home/koen/sites/{{ site }}/current/vhosts/{{ site }}.vhost
    {% endif %}
{% endfor %}
