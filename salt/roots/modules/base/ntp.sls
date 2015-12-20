ntp:
  pkg:
    - latest
  service:
    - running
    - require:
      - pkg: ntp