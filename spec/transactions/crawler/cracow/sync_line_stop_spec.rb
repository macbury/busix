require 'rails_helper'

RSpec.describe Crawler::Cracow::SyncLineStop do
  describe '#call', vcr: true do
    subject { described_class.call(line_stop: line_stop, url: url) }
    let(:url) { 'http://rozklady.mpk.krakow.pl/?lang=PL&rozklad=20180724&linia=4__1__1' }
    let(:line_stop) { create(:line_stop) }

    it { expect { subject }.to change { line_stop.departures.count }.by(165) }
    it { expect { subject }.to change { line_stop.departures.holidays.count }.by(53) }
    it { expect { subject }.to change { line_stop.departures.saturday.count }.by(56) }
    it { expect { subject }.to change { line_stop.departures.normal.count }.by(56) }

    describe '#time' do
      before { subject }
      let(:departure) { line_stop.departures.first }

      it { expect(departure.time).to eq(10800) }
      it { expect(departure).to be_normal }
    end
  end
end
