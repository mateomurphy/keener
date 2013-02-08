module Keener
  class Resource
    attr_reader :url, :options

    def initialize(url = '', options = {})
      @url = url
      @options = options
    end

    def get(&block)
      handle_response Keener.connection.get("#{version}/#{url}", options), &block
    end

    def head
      Keener.connection.head("#{version}/#{url}", options)
    end

    def check_for_errors(body)
      raise body if body.is_a?(Error)
      body
    end

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

    def version
      '3.0'
    end
  end
end