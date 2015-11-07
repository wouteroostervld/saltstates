include:
    - nginx

/usr/local/etc/nginx/nginx.conf:
    file.managed:
        - source: salt://uwsgi/etc/nginx/nginx.conf
        - user: root
        - group: wheel
        - mode: 444
        - watch_in:
            - service: nginx

uwsgi:
    pkg.installed: []
    service.running:
        - enable: True
#        - reload: True
        - watch:
            - file: /etc/rc.conf.d/uwsgi
            - file: /usr/local/etc/uwsgi.ini    
            - file: /home/pyapp/app
            - virtualenv: /home/pyapp/.venv

/etc/rc.conf.d/uwsgi:
    file.managed:
        - source: salt://uwsgi/rc.conf.d/uwsgi
        - user: root
        - group: wheel
        - mode: 444

/usr/local/etc/uwsgi.ini:
    file.managed:
        - source: salt://uwsgi/etc/uwsgi.ini
        - user: root
        - group: wheel
        - mode: 444

pyapp:
    user.present: []

/home/pyapp/app:
    file.directory:
        - user: pyapp
        - group: pyapp 
        - mode: 755
        - require: 
            - user: pyapp

py27-pip:
   pkg.installed: []

virtualenv:
    pip.installed:
        - upgrade: true
        - require:
            - pkg: py27-pip

/home/pyapp/.venv:
    virtualenv.managed:
        - user: pyapp
        - require:
            - user: pyapp
            - pip: virtualenv
