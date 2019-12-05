PROTOCOL=http
HOST=localhost
PORT=4000
PATH_ROOT=/api/todos
URL="${PROTOCOL}://${HOST}:${PORT}${PATH_ROOT}"

.PHONY: get
get:
	curl -i -H "Accept: application/json" ${URL}

.PHONY: setup
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

.PHONY: heroku
heroku:
	-git commit . -m 'deployin'
	git push heroku master
	heroku run mix ecto.migrate
	
.PHONY: spec
spec:
	open http://todobackend.com/specs/index.html?https://todobackend-phoenix-postgres.herokuapp.com/api/todos