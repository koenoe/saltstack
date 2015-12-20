php:
  pkg.installed:
    - names:
      - php5-fpm
      - php5-curl
      - php5-dev
      - php5-gd
      - php5-json
      - php5-intl
      - php5-mcrypt
      - php5-mysql
      - php5-intl
      - php5-xdebug
      - php5-geoip
      - php5-memcached

{% for sapi in ['cli', 'fpm'] %}
php_{{ sapi }}_config:
  augeas.change:
    - context: /files/etc/php5/{{ sapi }}/php.ini
    - changes:
      - set Date/date.timezone '{{ pillar.get('php.timezone') }}'
      - set PHP/upload_max_filesize '{{ pillar.get('php.upload_max_filesize') }}'
      - set PHP/post_max_size '{{ pillar.get('php.post_max_size') }}'
      - set PHP/display_errors 'True'
      - set PHP/error_reporting 'E_ALL'
    - require:
      - pkg: php
{% endfor %}

php_fpm_www_config:
  augeas.change:
    - context: /files/etc/php5/fpm/pool.d/www.conf
    - changes:
      - set www/pm.max_children 16
      - set www/pm.start_servers 4
      - set www/pm.min_spare_servers 4
      - set www/pm.max_spare_servers 8
    - require:
      - pkg: php5-fpm

include:
  - modules.php.redis
  - modules.php.mcrypt
