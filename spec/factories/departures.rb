FactoryBot.define do
  factory :departure do
    time { (86_000 * rand).to_i.seconds }
    day :normal
  end
end
