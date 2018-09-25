FactoryBot.define do
  factory :line do
    sequence(:name) { |index| index.to_s }
    association :version

    trait :with_departure do
      after(:create) do |line|
        direction = create(:direction, line: line)
        create_list(:line_stop, 2, :with_departure, direction: direction, version_id: line.version_id)
        line.reload
      end
    end
  end
end
