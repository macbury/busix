FactoryBot.define do
  factory :version do
    sequence(:date) { |index| index.days.from_now }

    trait :current do
      date { Date.today }
    end
  end
end
