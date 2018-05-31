{% if pillar.etcd.server.enabled %}
{% set ETCDIMG = salt['pillar.get']('etcd:server:image') -%}
{% set ETCDVER = salt['pillar.get']('etcd:server:version') -%}
pull-etcd-image:
  cmd.run:
    - name: docker pull {{ ETCDIMG }}:{{ ETCDVER }}
    - unless: docker inspect {{ ETCDIMG }}:{{ ETCDVER }}

etcd-tag:
  cmd.run:
    - name: docker tag rainbond/etcd:v3.2.13 goodrain.me/etcd:v3.2.13
    - unless: docker inspect goodrain.me/etcd:v3.2.13
    - require:
      - cmd: pull-etcd-image

etcd-env:
  file.managed:
    - source: salt://etcd/install/envs/etcd.sh
    - name: {{ pillar['rbd-path'] }}/envs/etcd.sh
    - template: jinja
    - makedirs: True
    - mode: 644
    - user: root
    - group: root

etcd-script:
  file.managed:
    - source: salt://etcd/install/scripts/start-etcd.sh
    - name: {{ pillar['rbd-path'] }}/scripts/start-etcd.sh
    - makedirs: True
    - template: jinja
    - mode: 755
    - user: root
    - group: root

/etc/systemd/system/etcd.service:
  file.managed:
    - source: salt://etcd/install/systemd/etcd.service
    - template: jinja
    - user: root
    - group: root

etcd:
  service.running:
    - enable: True
    - watch:
      - file: etcd-script
      - file: etcd-env
      - cmd: pull-etcd-image
    - require:
      - file: /etc/systemd/system/etcd.service
      - file: etcd-script
      - file: etcd-env
      - cmd: pull-etcd-image
  

{% endif %}

