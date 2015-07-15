# Tracker
Naive implementation of (Meteor Tracker)[https://github.com/meteor/meteor/wiki/Tracker-Manual]

## Quick Start

Will successively print 'test' and 'test2':

```coffee-script
Tracker = require 'tracker'

value = new Tracker.Value 'test'

Tracker.Autorun ->
  console.log value.Get()

value.Set 'test2'
```

Will successively print 'One Two' and 'One Three' :

```coffee-script
Tracker = require 'tracker'

value = new Tracker.Value 'One'

value2 = new Tracker.Value 'Two'

Tracker.Autorun ->
  console.log value.Get() + ' ' + value2.Get()

value2.Set 'Three'
```

Will successively print 'test' and 'test2' :

```coffee-script
Tracker = require 'tracker'

value2 = new Tracker.Value 'test'

value = new Tracker.Value ->
  value2.Get()

Tracker.Autorun ->
  console.log value.Get()

value2.Set 'test2'
```
