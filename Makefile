build:
	docker build --tag tarantool-replication .

compose: build
	docker compose up
