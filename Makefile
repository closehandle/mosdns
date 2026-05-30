all: build

build:
	bash mosdns-rules.sh
	docker builder build -t closehandle/mosdns:latest --network host .

clean:
	rm -f *.list

release: build
	docker push closehandle/mosdns:latest
