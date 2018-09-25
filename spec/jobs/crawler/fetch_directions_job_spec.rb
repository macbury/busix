require 'rails_helper'

RSpec.describe Crawler::FetchDirectionsJob do
  it { is_expected.to be_processed_in :directions }

  it 'trigger service' do
    line = create(:line)
    url = 'http://total.fake'
    expect(Crawler::Cracow::SyncDirections).to receive(:call).with(url: url, line: line, load_next_direction: true)
    subject.perform(line.id, url, true)
  end
end
