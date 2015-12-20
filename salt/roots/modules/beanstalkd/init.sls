beanstalkd:
  pkg:
    - installed
  service:
    - dead
    - require:
      - pkg: beanstalkd