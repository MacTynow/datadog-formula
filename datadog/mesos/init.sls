/etc/dd-agent/conf.d/mesos.yaml:
  file.managed:
    - source: salt://datadog/mesos/files/mesos.yaml
    - user: dd-agent
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        url: 'localhost'
        port: '5050'

datadog-mesos-restart:
  cmd.run:
    - name: /etc/init.d/datadog-agent restart
    - watch:
      - file: /etc/dd-agent/conf.d/mesos.yaml
