module Keener
  class Query
    def initialize(project_id, event_collection, options = {})
      @project_id = project_id
      @event_collection = event_collection
      @options = options
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
      Keened.count(@project_id, @event_collection, @options).get
    end

    def count_unique(target_property)
      Keened.count_unique(@project_id, @event_collection, target_property, @options).get
    end

    def minimum(target_property)
      Keened.minimum(@project_id, @event_collection, target_property, @options).get
    end

    def maximum(target_property)
      Keened.maximum(@project_id, @event_collection, target_property, @options).get
    end

    def sum(target_property)
      Keened.sum(@project_id, @event_collection, target_property, @options).get
    end

    def average(target_property)
      Keened.average(@project_id, @event_collection, target_property, @options).get
    end
  end

  class Funnel < Query

  end

  class Step < Query

  end
end