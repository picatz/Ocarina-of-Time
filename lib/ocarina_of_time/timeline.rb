module OcarinaOfTime

  # Respresent the logic of a Timeline. 
  # @author Kent 'picat' Gruber 
  class Timeline
    # Access events.
    attr_accessor :events

    # Create a new **Timeline** object.
    #
    # @param [Hash] args arguments for method
    # @option args [Time] :begin beginning point in time (default: +Time.now+)
    # @option args [Time] :end ending point in time (default: false)
    # @return [void]
    def initialize(args={})
      if args[:flex]
        @flex      = true
      else
        @flex      = false # have a rigid timeline
        @beginning = args[:begin] || Time.now
        @ending    = args[:end]   || false
      end
      @events    = Events.new
    end

    # Either get the beinning of the timline or set it.
    def beginning(set=false)
      if set
        @beginning = set unless @flex
      else
        if @flex
          @events.by(newest: true).first
        else
          @beginning
        end
      end
    end

    # Either get the ending of the timline or set it.
    def ending(set=false)
      if set
        @ending = set unless @flex
      else
        if @flex
          @events.by(oldest: true).first
        else
          @ending
        end
      end
    end

    # Turn on a flexible timeline, where events will change the potential
    # range of the timeline. If a beginning is set, an unflexible timeline
    # will not allow any new events to be set before that time. A flexible timeline
    # would set the newest ending if the event is before the current one. The same logic
    # applies to an ending time which may or may not be set. Meaning, an unflexible timeline
    # makes it very easy to grow ( by moving forward in time ) if there is no ending set.
    def flex(on = true)
      on ? @flex = true : @flex = false
    end

    # Yolo swag, lets just turn the flex on.
    #
    # @return[void] 
    def flex!
      @flex = true
    end

    # Check if the Timeline is flexible or not.
    #
    # @return[Boolean] 
    def flex?
      @flex ? true : false
    end

    # Check if there's currently a end of time
    # associated with the timeline object.
    # 
    # @return[Boolean] 
    def ending?
      if @flex
        if @events.data.all.empty?
          false
        else
          true
        end 
      else
        @ending ? true : false
      end
    end

    # Check if there's currently a beginning of time
    # associated with the timeline object.
    # 
    # @return[Boolean] 
    def beginning?
      if @flex 
        if @events.data.all.empty?
          false
        else
          true
        end
      else
        @beginning ? true : false
      end
    end

    # Get the difference in time between +two+ points in +time+.
    # 
    # @param [Hash] args arguments for method
    # @option args [Time] :begin beginning point in time
    # @option args [Time] :end ending point in time
    # @option args [Time] :seconds get difference in seconds ( default )
    # @option args [Time] :minutes get difference in minutes 
    # @option args [Time] :hours get difference in hours 
    # @option args [Time] :days get difference in days 
    # @option args [Time] :weeks get difference in weeks 
    # @option args [Time] :years get difference in years 
    # @option args [Time] :decades get difference in decades 
    # @option args [Time] :centuries get difference in centuries 
    # @return [Float] the difference between two points
    # 
    # == Example
    #  # generate new timeline
    #  timeline = OcarinaOfTime::Line.new
    #  # get days between two times
    #  timeline.time_between(end: Time.now+87654, days: true)
    #  # => 1.0150320438273612
    #  timeline.time_between(end: Time.now+8070654, days: true)
    #  # => 93.41134454091606
    #  timeline.time_between(end: Time.now+8070654, weeks: true)
    #  # => 13.344522046096547
    # 
    # == Example
    #  # generate new time line
    #  time_line = OcarinaOfTime::Line.new
    #  # set end of time ( default is Time.now for beginning )
    #  time_line.end_of_time = Time.now+8070654
    #  # get time between the two points in minutes
    #  time_line.time_between(minutes: true)
    #  # => 134511.16985055877
    #  
    def time_between(args={})
      if args[:begin].is_a? Event
        start = args[:begin].time
      else
        start = args[:begin] || @beginning
      end
      raise "unable to determine first (begin) point" unless start
      if args[:end]
        if args[:end].is_a? Event
          stop = args[:end].time
        else
          stop = args[:end]
        end
      else
        stop = @ending if @ending
        raise "unable to determine second (end) point" unless stop
      end
      diff = stop - start
      if args[:seconds]
        return diff
      elsif args[:minutes]
        return diff / 60
      elsif args[:hours]
        return diff / 3600
      elsif args[:days]
        return diff / 86400
      elsif args[:weeks]
        return diff / 604800
      elsif args[:years]
        return diff / 31449600
      elsif args[:decades]
        return diff / 314496000 
      elsif args[:centuries]
        return diff / 3144960000 
      else
        return diff
      end
    end

    # Get the days between +two+ points in +time+.
    #
    # @param [Hash] args arguments for method
    # @option args [Time] :begin beginning point in time
    # @option args [Time] :end ending point in time
    # @return [Array<Date>] dates between two points in time
    # 
    # == Example
    #  # generate new time line
    #  time_line = OcarinaOfTime::Line.new
    #  # get days between two times
    #  time_line.days_between(begin: Time.now - 100000, end: Time.now)
    #  # => [#<Date: 2017-02-19 ((2457804j,0s,0n),+0s,2299161j)>, #<Date: 2017-02-20 ((2457805j,0s,0n),+0s,2299161j)>] 
    def days_between(args={})
      start = args[:begin] || @beginning
      if args[:end]
        stop = args[:end]
      else
        stop = @ending if @ending
      end
      (start.to_date..stop.to_date).to_a
    end

    # Parse an array of dates to filter out for specifc days
    # of the week ( Monday .. Sunday ).
    #
    # @param [Hash] arguments for method
    # @option args [Array<Date>] :days array of dates to work with
    # @option args [Boolean] :mondays get mondays
    # @option args [Boolean] :tuesdays get tuesdays
    # @option args [Boolean] :wednesdays get wednesdays
    # @option args [Boolean] :thursdays get thursdays
    # @option args [Boolean] :fridays get fridays 
    # @option args [Boolean] :saturdays get saturdays 
    # @option args [Boolean] :sundays get sundays 
    # @option args [Array<Int>] :years get years
    # @option args [Array<Int>] :months get months, represented as an int 
    # @return [Array<Date>] parsed dates 
    # 
    # == Example
    #  # generate new time line
    #  time_line = OcarinaOfTime::Line.new
    #  # get days between two times
    #  days = time_line.days_between(begin: Time.now - 10000000, end: Time.now)
    #  # parse days for mondays only
    #  time_line.find_days(days: days, mondays: true)
    #  # parse days for sundays only
    #  time_line.find_days(days: days, sundays: true)
    #  # parse days for wednesdays and fridays only
    #  time_line.find_days(days: days, wednesdays: true, fridays: true)
    def find_days(args={})
      unless args[:days]
        if @ending and @beginning
          all_days = days_between 
        else
          raise "need to specify days to work with"
        end
      else
        all_days = args[:days]
      end
      days = Set.new
      all_days.each do |day|
        days << day if day.monday?    and args[:mondays]
        days << day if day.tuesday?   and args[:tuesdays]
        days << day if day.wednesday? and args[:wednesdays]
        days << day if day.thursday?  and args[:thursdays]
        days << day if day.friday?    and args[:fridays]
        days << day if day.saturday?  and args[:saturdays]
        days << day if day.sunday?    and args[:sundays]
      end
      days.to_a
    end

    # Parse an array of dates to filter out for specifc dates
    # that match a specific yeay ( 1970, 1994, 2017 .. ect ).
    #
    # @param [Hash] arguments for method
    # @option args [Array<Date>] :days array of dates to work with
    # @option args [Array, Integer] :years get specific years 
    # @return [Array<Date>] parsed years 
    # 
    # == Example
    #  # generate new time line
    #  time_line = OcarinaOfTime::Line.new
    #  time_line.end_of_time = Time.now+8070654
    #  # parse days for the year 2017 
    #  time_line.find_years(years: 2017)
    #  # parse days for the year 2016 or 2017 
    #  time_line.find_years(years: [2016, 2017])
    def find_years(args={})
      unless args[:days]
        if @ending and @beginning
          all_days = days_between 
        else
          raise "need to specify days to work with"
        end
      else
        all_days = args[:days]
      end
      days = Set.new
      all_days.each do |day|
        if args[:years]
          if args[:years].is_a? Array
            days << day if args[:years].include? day.year 
          elsif args[:years].is_a? Integer
            days << day if args[:years] == day.year 
          end
        end
      end
      days.to_a
    end
  end
end
