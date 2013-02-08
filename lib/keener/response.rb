require 'hashie/mash'

module Keener
  class Response
    class Middleware < ::Faraday::Response::Middleware
      def check_for_errors(body)
        if body.respond_to?(:error_code)
          Error.const_get(body.error_code).new(body.message)
        else 
          body
        end
      end

      def parse(body)
        case body
        when Hash
          check_for_errors(::Hashie::Mash.new(body))
        when Array
          body.map { |item| parse(item) }
        else
          body
        end
      end

    end

  end
end