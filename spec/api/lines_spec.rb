RSpec.describe 'Fetching lines', graphql: true do
  subject { execute_query(query_string) }
  let!(:current_version) { create(:version, :current) }
  
  context 'only name and kind' do
    let!(:trams) { create_list(:line, 2, kind: :tram, version: current_version) }
    let!(:buses) { create_list(:line, 2, kind: :bus, version: current_version) }

    describe 'all types' do
      let(:query_string) do
        %{
          {
            lines {
              name
              kind
            }
          }
        }
      end

      it 'return buses and trams' do 
        is_expected.to match({
          'lines' => [
            { 'name' => /\d+/i, 'kind' => 'tram' },
            { 'name' => /\d+/i, 'kind' => 'tram' },
            { 'name' => /\d+/i, 'kind' => 'bus' },
            { 'name' => /\d+/i, 'kind' => 'bus' }
          ]
        })
      end
    end

    describe 'kind TRAM' do
      let(:query_string) do
        %{
          {
            lines(kind: TRAM) {
              name
              kind
            }
          }
        }
      end

      it 'return trams' do 
        is_expected.to match({
          'lines' => [
            { 'name' => /\d+/i, 'kind' => 'tram' },
            { 'name' => /\d+/i, 'kind' => 'tram' }
          ]
        })
      end
    end
  end
  
  describe 'fetch directions, stops and departures' do
    let!(:line) { create(:line, :with_departure, version: current_version) }
    let(:query_string) do
      %{
        {
          lines {
            directions {
              name
              stops {
                name
                departures {
                  formattedTime
                  day
                }
              }
            }
          }
        }
      }
    end
    
    it 'return trams' do
      line = subject['lines'][0]
      direction = line['directions'][0]
      stop = direction['stops'][0]
      departure = stop['departures'][0]
      expect(departure).not_to be_nil
    end
  end
end
