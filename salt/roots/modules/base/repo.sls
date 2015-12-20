# Install repositories

# Install nginx repo
nginx-repo:
  pkgrepo.managed:
    - ppa: nginx/stable
  pkg.latest:
    - name: nginx
    - refresh: True
