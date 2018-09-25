require 'rails_helper'

RSpec.describe Crawler::Cracow::SyncVersions do
  describe '#call', vcr: true do
    subject { described_class.call }
    
    it { expect { subject }.to change { Crawler::SyncLinesJob.jobs.count }.by(3) }
    it { expect { subject }.to change { Version.count }.by(3) }

    describe 'created versions' do
      before { subject }
      let(:version) { Version.first }
      
      it { expect(Crawler::SyncLinesJob).to have_enqueued_sidekiq_job(version.id, 'http://rozklady.mpk.krakow.pl/?lang=PL&akcja=index&rozklad=20180727') }
      it { expect(Version.pluck(:date).map(&:day)).to eq([27, 28, 30]) }
    end

    it 'fail on version duplication exists' do
      described_class.call
      expect { described_class.call  }.to change { Version.count }.by(0)
    end
  end
end
