module Keener
  class Error < StandardError
    class ResourceNotFoundError < Error; end
    class EventCollectionNotFoundError < Error; end
    class InvalidFilterError < Error; end
    class ServerError < Error; end
  end
end


