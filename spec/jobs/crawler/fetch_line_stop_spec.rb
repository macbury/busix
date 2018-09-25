require 'rails_helper'

RSpec.describe Crawler::FetchLineStopJob do
  it { is_expected.to be_processed_in :stops }

  it 'trigger service' do
    line_stop = create(:line_stop)
    url = 'http://total.fake'
    expect(Crawler::Cracow::SyncLineStop).to receive(:call).with(line_stop: line_stop, url: url)
    subject.perform(line_stop.id, url)
  end
end
