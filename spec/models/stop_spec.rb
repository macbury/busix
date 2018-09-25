require 'rails_helper'

RSpec.describe Stop, type: :model do
  subject { create(:stop) }

  describe '#associations' do
    it { is_expected.to belong_to(:version) }
    it { is_expected.to have_many(:directions) }
    it { is_expected.to have_many(:lines) }
    it { is_expected.to have_many(:line_stops) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:version_id) }
  end

  it { expect(subject.simple_name).not_to be_empty }
end
