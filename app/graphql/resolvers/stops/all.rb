module Resolvers
  module Stops
    class All < BaseCollection
      type [Types::StopType], null: false

      argument :name, String, required: true, description: 'Stop name'

      def resolve(name:, limit:, offset:)
        Version.current
               .stops
               .by_name(name)
               .order('name ASC')
               .limit(limit)
               .offset(offset)
      end
    end
  end
end
