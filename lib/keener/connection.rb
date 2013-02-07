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

    def in_parallel(&block)
      connection.in_parallel do
        block.call(self)
      end
    end
  end
end
