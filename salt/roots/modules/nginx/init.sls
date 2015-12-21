nginx:
  pkg:
    - installed
  service.running:
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://modules/nginx/files/nginx.conf
    - user: root
    - group: root
    - mode: 640

/var/cache/nginx:
  file.directory:
    - user: www-data
    - group: root
    - mode: 644
    - makedirs: True

{% from 'modules/nginx/macros.sls' import nginx_conf %}

{{ nginx_conf('http', 'http') }}
{{ nginx_conf('mime-types', 'mime-types') }}
{{ nginx_conf('limits', 'limits') }}
{{ nginx_conf('gzip', 'gzip') }}
{{ nginx_conf('exclusions', 'exclusions') }}
{{ nginx_conf('security', 'security') }}
{{ nginx_conf('static-files', 'static-files') }}
{{ nginx_conf('fastcgi-params', 'fastcgi-params') }}
{{ nginx_conf('fastcgi-cache', 'fastcgi-cache') }}
{{ nginx_conf('ssl', 'ssl') }}
