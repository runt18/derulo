# JSON Derulo

> Derulo is a tool for building and manipulating JSON files.

Hand editing JSON kinda sucks. You have to go around quoting stuff and if you forget a comma or a colon everything breaks. Derulo offers a fast way of creating and editing JSON files.

## Install

Get Node.js then run `npm i -g derulo`.

## Usage

### Adding and editing

`derulo package name Jason` will add the pair `"name": "Jason"` to the file `package.json` in the current directory. If the file doesn't exist it will be created. If the key already exists, the value will be overwritten.

If the value is a number, boolean or `null`, it will be parsed as such. Everything else will be a string.

### Deleting

`derulo -d package name` will remove the `name` property from the file `package.json`. If no such key exists, nothing will happen.

## License

MIT
