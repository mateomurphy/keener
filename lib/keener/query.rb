module Keener
  class Query
    def initialize(project_id, event_collection, options = {})
      @project_id = project_id
      @event_collection = event_collection
      @options = options
      yield self if block_given?
    end
  end

  class Metric < Query
    def add_filter(property, operator, value)
      @options[:filters] ||= []
      @options[:filters] << {
        :property_name => property,
        :operator => operator,
        :property_value => value
      }
      self
    end

    def interval(interval)
      @options[:interval] = interval
      self
    end

    def timeframe(timeframe)
      @options[:timeframe] = timeframe
      self
    end

    def group_by(group_by)
      @options[:group_by] = group_by
      self
    end

    def count
      Keener.count(@project_id, @event_collection, @options).get
    end

    def count_unique(target_property)
      Keener.count_unique(@project_id, @event_collection, target_property, @options).get
    end

    def minimum(target_property)
      Keener.minimum(@project_id, @event_collection, target_property, @options).get
    end

    def maximum(target_property)
      Keener.maximum(@project_id, @event_collection, target_property, @options).get
    end

    def sum(target_property)
      Keener.sum(@project_id, @event_collection, target_property, @options).get
    end

    def average(target_property)
      Keener.average(@project_id, @event_collection, target_property, @options).get
    end
  end

  #TODO implement
  class Funnel < Query

  end

  #TODO implement
  class Step < Query

  end
end