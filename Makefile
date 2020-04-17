SHELL := /bin/bash
SERVICE_NAME = chaindock

DOCKER_PROD_PATH = docker-compose.prod.yml
DOCKER_TEST_PATH = docker-compose.test.yml

DOCKER_COMPOSE = docker-compose --file

URL = 5700

POSTGRES_USER = qt0GjtLJz5vaVfPBuTAuJrIB
POSTGRES_PASSWORD = Sn8d3peUDEySVIOzMcdKgWy2
POSTGRES_DB = yrseXmL3TYijdthEzXoOleDE

up: env
	$(DOCKER_COMPOSE) $(DOCKER_PROD_PATH) up

up-test:
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) up

down:
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) down --remove-orphans
	$(DOCKER_COMPOSE) $(DOCKER_PROD_PATH) down --remove-orphans

config:
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) config

clean: down
	docker volume rm chaindock_postgres
	cd postgres && rm -rf priv* server* && ./create_ssl_cert

release:
	 rsync -r . $(URL):/coinmine/$(SERVICE_NAME)

service_start:
	sudo cp services/* /etc/systemd/system
	sudo systemctl start $(SERVICE_NAME).service
	sudo systemctl enable $(SERVICE_NAME).service

service_restart:
	sudo systemctl restart $(SERVICE_NAME).service

service_reload:
	sudo systemctl daemon-reload

service_status:
	sudo systemctl status $(SERVICE_NAME).service

env:
	sed -e "s/POSTGRES_USER=.*/POSTGRES_USER=$(POSTGRES_USER)/g" .env > tmp
	mv -- tmp .env
	sed -e "s/POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=$(POSTGRES_PASSWORD)/g" .env > tmp
	mv -- tmp .env
	sed -e "s/POSTGRES_DB=.*/POSTGRES_DB=$(POSTGRES_DB)/g" .env > tmp
	mv -- tmp .env

