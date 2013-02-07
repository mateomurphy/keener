module Keener
  class Resource
    attr_reader :url, :options

    def initialize(url = '', options = {})
      @url = url
      @options = options
    end
    
    def connection
      @connection ||= ::Faraday.new(:url => 'http://api.keen.io') do |config|
        config.headers['Authorization'] = Keener.api_key

        config.response :mashify
        config.response :json

        config.response :logger if Keener.log_responses

        #config.use      :instrumentation      
        config.adapter  ::Faraday.default_adapter
      end
    end

    def get
      parse_response connection.get("#{version}/#{url}", options)
    end

    def head
      connection.head("#{version}/#{url}", options)
    end

    def parse_response(response)
      if response.body.respond_to?(:error_code)
        raise Error.const_get(response.body.error_code), response.body.message
      end

      response.body
    end

    def version
      '3.0'
    end
  end
end