include:
    - uwsgi

Flask:
    pip.installed:
        - user: pyapp
        - cwd: /home/pyapp
        - bin_env: /home/pyapp/.venv
        - watch_in: 
            - service: uwsgi
        - watch:
            - file: /home/pyapp/app/main.py
        - require:
            - virtualenv: /home/pyapp/.venv
        - env_vars:
             HOME: /home/pyapp

/home/pyapp/app/main.py:
     file.managed:
         - user: pyapp
         - group: pyapp
         - mode: 644
         - source: salt://flask/app/main.py
         - replace: False
         - require: 
              - file: /home/pyapp/app
         - watch_in:
              - service: uwsgi
