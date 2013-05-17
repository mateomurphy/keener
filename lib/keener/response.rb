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

      def on_complete(env)
        case env[:stats]
        when 500
          env[:body] = Error::ServerError.new(env[:body])
        when 204, 304
          # do nothing
        else
          env[:body] = parse(::JSON.parse(env[:body]))
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