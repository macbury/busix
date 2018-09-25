require 'rails_helper'

RSpec.describe Crawler::Cracow::SyncDirections do
  describe '#call', vcr: true do
    subject do 
      described_class.call(line: line, url: url, load_next_direction: load_next_direction)
    end

    context 'line number 503' do
      let(:line) { create(:line, name: 503) }
      let(:url) { 'http://rozklady.mpk.krakow.pl/?lang=PL&rozklad=20180724&linia=503' }
      let(:load_next_direction) { false }

      it 'is bus' do
        subject
        expect(line.reload).to be_bus
      end
    end

    context 'line number 4' do
      let(:line) { create(:line, name: 4) }

      context 'Wzgórza Krzesławickie - Bronowice Wiadukt' do
        let(:url) { 'http://rozklady.mpk.krakow.pl/?lang=PL&rozklad=20180724&linia=4' }
        let(:load_next_direction) { true }

        it { expect { subject }.to change { GeocodeStopJob.jobs.count }.by(33) }

        it 'enqueued fetching directions' do 
          expect { subject }.to change { Crawler::FetchDirectionsJob.jobs.count }.by(1)
          expect(Crawler::FetchDirectionsJob).to have_enqueued_sidekiq_job(line.id, 'http://rozklady.mpk.krakow.pl/?lang=PL&akcja=index&rozklad=20180724&linia=4__2', false)
        end

        it 'enqueued fetch stop' do
          expect { subject }.to change { Crawler::FetchLineStopJob.jobs.count }.by(32)
          expect(Crawler::FetchLineStopJob).to have_enqueued_sidekiq_job(line.line_stops.first.id, 'http://rozklady.mpk.krakow.pl/?lang=PL&rozklad=20180724&linia=4__1__1')
        end

        it { expect { subject }.to change { line.line_stops.count }.by(33) }
        it { expect { subject }.to change { line.directions.count }.by(1) }

        describe 'fetch kind' do
          before do
            subject
            line.reload
          end

          it { expect(line).to be_tram }
        end

        it 'fetched full ride' do
          subject
          direction = line.directions.first
          expect(direction.name).to eq('Wzgórza Krzesławickie - Bronowice Małe')
          expect(direction.stops.first.name).to eq('Wzgórza Krzesławickie')
          expect(direction.stops.last.name).to eq('Bronowice Małe')
        end
      end

      describe 'dont load next direction' do
        let(:load_next_direction) { false }
        let(:url) { 'http://rozklady.mpk.krakow.pl/?lang=PL&rozklad=20180724&linia=4' }
        it { expect { subject }.to change { Crawler::FetchDirectionsJob.jobs.count }.by(0) }
      end
    end
  end
end
