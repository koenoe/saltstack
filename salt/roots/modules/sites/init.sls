{% for site, args in pillar['sites'].iteritems() %}
/etc/nginx/sites-enabled/{{ site }}.vhost:
  file.symlink:
    - target: /home/koen/sites/{{ site }}/vhosts/{{ site }}.vhost
{% endfor %}
