datadog-redis:
  cmd.run:
    - name: cp /etc/dd-agent/conf.d/redisdb.yaml.example /etc/dd-agent/conf.d/redis.yaml
    - onlyif: test ! -f /etc/dd-agent/conf.d/redis.yaml -a -f /etc/dd-agent/conf.d/redisdb.yaml.example
    - require:
      - pkg: datadog-pkg

datadog-redis-restart:
  cmd.wait:
    - name: /etc/init.d/datadog-agent restart
    - watch:
      - cmd: datadog-redis