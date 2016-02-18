# Install repositories

# Install nginx repo
nginx-repo:
  pkgrepo.managed:
    - ppa: nginx/development
  pkg.latest:
    - name: nginx
    - refresh: True
