FactoryBot.define do
  factory :direction do
    sequence(:name) { |index| "Direction: #{index}" }
    association(:line)
  end
end
