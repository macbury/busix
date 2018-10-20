module Resolvers
  module Stops
    class All < BaseCollection
      type Types::StopType.connection_type, null: false

      argument :name, String, required: true, description: 'Stop name'

      def resolve(name:)
        Version.current
               .stops
               .by_name(name)
               .order('name ASC')
      end
    end
  end
end
