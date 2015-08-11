datadog-zookeeper:
  cmd.run:
    - name: cp /etc/dd-agent/conf.d/zk.yaml.example /etc/dd-agent/conf.d/zk.yaml
    - onlyif: test ! -f /etc/dd-agent/conf.d/zk.yaml -a -f /etc/dd-agent/conf.d/zk.yaml.example
    - require:
      - pkg: datadog-pkg

datadog-zookeeper-restart:
  cmd.wait:
    - name: /etc/init.d/datadog-agent restart
    - watch:
      - cmd: datadog-zookeeper