RSpec.describe Crawler::Cracow::Extract::CurrentDate do
  describe '#call', vcr: true do
    let(:page) do
      mechanize = Mechanize.new
      mechanize.get('http://rozklady.mpk.krakow.pl/')
    end
    let(:current) { subject[0] }

    subject { described_class.call(page).success }

    it { is_expected.not_to be_nil }
    it { expect(current[:date]).to eq(Date.new(2018, 7, 24)) }
    it { expect(current[:url]).to eq('http://rozklady.mpk.krakow.pl/?lang=PL&akcja=index&rozklad=20180724') }
  end
end
