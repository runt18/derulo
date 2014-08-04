# JSON Derulo

[![Build Status](https://travis-ci.org/lavelle/derulo.svg?branch=master)](https://travis-ci.org/lavelle/derulo)
[![NPM version](https://badge.fury.io/js/derulo.svg)](http://badge.fury.io/js/derulo)
![Dependency Status](https://david-dm.org/lavelle/derulo.png)

> Derulo is a tool for building and manipulating JSON files.

![Derulo Logo](https://raw.githubusercontent.com/lavelle/derulo/master/image/trumpet.png)

# Why

Hand editing JSON kinda sucks. You have to go around quoting stuff and if you forget a comma or a colon everything breaks. Derulo offers a fast way of creating and editing JSON files.

## Install

Get Node.js then run `npm i -g derulo`.

## Usage examples

For full usage instructions, see the [help text](help.txt).

### TL;DR

![Derulo video](http://fat.gfycat.com/AdmiredAngelicAmericanlobster.gif)

### Interactive

`derulo <filename>` will open up a REPL where you can add multiple key-value pairs to be written to the file. To quit the REPL, and either save or discard the object you're build, press Ctrl+C at any time. Ctrl+D will quit the whole program with no prompt, so be careful!

The REPL is not fully finished yet, so use with caution.

### Adding and editing

`derulo package name Jason` will add the pair `"name": "Jason"` to the file `package.json` in the current directory. If the file doesn't exist it will be created. If the key already exists, the value will be overwritten.

If the value is a number, boolean or `null`, it will be parsed as such. Everything else will be a string.

### Deleting

`derulo -d package name` will remove the `name` property from the file `package.json`. If no such key exists, nothing will happen.

### Fuzzy matching

If you omit the extension from the filename, `.json` will be appended automatically (or `.yml` for YAML if the `-y` flag is passed). If this doesn't match either, a fuzzy search will be performed, finding the closest matching file. Therefore, `pack`, `package` and `package.json` are equivalent when running in this repository.

### Indentation

Derulo will attempt to auto-detect and preserve indentation on files. If this fails, it will fall back to 2-space indentation.

## Planned features

- Support for nested structures - arrays and objects.
- Support for editing YAML too.

## Contributing

New features and bug reports/fixes are very welcome. Try and be consistent with existing style and all that.

## License

MIT
