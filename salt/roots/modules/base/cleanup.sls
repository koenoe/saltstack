# Remove tty's
{% for i in range(2, 7) %}
{{ '/etc/init/tty%d.conf'|format(i) }}:
  file.absent
{% endfor %}

# Remove some pre-installed packages
purge:
  pkg.purged:
    - pkgs:
      - at
      - chef
      - consolekit
      - irqbalance
      - landscape-client
      - landscape-common
      - puppet
      - puppet-common
      - resolvconf
      - whoopsie
      - postfix

# Aptitude cleanup
cleanup:
  cmd.run:
    - names:
      - apt-get -y -q autoremove
      - apt-get -y -q autoclean
    - require:
      - pkg: purge
