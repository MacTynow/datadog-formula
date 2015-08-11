/etc/dd-agent/conf.d/marathon.yaml:
  file.managed:
    - source: salt://datadog/marathon/files/marathon.yaml
    - user: dd-agent
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        url: 'localhost'
        port: '8080'

datadog-marathon-restart:
  cmd.wait:
    - name: /etc/init.d/datadog-agent restart
    - watch:
      - file: /etc/dd-agent/conf.d/marathon.yaml
