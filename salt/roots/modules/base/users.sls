{% for group, gid in pillar['groups'].iteritems() %}
group-{{ group }}:
  group.present:
    - name: {{ group }}
    - gid: {{ gid }}
{% endfor %}

{% set pass = salt['pw_safe.get_mysql_user_password']('root') %}

{% for user, args in pillar['users'].iteritems() %}
{% set uid = args['uid']|default(none) %}
{% set gid = args['gid']|default(none) %}
{% set groups = args['groups']|default(pillar['groups']) %}
{% set home = '/home/%s'|format(user) %}
{% set shell = args['shell']|default('/bin/bash') %}
{% if not args['login']|default(true) %}
  {% set home = false %}
  {% set shell = '/bin/false' %}
{% endif %}
user-{{ user }}:
  user.present:
    - name: {{ user }}
    - uid: {{ uid }}
    - gid: {{ gid }}
    - password: {{ pass }}
    - home: {{ home }}
    - shell: {{ shell }}
    {% if args['fullname'] is defined %}
    - fullname: {{ args['fullname'] }}
    {% endif %}
    - groups: {{ groups }}

sudoers-{{ user }}:
  file.managed:
    - name: /etc/sudoers.d/{{ user }}
    - contents: "{{ user }}        ALL=(ALL)NOPASSWD: ALL"
{% endfor %}
