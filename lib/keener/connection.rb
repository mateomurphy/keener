module Keener
  module Connection
    def url
      if Keener.use_ssl
        'https://api.keen.io'
      else
        'http://api.keen.io'
      end
    end

    def connection
      @connection ||= ::Faraday.new(:url => url, :ssl => ssl_config) do |config|
        config.headers['Authorization'] = Keener.api_key
        config.headers['Content-Type'] = 'application/json'

        config.use Response::Middleware
        config.response :json
        config.response :logger if Keener.log_responses

        #config.use      :instrumentation      
        config.adapter Keener.adapter || ::Faraday.default_adapter
      end
    end

    def reset_connection
      @connection = nil
    end

    def in_parallel(manager = nil, &block)
      connection.in_parallel(manager) do
        block.call(self)
      end
    end
  end
end
