module Resolvers
  class BaseCollection < Base
    argument :limit, Integer, required: false, default_value: 20, prepare: -> (limit, ctx) { [limit, 50].min }
    argument :offset, Integer, required: false, default_value: 0
  end
end
