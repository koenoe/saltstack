# environment
{% if salt['cmd.run']('hostname') == 'vagrant-ubuntu-trusty-64' %}
environment: development
{% else %}
environment: production
{% endif %}

# hostname
hostname: {{ salt['cmd.run']('hostname') }}

## hosts
# hosts:
# db.mysql.syts: 127.0.0.1
# db.redis.syts.cache: 127.0.0.1

# mysql
mysql.query_cache_limit: 16M
mysql.innodb_buffer_pool_size: 256M

# redis
redis.maxmemory: 1G

# php
php.timezone: UTC
php.upload_max_filesize: 32M
php.post_max_size: 10M

# mail
mail.port: 587
mail.admin: admin@koenromers.com

# mail hostname
{% if pillar.get('environment') == 'development' %}
mail.hostname: koenromers.com
{% else %}
mail.hostname: {{ pillar.get('hostname') }}
{% endif %}
