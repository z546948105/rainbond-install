create_host_id_list:
  file.managed:
    - source: salt://init/files/host_id_list.conf
    - name: {{ pillar['rbd-path'] }}/etc/rbd-api/host_id_list.conf
    - makedirs: True
    - template: jinja