require 'keener/version'

require 'faraday'
require 'faraday_middleware'

require 'keener/api'
require 'keener/config'
require 'keener/resource'
require 'keener/query'
require 'keener/errors'

module Keener
  extend Api
  extend Config

end