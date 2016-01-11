base:
  '*':
    - stack

  'language:php':
    - match: grain
    - modules.php
    - modules.composer
    - modules.wp-cli

  'language:rails':
    - match: grain
    - modules.ruby

  'language:nodejs':
    - match: grain
    - modules.nodejs

  'database:mysql':
    - match: grain
    - modules.mysql

  'database:mongodb':
    - match: grain
