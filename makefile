.PHONY: test install

install:
	npm install

test:
	./node_modules/.bin/mocha
