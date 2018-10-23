class FrontendController < ActionController::Base
  def show
    render file: Rails.root.join('public', 'main.html'), layout: false
  end
end
