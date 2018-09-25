FactoryBot.define do
  factory :stop do
    association :version
    sequence(:name) { |index| "Stop: #{index}" }
  end
end
