# ruby:
#   pkg.installed:
#     - names:
#       - git
#       - build-essential
#       - openssl
#       - curl
#       - zlib1g
#       - zlib1g-dev
#       - libssl-dev
#       - libyaml-dev
#       - libsqlite3-0
#       - libsqlite3-dev
#       - libreadline-dev
#       - sqlite3
#       - libxml2-dev
#       - libxslt1-dev
#       - autoconf
#       - libc6-dev
#       - libncurses5-dev
#       - automake
#       - libtool
#       - bison
#
# /usr/local/rbenv:
#   file.directory:
#     - makedirs: True
#
# git-rbenv:
#   git.latest:
#     - name: https://github.com/sstephenson/rbenv.git
#     - rev: master
#     - target: /usr/local/rbenv
#     - force: True
#     - require:
#       - pkg: ruby
#       - file: /usr/local/rbenv
#
# git-ruby-build:
#   git.latest:
#     - name: https://github.com/sstephenson/ruby-build.git
#     - rev: master
#     - target: /usr/local/rbenv/plugins
#     - force: True
#     - require:
#       - git: git-rbenv
#       - file: /usr/local/rbenv
#
# create-profile:
#   file.managed:
#     - name: /etc/profile.d/rbenv.sh
#     - source: salt://modules/ruby/files/rbenv.sh
#     - require:
#       - git: git-ruby-build
#
# source-profile:
#   cmd.run:
#     - name: source /etc/profile.d/rbenv.sh
#     - require:
#       - file: create-profile
#
# rbenv-install:
#   cmd.run:
#     - name: /usr/local/rbenv/bin/rbenv install {{ pillar['ruby.version'] }}
#     - require:
#       - git: git-ruby-build
#
# rbenv-rehash:
#   cmd.run:
#     - name: /usr/local/rbenv/bin/rbenv rehash
#     - require:
#       - cmd: rbenv-install
#
# rbenv-global:
#   cmd.run:
#     - name: /usr/local/rbenv/bin/rbenv global {{ pillar['ruby.version'] }}
#     - require:
#       - cmd: rbenv-rehash

ruby:
  pkg.installed:
    - names:
      - git
      - build-essential
      - openssl
      - curl
      - zlib1g
      - zlib1g-dev
      - libssl-dev
      - libyaml-dev
      - libsqlite3-0
      - libsqlite3-dev
      - libreadline-dev
      - sqlite3
      - libxml2-dev
      - libxslt1-dev
      - autoconf
      - libc6-dev
      - libncurses5-dev
      - automake
      - libtool
      - bison
      - subversion

/root/.rbenv:
  file.directory:
    - makedirs: True

https://github.com/sstephenson/rbenv.git:
  git.latest:
    - rev: master
    - target: /root/.rbenv
    - force: True
    - require:
      - pkg: ruby
      - file: /root/.rbenv

https://github.com/sstephenson/ruby-build.git:
  git.latest:
    - rev: master
    - target: /root/.rbenv/plugins/ruby-build
    - force: True
    - require:
      - git: https://github.com/sstephenson/rbenv.git
      - file: /root/.rbenv

/root/.profile:
  file.append:
    - text:
      - export PATH="$HOME/.rbenv/bin:$PATH"
      - eval "$(rbenv init -)"
    - require:
      - git: https://github.com/sstephenson/rbenv.git

rbenv-install:
  cmd.run:
    - name: /root/.rbenv/bin/rbenv install {{ pillar['ruby.version'] }}
    - require:
      - git: https://github.com/sstephenson/ruby-build.git

rbenv-rehash:
  cmd.run:
    - name: /root/.rbenv/bin/rbenv rehash
    - require:
      - cmd: rbenv-install

rbenv-global:
  cmd.run:
    - name: /root/.rbenv/bin/rbenv global {{ pillar['ruby.version'] }}
    - require:
      - cmd: rbenv-rehash

source-profile:
  cmd.wait:
    - name: source /root/.profile
    - watch:
        - cmd: rbenv-global
    - require:
      - cmd: /root/.rbenv/bin/rbenv global {{ pillar['ruby.version'] }}
