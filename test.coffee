Tracker = require './'

test3 = new Tracker.Value 3

test2 = new Tracker.Value 2

test = new Tracker.Value 1

Tracker.Autorun ->
  console.log 'test1', test.Get()
  Tracker.Autorun ->
    console.log 'test2', test2.Get()


test3.Set 'lol'
