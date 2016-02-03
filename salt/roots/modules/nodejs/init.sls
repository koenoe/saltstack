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

global-profile-nvm:
  file.managed:
    - name: /etc/profile.d/nvm.sh
    - source: salt://modules/nodejs/files/nvm.sh
    - require:
      - cmd: install-nvm

install-nodejs:
  cmd.run:
    - name: 'source /usr/local/nvm/nvm.sh; nvm install {{ pillar['nodejs.version'] }}'
    - user: root
    - require:
      - file: global-profile-nvm

use-nodejs-version:
  cmd.wait:
    - name: 'source /usr/local/nvm/nvm.sh; nvm use {{ pillar['nodejs.version'] }}'
    - user: root
    - watch:
      - cmd: install-nodejs

set-default-nodejs:
  cmd.wait:
    - name: 'source /usr/local/nvm/nvm.sh; nvm alias default {{ pillar['nodejs.version'] }}'
    - user: root
    - watch:
      - cmd: use-nodejs-version

global-nodejs:
  cmd.wait:
    - name: 'n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; cp -r $n/{bin,lib,share} /usr/local'
    - user: root
    - watch:
      - cmd: set-default-nodejs
