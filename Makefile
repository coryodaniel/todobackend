PROTOCOL=http
HOST=localhost
PORT=4000
PATH_ROOT=/api/todos
URL="${PROTOCOL}://${HOST}:${PORT}${PATH_ROOT}"

.PHONY: get
get:
	curl -i -H "Accept: application/json" ${URL}

setup:
	@-docker stop postgres
	@-docker rm postgres
	docker-compose up -d
	mix deps.get
	cd assets && npm install
	mix ecto.create
	mix ecto.migrate
	mix test
	mix phx.server

heroku:
	git push heroku master
	heroku run mix ecto.create
	heroku run mix ecto.migrate