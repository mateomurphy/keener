module Keener
  module Config
    attr_accessor :api_key
    attr_accessor :log_responses
    attr_accessor :adapter
    attr_accessor :use_ssl
    attr_accessor :ssl_config
  end
end