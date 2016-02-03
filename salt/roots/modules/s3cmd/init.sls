s3cmd:
  pkg.latest:
    - pkgs:
      - s3cmd

{% if pillar.get('environment') == 'production' %}

{% if 'mysql' in grains['database'] %}
/usr/bin/s3cmd sync --skip-existing /var/lib/automysqlbackup/ s3://backup.{{ pillar.get('hostname.full') }}/mysql/ >> /var/log/s3cmd.log 2>&1:
  cron.present:
    - identifier: s3 backup mysql
    - user: root
    - minute: 0
    - hour: 1
{% endif %}

/usr/bin/s3cmd sync /var/lib/redis/ s3://backup.{{ pillar.get('hostname.full') }}/redis/ >> /var/log/s3cmd.log 2>&1:
  cron.present:
    - identifier: s3 backup redis
    - user: root
    - minute: 0
    - hour: 2

{% for site, args in pillar['sites'].iteritems() %}
{% if args['backup_folders'] %}

{% for folder in args['backup_folders'] %}
/usr/bin/s3cmd sync --skip-existing --delete-removed /home/koen/sites/{{ site }}/{{ folder['source'] }} s3://backup.{{ pillar.get('hostname.full') }}/{{ site }}/{{ folder['destination'] }}/ >> /var/log/s3cmd.log 2>&1:
  cron.present:
    - identifier: s3 backup {{ site }} {{ folder['destination'] }}
    - user: root
    - minute: 0
    - hour: 3
{% endfor %}

{% endif %}
{% endfor %}

{% endif %}

/root/.s3cfg:
  file.managed:
    - source: salt://modules/s3cmd/files/s3cfg
    - template: jinja
    - context:
        access_key: {{ pillar['s3.access_key'] }}
        secret_key: {{ pillar['s3.secret_key'] }}
