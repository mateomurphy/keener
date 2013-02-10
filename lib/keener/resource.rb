module Keener
  # This class represents an API resource and supports methods for making calls on it
  class Resource
    attr_reader :url, :options

    def initialize(url = '', options = {})
      @url = url
      @options = options
    end

    # Performs a get request on the given resource. A block passed will be used as an on_complete callback
    #
    # @return [Hashie::Mash] An object representing the result of the request
    def get(&block)
      handle_response Keener.connection.get("#{version}/#{url}", options), &block
    end

    # Performs a head request on the given resource
    #
    # @return [Faraday::Response] A faraday response object
    def head
      Keener.connection.head("#{version}/#{url}", options)
    end

    # Checks the given body to see if it's an error object and raises it if it is
    def check_for_errors(body)
      raise body if body.is_a?(Error)
      body
    end

    # Handles a faraday response, checking if it's an error, and setting up a callback with the passed block
    def handle_response(response, &block)
      if response.finished?
        response = check_for_errors(response.body)
      end
      
      if block
        response.on_complete do |env|
          block.call(env[:body])
        end
      end
        
      response
    end

    # Returns the Keen API version to use for requests
    def version
      '3.0'
    end
  end
end