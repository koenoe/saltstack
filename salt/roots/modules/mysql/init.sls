mysql:
  pkg.installed:
    - pkgs:
      - mysql-client
      - mysql-server
  service:
    - running
    - name: mysql
    - require:
      - pkg: mysql

mysql-config:
  augeas.change:
    - context: /files/etc/mysql/my.cnf
    - changes:
      - set target[.='mysqld']/bind-address '0.0.0.0'
      - set target[.='mysqld']/default-storage-engine 'INNODB'
      - set target[.='mysqld']/query_cache_limit '{{ pillar.get('mysql.query_cache_limit') }}'
      - set target[.='mysqld']/innodb_buffer_pool_size '{{ pillar.get('mysql.innodb_buffer_pool_size') }}'
    - require:
      - pkg: mysql
    - watch_in:
      - service: mysql

{% set pass = salt['pw_safe.get_mysql_user_password']('root') %}

set-mysql-root-password:
  cmd.run:
  - name: 'echo "update user set password=PASSWORD(''{{ pass }}'') where User=''root'';flush privileges;" | /usr/bin/env HOME=/ mysql -uroot mysql'
  - onlyif: 'echo | /usr/bin/env HOME=/ mysql -u root'
  - watch:
    - service: mysql

change-mysql-root-password:
  cmd.run:
  - name: 'echo "update user set password=PASSWORD(''{{ pass }}'') where User=''root'';flush privileges;" | mysql -uroot mysql'
  - onlyif: '(echo | mysql -u root) && [ -f /root/.my.cnf ] && ! fgrep -q ''{{ pass }}'' /root/.my.cnf'
  - require:
    - cmd: set-mysql-root-password

my-cnf:
  file.managed:
  - name: /root/.my.cnf
  - user: root
  - group: root
  - mode: '0600'
  - contents: "[client]\nuser=root\npassword='{{ pass }}'\n"
  - require:
    - cmd: change-mysql-root-password

mysql-secure-installation:
  cmd.run:
    - name: "mysql --defaults-file=/root/.my.cnf mysql -e \"DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); DROP DATABASE IF EXISTS test; FLUSH PRIVILEGES;\""
  require:
    - file: my-cnf