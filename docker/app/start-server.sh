#!/bin/bash

cd /home/app
pipenv install
cd project

if [ "${DJANGO_ENV}" = 'production' ]; then
    pipenv run python manage.py migrate --settings config.settings
    pipenv run python manage.py collectstatic --noinput
    pipenv run gunicorn config.wsgi:application -c /home/docker/etc/gunicorn.conf -b :8080
else
    pipenv run python manage.py migrate
    pipenv run python manage.py runserver 0.0.0.0:8000
fi
