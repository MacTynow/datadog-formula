datadog-docker:
  user.present:
    - name: dd-agent
    - groups:
      - docker
      - nogroup
  cmd.run:
    - name: cp /etc/dd-agent/conf.d/docker.yaml.example /etc/dd-agent/conf.d/docker.yaml
    - onlyif: test ! -f /etc/dd-agent/conf.d/docker.yaml -a -f /etc/dd-agent/conf.d/docker.yaml.example
    - require:
      - pkg: datadog-pkg

datadog-agent-service:
  service.running:
    - name: datadog-agent
    - reload: True
    - enable: True
