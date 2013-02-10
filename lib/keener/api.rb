# Implements direct access to the api
#
# https://keen.io/docs/api/reference/

module Keener
  module Api
    def average(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/average", options
    end

    def count(project_id, event_collection, options = {})
      options[:event_collection] = event_collection
      
      resource "projects/#{project_id}/queries/count", options
    end

    def count_unique(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/count_unique", options
    end

    def discovery
      resource ''
    end

    def event_collection(project_id, event_collection)
      resource "projects/#{project_id}/events/#{event_collection}"
    end

    # GET returns the event collections
    def events(project_id)
      resource "projects/#{project_id}/events"
    end

    def extraction(project_id, options = {})
      resource "projects/#{project_id}/queries/extraction", options
    end

    def funnel(project_id, options = {})
      resource "projects/#{project_id}/queries/funnel", options
    end

    def maximum(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/maximum", options
    end

    def minimum(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/minimum", options
    end

    # GET returns all the projects
    def project(project_id)
      resource "projects/#{project_id}"
    end

    def projects
      resource 'projects'
    end

    def property(project_id, event_collection, property_name)
      resource "projects/#{project_id}/events/#{event_collection}/properties/#{property_name}"
    end

    def queries(project_id)
      resource "projects/#{project_id}/queries"
    end

    def resource(url, options = {})
      Resource.new(url, options)
    end

    def saved_query(project_id, saved_query_name, options)
      resource "projects/#{project_id}/saved_queries/#{saved_query_name}", options
    end

    def saved_query_result(project_id, saved_query_name)
      resource "projects/#{project_id}/saved_queries/#{saved_query_name}/result"
    end

    def saved_queries(project_id)
      resource "projects/#{project_id}/saved_queries", options
    end

    def select_unique(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/select_unique", options
    end

    def sum(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/sum", options
    end
  end
end