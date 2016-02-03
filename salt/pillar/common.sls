# environment
{% if salt['cmd.run']('hostname') == 'vagrant-ubuntu-trusty-64' %}
environment: development
{% else %}
environment: production
{% endif %}

# hostname
hostname: {{ salt['cmd.run']('hostname') }}

# full hostname
hostname.full: {{ salt['cmd.run']('hostname -f') }}
