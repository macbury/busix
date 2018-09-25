module DeviseHelpers
  def sign_in(user)
    request.headers['Accept'] = 'application/json'
    request.headers['Content-Type'] = 'application/json'
    Devise::JWT::TestHelpers.auth_headers(request.headers, user)
  end
end

RSpec.configure do |config|
  config.include DeviseHelpers, type: :controller
end
