# nodejs:
#   pkgrepo.managed:
#     - ppa: chris-lea/node.js
#     - require_in:
#       - pkg: nodejs
#   pkg.latest:
#     - refresh: true

nodejs-deps:
  pkg.installed:
    - names:
      - git
      - build-essential
      - openssl
      - curl

install-nvm:
  cmd.run:
    - name: 'CURL=`which curl`; $CURL -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | NVM_DIR="/usr/local/nvm" bash'
    - user: root
    - require:
      - pkg: nodejs-deps

global-profile:
  file.managed:
    - name: /etc/profile.d/nvm.sh
    - source: salt://modules/nodejs/files/nvm.sh
    - require:
      - cmd: install-nvm

install-nodejs:
  cmd.run:
    - name: nvm install {{ pillar['nodejs.version'] }}
    - user: root
    - require:
      - file: global-profile

use-nodejs-version:
  cmd.wait:
    - name: nvm use {{ pillar['nodejs.version'] }}
    - user: root
    - watch:
      - cmd: install-nodejs

set-default-nodejs:
  cmd.wait:
    - name: nvm alias default {{ pillar['nodejs.version'] }}
    - user: root
    - watch:
      - cmd: use-nodejs-version

global-nodejs:
  cmd.wait:
    - name: 'n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; cp -r $n/{bin,lib,share} /usr/local'
    - user: root
    - watch:
      - cmd: set-default-nodejs
