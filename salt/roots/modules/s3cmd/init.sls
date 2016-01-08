s3cmd:
  pkg.latest:
    - pkgs:
      - automysqlbackup
      - s3cmd

/usr/bin/s3cmd sync --skip-existing /var/lib/automysqlbackup/ s3://backup.{{ pillar.get('hostname') }}/mysql/ >> /var/log/s3cmd.log 2>&1:
  cron.present:
    - identifier: s3 backup mysql
    - user: root
    - minute: 0
    - hour: 2

/usr/bin/s3cmd sync /var/lib/redis/ s3://backup.{{ pillar.get('hostname') }}/redis/ >> /var/log/s3cmd.log 2>&1:
  cron.present:
    - identifier: s3 backup redis
    - user: root
    - minute: 0
    - hour: 3

/root/.s3cfg:
  file.managed:
    - source: salt://modules/s3cmd/files/s3cfg
    - template: jinja
    - context:
        access_key: {{ pillar['s3.access_key'] }}
        secret_key: {{ pillar['s3.secret_key'] }}
