require 'rails_helper'

RSpec.describe GeocodeStopJob do
  it { is_expected.to be_processed_in :geocode }

  it 'trigger service' do
    stop = create(:stop)
    expect(GeocodeStop).to receive(:call).with(stop)
    subject.perform(stop.id)
  end
end
