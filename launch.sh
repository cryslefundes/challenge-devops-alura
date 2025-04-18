#!/bin/bash

PORT=8000

export DJANGO_SUPERUSER_USERNAME=admin
export DJANGO_SUPERUSER_EMAIL=admin@alura.com
export DJANGO_SUPERUSER_PASSWORD=123456789

cd src

# Realiza as migrações de banco de dados
python manage.py migrate

# Cria um usuário
python manage.py createsuperuser --noinput

# Inicia o servidor
python manage.py runserver 0.0.0.0:$PORT