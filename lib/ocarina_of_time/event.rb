module OcarinaOfTime

  Struct.new("EventData", :id, :label, :tags, :time, :created, :value)
  
  class Event 
    
    attr_reader :data
      
    def initialize(args={})
      @data = Struct::EventData.new 
      @data.id = SecureRandom.uuid
      @data.label = args[:label] || false
      @data.value = args[:value] || false
      @data.tags = Set.new
      creation_time = Time.now
      @data.time = args[:time] || creation_time 
      @data.created = args[:created] || creation_time 
      if args[:tags]
        add_tags(args[:tags])
      end
    end

    def id
      @data.id
    end

    def label
      @data.label
    end
    
    def time 
      @data.time
    end
    
    def created
      @data.created
    end
  
    def time?
      @data.tags.time ? true : false 
    end

    def tags
      @data.tags.to_a
    end

    def tags?
      @data.tags.empty? ? false : true
    end

    def add_tags(tags)
      if tags.is_a? Array
        tags.each do |tag|
          @data.tags << tag
        end
      elsif tags.is_a? String
        @data.tags << tags
      end
    end


  end

end
