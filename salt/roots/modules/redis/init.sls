redis-server:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: redis-server

redis-maxmemory:
  file.replace:
    - name: /etc/redis/redis.conf
    - pattern: '^# maxmemory <bytes>'
    - repl: {{ 'maxmemory %s'|format(pillar['redis.maxmemory']) }}
    - require:
      - pkg: redis-server
