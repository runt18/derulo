.PHONY: test install compile clean

BIN=./node_modules/.bin

install:
	npm install

test:
	$(BIN)/mocha

compile:
	$(BIN)/coffee -c -o lib/ src/

clean:
	rm -rf lib

run:
	$(BIN)/coffee src/index.coffee
