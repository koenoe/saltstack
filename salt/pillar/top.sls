base:
  '*':
    - common
    - data.users
    - data.sites
    - data.mail
    - data.s3
    - data.mandrill
    - data.redis

  'language:php':
    - match: grain
    - data.php

  'language:rails':
    - match: grain
    - data.rails

  'language:nodejs':
    - match: grain
    - data.nodejs

  'database:mysql':
    - match: grain
    - data.mysql

  'database:mongodb':
    - match: grain
