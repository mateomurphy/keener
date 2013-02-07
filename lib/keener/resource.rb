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