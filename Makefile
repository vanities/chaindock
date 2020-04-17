SERVICE_NAME = cnode

DOCKER_PROD_PATH = docker-compose.prod.yml
DOCKER_TEST_PATH = docker-compose.test.yml

DOCKER_COMPOSE = docker-compose --file

URL = 5700

up:
	$(DOCKER_COMPOSE) $(DOCKER_PROD_PATH) up

up-test:
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) up

down:
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) down
	$(DOCKER_COMPOSE) $(DOCKER_PROD_PATH) down

config:
	$(DOCKER_COMPOSE) config

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

