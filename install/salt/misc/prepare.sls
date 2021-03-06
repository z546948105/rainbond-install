/usr/local/bin/calicoctl:
  file.managed:
    - source: salt://misc/file/bin/calicoctl
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/calicoctl

/usr/local/bin/docker-compose:
  file.managed:
    - source: salt://misc/file/bin/docker-compose
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/docker-compose

{% if "manage" in grains['id'] %}
/usr/local/bin/etcdctl:
  file.managed:
    - source: salt://misc/file/bin/etcdctl
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/etcdctl

/usr/local/bin/grctl:
  file.managed:
    - source: salt://misc/file/bin/grctl
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/grctl

/usr/local/bin/kubectl:
  file.managed:
    - source: salt://misc/file/bin/kubectl
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/kubectl

kube-ssl-rsync:
  file.recurse:
    - source: salt://kubernetes/server/install/ssl
    - name: {{ pillar['rbd-path'] }}/etc/kubernetes/ssl

kube-cfg-rsync:
  file.recurse:
    - source: salt://kubernetes/server/install/kubecfg
    - name: {{ pillar['rbd-path'] }}/etc/kubernetes/kubecfg 

{% if grains['id'] == "manage01"  %}
/usr/local/bin/domain-cli:
  file.managed:
    - source: salt://misc/file/bin/domain-cli
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/domain-cli
{% endif %}
{% endif %}

{% if "compute" in grains['id'] %}
/usr/local/bin/kubelet:
  file.managed:
    - source: salt://misc/file/bin/kubelet
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/kubelet
{% endif %}

/usr/local/bin/node:
  file.managed:
    - source: salt://misc/file/bin/node
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/node

/usr/local/bin/ctop:
  file.managed:
    - source: salt://misc/file/bin/ctop
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/ctop

/usr/local/bin/yq:
  file.managed:
    - source: salt://misc/file/bin/yq
    - mode: 755
    - user: root
    - group: root
    - unless: test -f /usr/local/bin/yq

{% if "manage" in grains['id'] %}
{% if pillar.domain is defined %}
compose_base_file:
  file.managed:
     - source: salt://misc/files/base.yaml
     - name: {{ pillar['rbd-path'] }}/compose/base.yaml
     - makedirs: True
     - template: jinja
compose_lb_file:
  file.managed:
     - source: salt://misc/files/lb.yaml
     - name: {{ pillar['rbd-path'] }}/compose/lb.yaml
     - makedirs: True
     - template: jinja
compose_ui_file:
  file.managed:
     - source: salt://misc/files/ui.yaml
     - name: {{ pillar['rbd-path'] }}/compose/ui.yaml
     - makedirs: True
     - template: jinja
compose_plugin_file:
  file.managed:
     - source: salt://misc/files/plugin.yaml
     - name: {{ pillar['rbd-path'] }}/compose/plugin.yaml
     - makedirs: True
     - template: jinja
{% endif %}
{% endif %}