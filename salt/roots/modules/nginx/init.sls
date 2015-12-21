nginx-extras:
  pkg:
    - installed

nginx_conf:
  augeas.change:
    - context: /files/etc/nginx/nginx.conf
    - changes:
      - set worker_processes {{ pillar.get('nginx.worker_processes', 'auto') }}
      - set worker_rlimit_nofile 8192
      - set events/worker_connections 8000
      - set events/multi_accept on
      - set http/include global/http.conf
      # - set http/include global/mime-types.conf
      - set http/default_type application/octet-stream
      # - set http/include global/limits.conf
      # - set http/include global/gzip.conf
      # - set http/include global/exclusions.conf
      # - set http/include global/security.conf
      # - set http/include global/static-files.conf
      # - set http/include global/fastcgi-cache.conf
    - require:
      - pkg: nginx-extras

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
