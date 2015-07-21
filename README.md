# Hacktiv

Implementation of the Functional reactive programming (FRP) paradigm, using reactive values. (Naive implementation of [Meteor Tracker](https://github.com/meteor/meteor/wiki/Tracker-Manual))

Used to keep track of variable values, and automaticaly execute code when a value change.

It automaticaly guess data dependencies, and when one of them change, every Hacktiv
functions that depends on this data are retriggered to take consideration of the new values.

## Install

```bash
$> npm install hacktiv
```

## Quick Start

Will successively print 'test' and 'test2':

```coffee-script
Hacktiv = require 'hacktiv'

# Get a new reactive value
value = new Hacktiv.Value 'test'

# The Hacktiv function will keep track of reactive values,
# re-executing the function if any of the values or any
# of their dependencies called inside have changed
Hacktiv ->

  # Calling the value without parameter returns the actual value
  console.log value()

# [...]

# Calling the value with a parameter update the underlying value and will reprint
value 'test2'
```

Will successively print 'One Two' and 'One Three' :

```coffee-script
value = new Hacktiv.Value 'One'

value2 = new Hacktiv.Value 'Two'

# Here if any of value or value2 change,
# the console.log will reprint these two values
Hacktiv ->
  console.log value() + ' ' + value2()

value2 'Three'
```

Will successively print 'test' and 'test2' :

```coffee-script
value2 = new Hacktiv.Value 'test'

# You can set reactive values as Functions or Objects.
# They can reference other values, that will cause the Hacktiv function
# to rerun if any of them change
value = new Hacktiv.Value ->
  value2()

Hacktiv ->
  console.log value()

value2 'test2'
```

## Status

You can check if you are in a watching context with `Hacktiv.active` booleen

```coffee-script
console.log Hacktiv.active    #false

Hacktiv ->
  console.log Hacktiv.active  #true

console.log Hacktiv.active    #false
```

## Stop watching

To stop watching, just get the handler back from your `Hacktiv` function
and call its `Stop()` function

```coffee-script
value = new Hacktiv.Value 1

handler = Hacktiv ->
  console.log value()

value2 'test2'

handler.Stop()

# This call will not refresh the function
value2 'test3'
```

You can temporarily stop watching with Hacktiv.DontWatch() :

```coffee-script
Hacktiv ->

  Hacktiv.DontWatch ->
    # Here values are not monitored


```

## Playing with the Dependency object

Will successively print [], ['test1'] and ['test1', 'test2'] :

```coffee-script
Hacktiv = require 'hacktiv'

class List extends Hacktiv.Dependency

  tasks: []

  AddTask: (task) ->
    @tasks.push task
    @_Changed()

  Send: ->
    @_Depends()
    @tasks

list = new List

Hacktiv ->

  # Replace this with a websocket or a stream
  console.log list.Send()

list.AddTask 'test1'
list.AddTask 'test2'

```

## Limits

When multiples Hacktiv functions run simultaneously, dependencies may not be
correctly guessed cause of the global bus event 'depends', catched by every Computations

## API

#### Hacktiv

The Hacktiv is the main function, taking track of every computations.

- Hacktiv(function)
  - Add a new Computation with the given function

#### Computation

- constructor(function)
  - Start recording, Run the function, Stop recording.

- StartRecord()
  - Keep track of every Dependencies that run their _Depends() call

- StopRecord()
  - Stop recording for Dependencies

#### Dependency

- constructor()
  - Set the unique id for the dependency

- _Depends()
  - Send a global event to tell current recording Computation that a value has been accessed.

- _Changed()
  - Send a localised event to each Computations that
  have catched the Dependency that a value has changed.


#### Value

Is a function that take one argument.

- With argument: Setter
- Without argument: Getter

## TODO

 - Jail the Computation Record methods to avoir Dependencies collisions
 - Provide methods to stop watching

## Changelog

 - Simplified syntax for Value. Now useable directly as function taking no parameter for Get and taking one for Set
