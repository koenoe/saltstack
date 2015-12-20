/etc/php5/mods-available/mcrypt.ini:
  file.managed:
    - contents: "; configuration for php mcrypt module\n; priority=20\nextension=mcrypt.so"

php-mcrypt-enmod:
  cmd.run:
    - name: 'php5enmod mcrypt'
  require:
    - file: /etc/php5/mods-available/mcrypt.ini