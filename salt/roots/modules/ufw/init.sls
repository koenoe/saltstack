ufw:
  pkg:
    - latest
  service:
    - running
    - require:
      - pkg: ufw

ufw-allow-ssh:
  cmd.run:
  - name: ufw allow ssh
  - unless: 'ufw status | grep "^22\s*ALLOW"'

ufw-limit-ssh:
  cmd.run:
  - name: ufw limit ssh
  - unless: 'ufw status | grep "^22\s*LIMIT"'

ufw-allow-http:
  cmd.run:
  - name: ufw allow http
  - unless: 'ufw status | grep "^80\s*ALLOW"'

ufw-allow-http-webhook:
  cmd.run:
  - name: ufw allow http
  - unless: 'ufw status | grep "^5000\s*ALLOW"'

ufw-allow-https:
  cmd.run:
  - name: ufw allow https
  - unless: 'ufw status | grep "^443\s*ALLOW"'

ufw-allow-lan:
  cmd.run:
  - name: ufw allow from 192.168.1.0/24 to any
  - unless: 'ufw status | grep "^Anywhere\s*ALLOW\s*192.168.1.0/24"'

ufw-enable:
  cmd.run:
  - name: ufw --force enable
  - unless: 'ufw status | grep "Status: active"'
