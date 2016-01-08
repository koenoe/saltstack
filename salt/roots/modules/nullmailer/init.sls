nullmailer:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: nullmailer

/etc/nullmailer/remotes:
  file.managed:
    - contents: |
        smtp.mandrillapp.com smtp --starttls --user={{ pillar['mandrill.username'] }} --pass={{ pillar['mandrill.password'] }} --port={{ pillar['mail.port'] }}
    - user: mail
    - group: mail
    - mode: 600

/etc/nullmailer/adminaddr:
  file.managed:
    - contents: |
        {{ pillar['mail.admin'] }}
    - user: root
    - group: root
    - mode: 644

/etc/nullmailer/defaulthost:
  file.managed:
    - contents: |
        {{ pillar['mail.hostname'] }}
    - user: root
    - group: root
    - mode: 640

/etc/nullmailer/defaultdomain:
  file.managed:
    - contents: |
        {{ pillar['mail.hostname'] }}
    - user: root
    - group: root
    - mode: 640
