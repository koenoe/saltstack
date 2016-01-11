# environment
{% if salt['cmd.run']('hostname') == 'vagrant-ubuntu-trusty-64' %}
environment: development
{% else %}
environment: production
{% endif %}

# hostname
hostname: {{ salt['cmd.run']('hostname') }}
