module OcarinaOfTime

  class Events
    
    attr_reader :all
      
    def initialize
      @all = [] 
    end

    def by(args={})
      results = []
      if args[:newest]
        @all.each.sort_by { |e| e.time }.each do |event|
          results << event
        end
      elsif args[:oldest]
        @all.each.sort_by { |e| e.time }.reverse.each do |event|
          results << event
        end
      else
        @all
      end
      results.empty? ? false : results
    end
  
    def add(args={})
      if args[:event]
        @all << args[:event]
        return args[:event].id
      end
      event = Event.new
      event.data.label = args[:label] || false
      event.add_tags(args[:tags]) if args[:tags]
      event.data.time = args[:time] if args[:time] 
      @all << event
      event.id
    end

    def delete(args={})
      if args[:id]
        @all.delete_if { |e| e.id == args[:id] }
      elsif args[:event]
        @all.delete_if { |e| e == args[:event] }
      else
        return false
      end
      true
    end
    
    def update(args={})
      if args[:id]
        @all.each do |event|
          if event.id == args[:id]
            event.add_tags(args[:tags]) if args[:tags]
            event.data.label = args[:label] if args[:label]
            event.data.created = args[:created] if args[:created]
            event.data.value = args[:value] if args[:value]
          end
        end
      elsif args[:label]
        @all.each do |event|
          if event.label == args[:label]
            event.add_tags(args[:tags]) if args[:tags]
            event.data.label = args[:label] if args[:label]
            event.data.created = args[:created] if args[:created]
            event.data.value = args[:value] if args[:value]
          end
        end
      elsif args[:tag]
        @all.each do |event|
          if event.tags.include?(args[:tag])
            event.add_tags(args[:tags]) if args[:tags]
            event.data.label = args[:label] if args[:label]
            event.data.created = args[:created] if args[:created]
            event.data.value = args[:value] if args[:value]
          end
        end
      elsif args[:date]
        @all.each do |event|
          if event.time.to_date == args[:date]
            event.add_tags(args[:tags]) if args[:tags]
            event.data.label = args[:label] if args[:label]
            event.data.created = args[:created] if args[:created]
            event.data.value = args[:value] if args[:value]
          end
        end
      elsif args[:time]
        @all.each do |event|
          if event.time == args[:time]
            event.add_tags(args[:tags]) if args[:tags]
            event.data.label = args[:label] if args[:label]
            event.data.created = args[:created] if args[:created]
            event.data.value = args[:value] if args[:value]
          end
        end
      end
    end

    def find(args={})
      results = Events.new
      if args[:id]
        @all.each { |e| results.all << e if e.id == args[:id] }
      elsif args[:time]
        @all.each { |e| results.all << e if e.time == args[:time] }
      elsif args[:date]
        @all.each { |e| results.all << e if e.time.to_date == args[:date] }
      elsif args[:event]
        @all.each { |e| results.all << e if e == args[:event] }
      elsif args[:label]
        @all.each { |e| results.all << e if e.label == args[:label] }
      elsif args[:labels]
        args[:labels].each do |label|
          @all.each { |e| results.all << e if e.label == label }
        end
      elsif args[:tags]
        args[:tags].each do |tag|
          @all.each { |e| results.all << e if e.tags.include?(tag) }
        end
      elsif args[:tag]
        @all.each { |e| results.all << e if e.tag == args[:tag] }
      else
        return false
      end
      results
    end

    def ids(args={unique: true})
      if args[:unique]
        ids = Set.new
      else
        ids = []
      end
      @all.each { |e| ids << e.id } 
      ids.to_a
    end
    
    def times(args={unique: true}) 
      if args[:unique]
        times = Set.new
      else
        times = []
      end
      @all.each { |e| times << e.time } 
      times.to_a
    end

    def dates(args={unique: true})
      if args[:unique]
        dates = Set.new
      else
        dates = []
      end
      @all.each { |e| dates << e.time.to_date }
      dates.to_a
    end

    def tags(args={unique: true})
      if args[:unique]
        tags = Set.new
      else
        tags = []
      end
      @all.each do |e| 
        e.tags.to_a.each { |t| tags << t }
      end
      tags.to_a
    end

    def labels(args={unique: true})
      if args[:unique]
        labels = Set.new
      else
        labels = []
      end
      @all.each { |e| labels << e.label }
      labels.to_a
    end
    
    def values(args={unique: true})
      if args[:unique]
        values = Set.new
      else
        values = []
      end
      @all.each { |e| values << e.value }
      labels.to_a
    end


  end

end
