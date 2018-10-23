module Types
  class SimpleLineType < BaseType
    description 'Tram/Bus line'

    field :name, String, null: false, complexity: 5
    field :kind, String, null: false, complexity: 5
  end
end
