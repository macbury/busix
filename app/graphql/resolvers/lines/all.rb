module Resolvers
  module Lines
    class All < BaseCollection
      type Types::SimpleLineType.connection_type, null: false

      argument :kind, Enums::LineKind, required: false, description: 'What kind of line you are interested in', default_value: :all

      def resolve(kind:)
        Version.current
          .lines
          .for_kind(kind)
          .order('name ASC')
      end
    end
  end
end
