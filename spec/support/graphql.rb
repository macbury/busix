module GraphqlHelper
  
  def execute_query(query_string, context: {}, variables: {})
    Rails.logger.info "Executing: #{query_string}"
    res = Schema.execute(
      query_string,
      context: context,
      variables: variables
    ).to_h
    Rails.logger.info 'Done executing GraphQL Query'
    
    return res['errors'] if res['errors']
    res['data']
  end

end

RSpec.configure do |config|
  config.include GraphqlHelper
end
