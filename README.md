# Tracker

Naive implementation of [Meteor Tracker](https://github.com/meteor/meteor/wiki/Tracker-Manual)

Used to keep track of variables values, and automaticaly execute code when a value change.

## Quick Start

Will successively print 'test' and 'test2':

```coffee-script
Tracker = require 'tracker'

value = new Tracker.Value 'test'

Tracker.Autorun ->
  console.log value()

value 'test2'
```

Will successively print 'One Two' and 'One Three' :

```coffee-script
Tracker = require 'tracker'

value = new Tracker.Value 'One'

value2 = new Tracker.Value 'Two'

Tracker.Autorun ->
  console.log value() + ' ' + value2()

value2 'Three'
```

Will successively print 'test' and 'test2' :

```coffee-script
Tracker = require 'tracker'

value2 = new Tracker.Value 'test'

value = new Tracker.Value ->
  value2()

Tracker.Autorun ->
  console.log value()

value2 'test2'
```

## Limits

When multiples Autorun functions run simultaneously, dependencies may not be
correctly guessed cause of the global bus event 'depends', catched by every Computations

## TODO

 - Jail the Computation Record methods to avoir Dependencies collisions
 - Provide methods to stop watching

## Changelog

 - Simplified syntax for Value. Now useable directly as function taking no parameter for Get and taking one for Set
