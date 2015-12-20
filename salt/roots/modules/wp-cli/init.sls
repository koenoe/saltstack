get-wp-cli:
  cmd.run:
    - name: 'CURL=`which curl`; $CURL -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
    - unless: test -f /usr/local/bin/wp
    - cwd: /root/

install-wp-cli:
  cmd.wait:
    - name: 'chmod +x wp-cli.phar; mv /root/wp-cli.phar /usr/local/bin/wp'
    - cwd: /root/
    - watch:
      - cmd: get-wp-cli
