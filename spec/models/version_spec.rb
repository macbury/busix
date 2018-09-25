require 'rails_helper'

RSpec.describe Version, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:lines) }
    it { is_expected.to have_many(:directions) }
    it { is_expected.to have_many(:line_stops) }
    it { is_expected.to have_many(:stops) }
  end

  describe '#validations' do
    it { is_expected.to validate_uniqueness_of(:date) }
    it { is_expected.to validate_presence_of(:date) }
  end

  describe '#current' do
    let!(:version_a) { create(:version, date: Date.civil(2018, 5, 10)) }
    let!(:version_b) { create(:version, date: Date.civil(2018, 5, 12)) }
    subject { Version.current }

    it 'expect to get version b' do
      is_expected.to eq(version_b)
    end

    it 'find version' do
      Timecop.freeze(Date.civil(2018, 5, 5)) do
        is_expected.to eq(version_b)
      end
    end

    it 'expect to get version a' do
      Timecop.freeze(Date.civil(2018, 5, 10)) do
        is_expected.to eq(version_a)
      end
    end
  end
end
