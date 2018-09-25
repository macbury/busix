module Types
  class VersionType < BaseType
    description 'Version of timetable'

    field :date, String, null: false, complexity: 1
  end
end
