require 'rails_helper'

RSpec.describe Departure, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:line_stop) }
    it { is_expected.to have_one(:direction) }
    it { is_expected.to have_one(:line) }
    it { is_expected.to have_one(:stop) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:time) }
  end

  describe '#day_for_time' do
    subject { described_class.day_for_time(Time.now) }

    it 'return holidays for polish holiday', timecop: Date.civil(2018, 8, 15) do
      is_expected.to eq(:holidays)
    end

    it 'return holidays for sunday', timecop: Date.civil(2018, 8, 5) do
      is_expected.to eq(:holidays)
    end

    it 'return saturday for saturday', timecop: Date.civil(2018, 8, 4) do
      is_expected.to eq(:saturday)
    end

    it 'return normal for friday', timecop: Date.civil(2018, 8, 3) do
      is_expected.to eq(:normal)
    end
  end
end
