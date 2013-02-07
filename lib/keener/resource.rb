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
        config.adapter  Keener.adapter || ::Faraday.default_adapter
      end
    end

    def get(&block)
      handle_response connection.get("#{version}/#{url}", options), &block
    end

    def head
      connection.head("#{version}/#{url}", options)
    end

    def parse_response(body)
      if body.respond_to?(:error_code)
        raise Error.const_get(body.error_code), body.message 
      end
      body
    end

    def handle_response(response, &block)
      if response.finished?
        response = parse_response(response.body)
      end
      
      if block
        response.on_complete do |env|
          block.call(parse_response(env[:body]))
        end
      end
        
      response
    end

    def version
      '3.0'
    end
  end
end