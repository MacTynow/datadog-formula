datadog-repo:
  pkgrepo:
    - managed
    - humanname: "Datadog Agent"
    {% if grains['os'].lower() in ('ubuntu', 'debian') %}
    - name: deb http://apt.datadoghq.com/ stable main
    - keyserver: keyserver.ubuntu.com
    - keyid: C7A7DA52
    - file: /etc/apt/sources.list.d/datadog.list
    {% elif grains['os'].lower() == 'redhat' %}
    - name: Datadog, Inc.
    - baseurl: http://yum.datadoghq.com/rpm/x86_64
    {% endif %}
 
datadog-pkg:
  pkg.latest:
    - name: datadog-agent
    - require:
      - pkgrepo: datadog-repo
 
datadog-example:
  cmd.run:
    - name: cp /etc/dd-agent/datadog.conf.example /etc/dd-agent/datadog.conf
    # copy just if datadog.conf does not exists yet and the .example exists
    - onlyif: test ! -f /etc/dd-agent/datadog.conf -a -f /etc/dd-agent/datadog.conf.example
    - require:
      - pkg: datadog-pkg
 
datadog-conf:
  file.replace:
    - name: /etc/dd-agent/datadog.conf
    - pattern: "api_key:(.*)"
    - repl: "api_key: {{ pillar['datadog']['api_key'] }}"
    - count: 1
    - watch:
      - pkg: datadog-pkg
    - require:
      - cmd: datadog-example
 
datadog-agent-service:
  service.running:
    - name: datadog-agent
    - reload: True
    - enable: True
    - watch:
      - pkg: datadog-agent
