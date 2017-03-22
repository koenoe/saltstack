{% if pillar.get('environment') == 'production' %}

{% for user, args in pillar['users'].iteritems() %}
sshkeys-{{ user }}:
   ssh_auth:
      - present
      - user: {{ user }}
      - enc: ssh-rsa
      - names:
        {% for sshkey in args['sshkeys'] %}
          - {{ sshkey }}
        {% endfor %}
{% endfor %}

ssh_conf:
  augeas.change:
    - context: /files/etc/ssh/sshd_config
    - changes:
      - set PasswordAuthentication 'no'
      - set UsePAM 'no'

{% endif %}
