s3cmd:
  pkg.latest:
    - pkgs:
      - automysqlbackup
      - s3cmd

{% if pillar.get('environment') == 'production' %}
/usr/bin/s3cmd sync --skip-existing /var/lib/automysqlbackup/ s3://backup.{{ pillar.get('hostname') }}/mysql/ >> /var/log/s3cmd.log 2>&1:
  cron.present:
    - identifier: s3 backup mysql
    - user: root
    - minute: 0
    - hour: 1

/usr/bin/s3cmd sync /var/lib/redis/ s3://backup.{{ pillar.get('hostname') }}/redis/ >> /var/log/s3cmd.log 2>&1:
  cron.present:
    - identifier: s3 backup redis
    - user: root
    - minute: 0
    - hour: 2

{% for site, args in pillar['sites'].iteritems() %}
{% if args['backup_uploads'] %}

{% if grains['roles'] == 'wordpress' %}
/usr/bin/s3cmd sync /home/koen/sites/{{ site }}/current/web/app/uploads s3://backup.{{ pillar.get('hostname') }}/uploads/{{ site }}/ >> /var/log/s3cmd.log 2>&1:
  cron.present:
    - identifier: s3 backup uploads {{ site }}
    - user: root
    - minute: 0
    - hour: 3
{% elif grains['roles'] == 'rails' %}
# rails backup uploads here
{% elif grains['roles'] == 'nodejs' %}
# nodejs backup uploads here
{% endif %}

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
