# nodejs:
#   pkgrepo.managed:
#     - ppa: chris-lea/node.js
#     - require_in:
#       - pkg: nodejs
#   pkg.latest:
#     - refresh: true

nodejs:
  pkg.installed:
    - names:
      - git
      - build-essential
      - openssl
      - curl

install-nvm:
  cmd.run:
    - name: 'CURL=`which curl`; $CURL -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | NVM_DIR="/usr/local/nvm" bash'
    - cwd: /root/

source-nvm:
  cmd.wait:
    - name: source /usr/local/nvm/nvm.sh
    - cwd: /root/
    - watch:
      - cmd: install-nvm

install-nodejs:
  cmd.wait:
    - name: nvm install {{ pillar['nodejs.version'] }}
    - cwd: /root/
    - watch:
      - cmd: source-nvm

use-nodejs-version:
  cmd.wait:
    - name: nvm use {{ pillar['nodejs.version'] }}
    - cwd: /root/
    - watch:
      - cmd: install-nodejs

set-default-nodejs:
  cmd.wait:
    - name: nvm alias default {{ pillar['nodejs.version'] }}
    - cwd: /root/
    - watch:
      - cmd: use-nodejs-version

global-nodejs:
  cmd.wait:
    - name: 'n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; cp -r $n/{bin,lib,share} /usr/local'
    - cwd: /root/
    - watch:
      - cmd: set-default-nodejs

# create-nvm-folder:
#   file.directory:
#     - name: /root/.nvm
#     - makedirs: True
#
# clone-nvm-repo:
#   git.latest:
#     - name: https://github.com/creationix/nvm.git
#     - rev: master
#     - target: /root/.nvm
#     - force: True
#     - require:
#       - file: create-nvm-folder
#
# source-nvm:
#   cmd.run:
#     - name: source /root/.nvm/nvm.sh
#     - require:
#       - git: clone-nvm-repo
#
# add-nvm-path:
#   file.append:
#     - name: /root/.profile
#     - text: |
#         export NVM_DIR="$HOME/.nvm"
#         [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
#     - require:
#       - git: clone-nvm-repo
#
# install-nodejs:
#   cmd.run:
#     - names:
#       - nvm install {{ pillar['nodejs.version'] }}
#       - nvm use {{ pillar['nodejs.version'] }}
#     - require:
#       - file: add-nvm-path
