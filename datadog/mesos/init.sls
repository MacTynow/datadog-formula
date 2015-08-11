datadog-mesos:
  file.managed:
    - source: salt://datadog/mesos/files/mesos.yaml
    - user: dd-agent
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      - url: 'localhost'

datadog-agent-service:
  service.running:
    - name: datadog-agent
    - reload: True
    - enable: True