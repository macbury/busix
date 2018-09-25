require 'rails_helper'

RSpec.describe Crawler::Cracow::SyncLines do
  describe '#call', vcr: true do
    let(:version) { create(:version) }
    let(:url) { 'http://rozklady.mpk.krakow.pl/?lang=PL&rozklad=20180724&linia=4__1__1' }

    subject { described_class.call(version: version, url: url) }
    
    it { expect { subject }.to change { Crawler::FetchDirectionsJob.jobs.count }.by(171) }
    it { expect { subject }.to change { version.lines.count }.by(171) }

    describe 'created lines' do
      before { subject }
      it { expect(Line.find_by(name: '4')).not_to be_nil }
    end
  end
end
