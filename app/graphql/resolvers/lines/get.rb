module Resolvers
  module Lines
    class Get < Base
      type Types::LineType, null: false

      argument :name, String, required: true, description: 'Line name'

      def resolve(name:)
        Version.current.lines.by_name(name).first
      end
    end
  end
end
