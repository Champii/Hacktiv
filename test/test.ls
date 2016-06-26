assert = require \assert
test = it

Hacktiv = require \..

describe \Hacktiv ->

  # before (done) ->
  #   done!

  test 'should be watching', (done) ->
    assert.equal Hacktiv.active, false
    Hacktiv ->
      assert.equal Hacktiv.active, true

    assert.equal Hacktiv.active, false
    done!

  test 'should return computation', (done) ->
    handler = Hacktiv ->

    if not handler.Stop?
      throw new Error 'No handler'

    done!

  test 'should stop computation', (done) ->
    times = 0
    v = new Hacktiv.Value 0
    handler = Hacktiv ->
      console.log 'LOL' times, v!
      if times isnt v!
        throw new Error "Should have changed value : expected #{times} but was #{v!}"
      times++
      if times >= 2
        done!
      v!

    v 1

    handler.Stop!

    v 2
    v 3


  test 'should watch neasted 1', (done) ->
    v1 = new Hacktiv.Value 0
    v2 = new Hacktiv.Value 0
    handler2 = null
    count = 0
    handler1 = Hacktiv ->
      v1!

      handler2 := Hacktiv ->
        v2!
        count++

        if count >= 3
          done!

    v1 1
    v2 2

  test 'should watch neasted 2', (done) ->
    v1 = new Hacktiv.Value 0
    v2 = new Hacktiv.Value 0
    handler2 = null
    count = 0
    handler1 = Hacktiv ->
      v1!

      count++
      if count >= 2
        done!

      handler2 := Hacktiv ->
        v2!

    v1 1
    v2 2
