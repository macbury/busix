FactoryBot.define do
  factory :line_stop do
    association :direction

    transient do
      version_id nil
    end

    before(:create) do |line_stop, evaluator|
      line_stop.stop = evaluator.version_id ? create(:stop, version_id: evaluator.version_id) : create(:stop)
    end

    trait :with_departure do
      after(:create) do |line_stop|
        create_list(:departure, 2, line_stop: line_stop)
      end
    end
  end
end
