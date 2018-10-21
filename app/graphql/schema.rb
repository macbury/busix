class Schema < GraphQL::Schema
  query Types::Query
  use BatchLoader::GraphQL
  default_max_page_size 50

  middleware(GraphQL::Schema::TimeoutMiddleware.new(max_seconds: 30) do |err, query|
    Rails.logger.info("GraphQL Timeout: #{query.query_string}")
  end)

  max_complexity 200
  log_query_complexity = GraphQL::Analysis::QueryComplexity.new { |query, complexity| Rails.logger.info("[GraphQL Query Complexity] #{complexity}")}
  query_analyzer(log_query_complexity)
end
