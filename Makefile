all: build run

build:
	docker build -t ssrf-playground .

run:
	docker inspect ssrf-playground >/dev/null 2>&1 && docker rm -f ssrf-playground || true
	docker run --name ssrf-playground -p 8080:80 -d -t ssrf-playground
