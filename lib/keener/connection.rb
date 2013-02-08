module Keener
  module Connection
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
