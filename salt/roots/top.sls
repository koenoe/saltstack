base:
  '*':
    - stack

  'roles:wordpress':
    - match: grain
    - modules.mysql
    - modules.redis
    - modules.memcached
    - modules.php
    - modules.composer
    - modules.wp-cli

  'roles:rails':
    - match: grain

  'roles:nodejs':
    - match: grain
    - modules.nodejs
