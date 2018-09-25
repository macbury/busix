require 'rails_helper'

RSpec.describe Crawler::SyncLinesJob do
  let(:version) { create(:version) }
  let(:url) { 'http://test.example' }
  it { is_expected.to be_processed_in :lines }

  it 'trigger service' do
    expect(Crawler::Cracow::SyncLines).to receive(:call).with(
      version: version, 
      url: url
    )
    subject.perform(version.id, url)
  end
end
