zabbix24-agent:
    pkg.installed: []

/usr/local/etc/zabbix24/zabbix_agentd.conf:
    file.managed:
        - source: salt://zabbix/etc/zabbix_agentd.conf
        - user: root
        - group: wheel
        - mode: 444
        - template: jinja
        - defaults:
            server: {{ salt['pillar.get']('zabbix:server', '127.0.0.1') }}
        - watch_in:
            - service: zabbix_agentd 

zabbix_agentd:
    service.running:
        - enable: True
