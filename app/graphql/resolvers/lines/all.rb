module Resolvers
  module Lines
    class All < BaseCollection
      type [Types::LineType], null: false

      argument :kind, Enums::LineKind, required: false, description: 'What kind of line you are interested in', default_value: :all

      def resolve(limit:, offset:, kind:)
        Version.current
          .lines
          .for_kind(kind)
          .limit(limit)
          .offset(offset)
          .order('name ASC')
      end
    end
  end
end
