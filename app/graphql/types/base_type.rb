module Types
  class BaseType < GraphQL::Schema::Object
    field :id, Integer, null: false, description: 'Id of the object, can change after some time'
  end
end
