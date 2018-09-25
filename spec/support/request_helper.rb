module Requests  
  module JsonHelpers
    def json
      JSON.parse(subject.body)
    end
  end
end

RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :controller
end
