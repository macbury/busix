FactoryBot.define do
  factory :stop_location do
    sequence(:name) { |index| "Stop: #{index}" }
    location { RGeo::Geos.factory.point(10, 11) }
  end
end
