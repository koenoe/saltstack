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
    - group: www-data
    - mode: 755
    - makedirs: True

/etc/nginx/ssl:
  file.directory:
    - user: root
    - group: root
    - mode: 400
    - makedirs: True

/etc/nginx/ssl/dhparams.pem:
  cmd.run:
    - name: openssl dhparam -out /etc/nginx/ssl/dhparams.pem 2048
    - require:
      - file: /etc/nginx/ssl
    - unless: test -f /etc/nginx/ssl/dhparams.pem

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
