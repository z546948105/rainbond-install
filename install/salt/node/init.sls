include:
{% if pillar['role'] |lower == 'manage' %}
- node.manage
{% else %}
- node.compute
{% endif %}