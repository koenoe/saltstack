rbenv-deps:
  pkg.installed:
    - names:
      - bash
      - git
      - openssl
      - libssl-dev
      - make
      - curl
      - autoconf
      - bison
      - build-essential
      - libffi-dev
      - libyaml-dev
      - libreadline6-dev
      - zlib1g-dev
      - libncurses5-dev

install-rbenv:
  rbenv.install_rbenv:
    - user: root
    - require:
      - pkg: rbenv-deps

git-ruby-build:
  git.latest:
    - name: https://github.com/sstephenson/ruby-build.git
    - rev: master
    - target: /usr/local/rbenv/plugins/ruby-build
    - force: True
    - user: root
    - require:
      - rbenv: install-rbenv

global-profile-rbenv:
  file.managed:
    - name: /etc/profile.d/rbenv.sh
    - source: salt://modules/ruby/files/rbenv.sh
    - user: root
    - require:
      - git: git-ruby-build

/root/.bashrc:
  file.append:
    - source: salt://modules/ruby/files/rbenv.sh
    - require:
      - git: git-ruby-build

install-ruby:
  rbenv.installed:
    - name: ruby-{{ pillar['ruby.version'] }}
    - default: True
    - user: root
    - require:
      - file: global-profile

bundler:
  cmd.run:
  - user: root
  - name: 'gem install bundler'
  - require:
    - file: install-ruby
