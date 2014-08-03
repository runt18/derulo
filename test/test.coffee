chai = require 'chai'

chai.should()

util = require '../src/util.coffee'

describe 'pretty', ->
  it 'should correctly format an object', ->
    expected = """
      {
        "a": 1
      }
    """

    util.pretty({a: 1}).should.equal(expected)

describe 'normalise', ->
  it 'should not affect filenames with extensions', ->
    util.normalise('test.json').should.equal('test.json')

  it 'should add an extension to a filename without one', ->
    util.normalise('test').should.equal('test.json')

  it 'should allow custom extensions', ->
    util.normalise('test', '.yml').should.equal('test.yml')

describe 'valueise', ->
  it 'should convert booleans', ->
    util.valueise('true').should.equal(true)
    util.valueise('false').should.equal(false)

  it 'should convert numbers', ->
    util.valueise('1').should.equal(1)
    util.valueise('-1').should.equal(-1)

  # it 'should convert null', ->
  #   should.not.exist(util.valueise('null'))

  it 'should not affect other strings', ->
    util.valueise('foo').should.equal('foo')
