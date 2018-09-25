module Arguments
  VersionDate = GraphQL::ScalarType.define do
    name "VersionDate"
    description "Version represented as date YYYY-MM-DD"

    coerce_input -> (value, ctx) do
      begin
        date = Date.parse(value)
        Version.for_date(date).first!
      rescue ArgumentError, ActiveRecord::RecordNotFound
        raise GraphQL::CoercionError, "cannot coerce `#{value.inspect}` to Version"
      end
    end

    coerce_result -> (value, ctx) { version.date }
  end
end
