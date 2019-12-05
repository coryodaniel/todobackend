PROTOCOL=http
HOST=localhost
PORT=4000
PATH_ROOT=/api/todos
URL="${PROTOCOL}://${HOST}:${PORT}${PATH_ROOT}"

.PHONY: get
get:
	curl -i -H "Accept: application/json" ${URL}
