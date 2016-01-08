{% for site in pillar.get('sites') %}
/etc/nginx/sites-enabled/{{ site }}.vhost:
  file.symlink:
    - target: /home/koen/sites/{{ site }}/vhosts/{{ site }}.vhost
{% endfor %}
