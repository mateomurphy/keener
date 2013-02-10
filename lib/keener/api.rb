module Keener

  # Implements direct access to the api
  #
  # See https://keen.io/docs/api/reference/ for detailed info
  module Api
    # GET returns the average across all numeric values for the target property in the event 
    # collection matching the given criteria. Non-numeric values are ignored.
    #
    # @return [Resource]
    def average(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/average", options
    end

    # GET returns the number of resources in the event collection matching the given criteria. 
    #
    # @return [Resource]
    def count(project_id, event_collection, options = {})
      options[:event_collection] = event_collection
      
      resource "projects/#{project_id}/queries/count", options
    end

    # GET returns the number of UNIQUE resources in the event collection matching the given criteria.
    #
    # @return [Resource]
    def count_unique(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/count_unique", options
    end

    # GET returns the available child resources.
    #
    # @return [Resource]
    def discovery
      resource ''
    end

    # GET returns available schema information for this event collection, 
    # including properties and their type. It also returns links to sub-resources.
    #
    # POST is for inserting one event at a time in a single request. Examples below.
    #
    # DELETE is for deleting the entire event collection. This is irreversible and will only work for collections under 10k events.
    #
    # @return [Resource]
    def event_collection(project_id, event_collection)
      resource "projects/#{project_id}/events/#{event_collection}"
    end

    # GET returns schema information for all the event collections in this project, 
    # including properties and their type.
    #
    # POST is for inserting multiple events in one or more collections, in a single request.
    #
    # @return [Resource]    
    def event_collections(project_id)
      resource "projects/#{project_id}/events"
    end

    # GET creates an extraction request for full-form event data with all property values.
    # If the query string parameter email is specified, then the extraction will be processed 
    # asynchronously and an e-mail will be sent to the specified address when it completes.
    # The email will include a link to a downloadable CSV file.
    # If email is omitted, then the extraction will be processed in-line and results will be returned in the GET request.
    #
    # @return [Resource]
    def extraction(project_id, options = {})
      resource "projects/#{project_id}/queries/extraction", options
    end

    # Funnels count relevant events in succession.
    #
    # @return [Resource]
    def funnel(project_id, options = {})
      resource "projects/#{project_id}/queries/funnel", options
    end

    # GET returns the maximum numeric value for the target property in the event collection 
    # matching the given criteria. Non-numeric values are ignored. 
    #
    # @return [Resource]
    def maximum(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/maximum", options
    end

    # GET returns the minimum numeric value for the target property in the event collection 
    # matching the given criteria. Non-numeric values are ignored.
    #
    # @return [Resource]
    def minimum(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/minimum", options
    end

    # GET Returns detailed information about the specific project.
    #
    # @return [Resource]    
    def project(project_id)
      resource "projects/#{project_id}"
    end

    # GET Returns the projects accessible to the API user.
    #
    # @return [Resource]
    def projects
      resource 'projects'
    end

    # GET returns the property name, type, and a link to sub-resources.
    #
    # DELETE is for removing a property and deleting all values stored with that property name.
    #
    # @return [Resource]
    def property(project_id, event_collection, property_name)
      resource "projects/#{project_id}/events/#{event_collection}/properties/#{property_name}"
    end

    # GET returns the list of available queries.
    #
    # @return [Resource]
    def queries(project_id)
      resource "projects/#{project_id}/queries"
    end

    # Returns a resource object for the given url and options
    #
    # @return [Resource]
    def resource(url, options = {})
      Resource.new(url, options)
    end

    # GET returns information about the specified Saved Query and includes links to child-resources.
    #
    # PUT either inserts a new Saved Query if it doesn’t already exist, or updates an existing Saved Query if it does exist.
    #
    # DELETE just plain old deletes the Saved Query.
    #
    # @return [Resource]
    def saved_query(project_id, saved_query_name, options)
      resource "projects/#{project_id}/saved_queries/#{saved_query_name}", options
    end

    # GET returns the results of the specified Saved Query.
    #
    # @return [Resource]
    def saved_query_result(project_id, saved_query_name)
      resource "projects/#{project_id}/saved_queries/#{saved_query_name}/result"
    end

    # GET returns all the available Saved Queries for the specified project as well as links to child-resources.
    #
    # @return [Resource]
    def saved_queries(project_id)
      resource "projects/#{project_id}/saved_queries", options
    end

    # GET returns a list of UNIQUE resources in the event collection matching the given criteria. 
    #
    # @return [Resource]
    def select_unique(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/select_unique", options
    end

    # GET returns the sum of all numeric values for the target property in the 
    # event collection matching the given criteria. Non-numeric values are ignored.
    #
    # @return [Resource]
    def sum(project_id, event_collection, target_property, options = {})
      options[:event_collection] = event_collection
      options[:target_property] = target_property

      resource "projects/#{project_id}/queries/sum", options
    end
  end
end