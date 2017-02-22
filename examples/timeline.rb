$: << File.expand_path("../../lib", __FILE__)
require "ocarina_of_time"
require "pry"

# create timeline
timeline = OcarinaOfTime::Timeline.new

# flexible timeline
timeline.flex!

# add events ( roughly =~ 2 seconds from eachother )
["Example 1", "Example 2", "Example 3"].each do |example|
  sleep 2
  timeline.events.add(label: example, time: Time.now)
end

# check flexbility
timeline.flex?
# => true

# Some quick examples ( not everything )

timeline.events.times
# => [2017-02-21 20:43:11 -0500, 2017-02-21 20:43:13 -0500, 2017-02-21 20:43:15 -0500]

timeline.events.ids
# => ["69ba109e-15cb-44cc-b541-042cc1cdaf82", "5e4dc4ff-c263-4365-ab3a-c37b2c11af66", "11801833-ba11-47c8-aef1-b1d621e461dd"]

timeline.events.dates
# => [#<Date: 2017-02-21 ((2457806j,0s,0n),+0s,2299161j)>]

timeline.events
# => #<OcarinaOfTime::Events:0x007f8fe847d590
# @all=
#  [#<OcarinaOfTime::Event:0x007f8fe847d428
#    @data=
#     #<struct Struct::EventData
#      id="69ba109e-15cb-44cc-b541-042cc1cdaf82",
#      label="Example 1",
#      tags=#<Set: {}>,
#      time=2017-02-21 20:43:11 -0500,
#      created=2017-02-21 20:43:11 -0500,
#      value=false>>,
#   #<OcarinaOfTime::Event:0x007f8fe847d040
#    @data=
#     #<struct Struct::EventData
#      id="5e4dc4ff-c263-4365-ab3a-c37b2c11af66",
#      label="Example 2",
#      tags=#<Set: {}>,
#      time=2017-02-21 20:43:13 -0500,
#      created=2017-02-21 20:43:13 -0500,
#      value=false>>,
#   #<OcarinaOfTime::Event:0x007f8fe847cd98
#    @data=
#     #<struct Struct::EventData
#      id="11801833-ba11-47c8-aef1-b1d621e461dd",
#      label="Example 3",
#      tags=#<Set: {}>,
#      time=2017-02-21 20:43:15 -0500,
#      created=2017-02-21 20:43:15 -0500,
#      value=false>>]>

