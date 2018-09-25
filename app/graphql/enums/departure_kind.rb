module Enums
  class DepartureKind < Base
    value 'ALL', description: 'All days', value: :all
    value 'NORMAL', description: 'Normal work days', value: :normal
    value 'SATURDAY', value: :saturday
    value 'HOLIDAYS', value: :holidays, description: 'Any polish holiday'
  end
end
