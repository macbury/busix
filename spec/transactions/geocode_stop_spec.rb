RSpec.describe GeocodeStop do
  describe '#call' do
    let!(:stop) { create(:stop, name: 'Osiedle Na Wzgórzach') }
    
    context 'geocode using service if LocationStop missing', vcr: true do
      before { described_class.call(stop) }

      it { expect(stop.location.longitude).to eq(20.0613362208278) }
      it { expect(stop.location.latitude).to eq(50.09555675) }
    end

    context 'use only data from matched LocationStop' do
      let!(:stop_location) { create(:stop_location, name: stop.name) }
      before { described_class.call(stop) }

      it { expect(stop.location.longitude).to eq(stop_location.location.longitude) }
      it { expect(stop.location.latitude).to eq(stop_location.location.latitude) }
    end
  end
end
