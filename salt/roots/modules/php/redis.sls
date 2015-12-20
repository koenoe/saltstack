php-pear:
  pkg:
    - installed
    - require:
      - pkg: php

php-redis:
  pecl.installed:
    - name: redis
    - defaults: true
    - require:
      - pkg: php

/etc/php5/mods-available/redis.ini:
  file.managed:
    - contents: "; configuration for php redis module\n; priority=20\nextension=redis.so"
    - require.pecl: php-redis

php-redis-enmod:
  cmd.run:
    - name: 'php5enmod redis'
  require:
    - file: /etc/php5/mods-available/redis.ini
