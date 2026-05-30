all: build

build:
	docker builder build -t closehandle/mosdns:latest --network host .

release: build
	docker push closehandle/mosdns:latest
