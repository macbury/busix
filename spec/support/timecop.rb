RSpec.configure do |config|
  config.before(:suite) do
    Timecop.return
  end

  config.around(:each, :timecop) do |example|
    Timecop.travel example.metadata[:timecop] do
      example.call
    end
  end
end
