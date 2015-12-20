nginx-extras:
  pkg:
    - installed

nginx_conf:
  augeas.change:
    - context: /files/etc/nginx/nginx.conf
    - changes:
      - set worker_processes {{ pillar.get('nginx.worker_processes', 'auto') }}
      - set http/sendfile 'off'
      - set http/variables_hash_bucket_size '1024'
      - set http/gzip_vary 'on'
      - set http/gzip_proxied 'any'
      - set http/gzip_comp_level '6'
      - set http/gzip_buffers '16 8k'
      - set http/gzip_http_version '1.1'
      - set http/gzip_types 'text/plain text/css application/json application/x-javascript application/javascript text/xml application/xml application/xml+rss text/javascript font/ttf font/opentype application/vnd.ms-fontobject image/svg+xml'
    - require:
      - pkg: nginx-extras

/var/cache/nginx:
  file.directory:
    - user: www-data
    - group: root
    - mode: 644
    - makedirs: True
