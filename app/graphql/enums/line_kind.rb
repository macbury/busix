module Enums
  class LineKind < Base
    value 'ALL', description: 'all type of lines', value: :all
    value 'TRAM', description: 'Tram line', value: :tram
    value 'BUS', description: 'Bus line', value: :bus
  end
end
