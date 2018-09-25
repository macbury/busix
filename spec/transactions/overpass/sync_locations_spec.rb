RSpec.describe Overpass::SyncLocations do
  describe '#call', vcr: true do
    subject { described_class.call }
    
    it { expect { subject }.to change { StopLocation.count }.by(6711) }
  end
end
