require 'keener/version'

require 'faraday'
require 'faraday_middleware'

require 'keener/config'
require 'keener/connection'
require 'keener/resource'
require 'keener/errors'
require 'keener/api'
require 'keener/query'

module Keener
  extend Api
  extend Config
  extend Connection
end