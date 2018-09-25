require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join('spec/fixtures/vcr_cassettes').to_s
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each, :vcr) do |example|
    WebMock.enable!
    name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(/[^\w\/]+/, '_')
    VCR.use_cassette([name, 'record'].join('_'), record: :once) { example.call }
  end
end
