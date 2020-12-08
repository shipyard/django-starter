VOLUME=$(shell basename $(PWD))

develop: clean build migrations.all run

clean:
	docker-compose rm -vf

build:
	docker-compose build

run:
	docker-compose up

shell:
	docker-compose run django \
	  sh

python-shell:
	docker-compose run django \
	  poetry run python src/manage.py shell

postgres.data.delete: clean
	docker volume rm $(VOLUME)_postgres

postgres.start:
	docker-compose up -d postgres
	docker-compose exec postgres \
	  sh -c 'while ! nc -z postgres 5432; do sleep 0.1; done'

postgres-shell: postgres.start
	docker exec -it $(VOLUME)_postgres_1 sh

migrations.all: postgres.start
	docker-compose run django \
	  poetry run python src/manage.py migrate