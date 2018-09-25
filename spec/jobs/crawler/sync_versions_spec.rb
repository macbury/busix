require 'rails_helper'

RSpec.describe Crawler::SyncVersionsJob do
  it { is_expected.to be_processed_in :versions }

  it 'trigger service' do
    expect(Crawler::Cracow::SyncVersions).to receive(:call)
    subject.perform
  end
end
