# Ocarina of Time
![Alt Text](http://i.imgur.com/213eY1X.png)

Play this song near a blue Time Block.

```
------------------------------------------------
-( > )---------( > )----------------------------
----------( v )-----------( > )-----------------
-----( A )-----------( A )----------------------
```

## Installation

    $ gem install ocarina_of_time

## Usage

I'm still sort of fleshing out some things. So, I'll update thing as they change.

```ruby
require 'ocarina_of_time'

timeline = OcarinaOfTime::Timeline.new

# beginning of time
timeline.beginning
# => 2017-02-21 10:10:16 -0500
# check for beginning of time
timeline.beginning?

timeline.ending
# => false
timeline.ending?
# => false
# set end of time
timeline.ending(Time.now)
timeline.ending?
# => true
timeline.ending
# => 2017-02-21 10:15:45 -0500

# or, just make it flexible
timeline.flex!

```

## Timeline
A timeline is a way of displaying a list of events in chronological order, sometimes described as a project artifact ( an event ). Timelines can use any time scale, depending on the subject and data. Most timelines use a linear scale, where a unit of distance is equal to a set amount of time. Or, well, at least that is what Wikipedia says.

### The Short and Simple

A timeline has a beginning ( sometimes ) and an ending ( sometimes ). You can have a flexible timeline where, as events are added, the beginning and ending points in time will be determined by the actual events themselve.
 
```ruby
# will return a unique id number for the timeline event
timeline.events.add(label: "Example 1")
# => "e41fdc5c-6a8d-4d85-addb-27b6f81666e9"

# you can remove a timeline event by id number
timeline.events.delete(id: "e41fdc5c-6a8d-4d85-addb-27b6f81666e9")
# => true

# or you can remove a timeline event by time, if
# it exists -- maybe it's already been deleted ;)
timeline.events.delete(id: "e41fdc5c-6a8d-4d85-addb-27b6f81666e9")
# => false
```

## Events
Timelines events are stored in an events class which acts as a nice wrapped to our timeline Event objects.

```ruby
# create new timeline
timeline = OcarinaOfTime::Line.new

# adding events is very straightforward
timeline.events.add(label: "Example 1")
# => OcarinaOfTime::Event:0x00000001fcd040.id
timeline.events.add(label: "Example 2")
# => OcarinaOfTime::Event:0x00000001cabce0.id

# you can easily update events
timeline.events.update(id: "2f6716b1-9a2f-46d2-8bcf-4db0212032f1", value: 1)

# you can easily delete events
timelines.events.delete(id: "2f6716b1-9a2f-46d2-8bcf-4db0212032f1")

# there's a nice little wrapped to sort_by
timeline.events.by(oldest: true)
# => OcarinaOfTime::Event:0x00000001cabce0, OcarinaOfTime::Event:0x00000001fcd040
timeline.events.by(newest: true)
# => OcarinaOfTime::Event:0x00000001fcd040, OcarinaOfTime::Event:0x00000001cabce0

# you can also find events based on different attributes
timeline.events.find(label: "Example 1")
timeline.events.find(labels: ["Example 1", "Example 2"])
timeline.events.find(event: timeline.events.all.first)
timeline.events.find(date: Time.now.to_date)

# you can also chain your find queries ( one option at a time )
timeline.events.find(date: Time.now.to_date).find(label: "Example 1")

# you can get a shortcut to all of the uniqe dates for each event
timeline.events.dates
# or a shortcut to all of the unique times for each event
timeline.events.times
# or you can get all of the unique labels
timelines.events.labels
# or you can get all of the unique ids
timelines.events.ids
# or you can get all of the unique tags
timelines.events.tags

# or if you don't want unique whatever, turn that off
timelines.events.tags(unique: false)
timelines.events.times(unique: false)
```

## Event
Timeline Events are made up of serveral Event objects. An event object is made up of its unique ID number,
its label, its tags ( as a set, unique ), the time of the event ( default to its creation time ), the time
the event was created ( defaults to its creation time ) and a value -- which can be whatever you like, if you
want to use that ( instead of just stuffing that data in tags ).

```ruby
# create a new timeline event
event = OcarinaOfTime::Event.new

# accessing event data ( reading ) with data shortcuts
event.label
# => false

# accessing event data ( to change )
event.data.label = "Example 1"

event.label
# => "Example 1" 

# check for tags
event.tags?
# => false

# add tags as an array or string
tags = ["Cool", "Sick", "Awesome"]
tag  = "Gnarly"
event.add_tags(tags)
event.add_tags(tag)

# check for tags again
event.tags?
# => true

# check out tags data
event.tags
# => Set: {"Cool", "Sick", "Awesome", "Gnarly"}

# add the same event to two different timelines
timeline1 = OcarinaOfTime::Line.new 
timeline2 = OcarinaOfTime::Line.new 
timeline1.events.add(event: event)
# => "bb2aa0a0-68ee-469c-808b-875c7494a3c4"
timeline2.events.add(event: event)
# => "bb2aa0a0-68ee-469c-808b-875c7494a3c4"
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

