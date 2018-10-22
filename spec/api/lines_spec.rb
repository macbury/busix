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
              edges {
                node {
                  name
                  kind
                }
              }
            }
          }
        }
      end

      it 'return buses and trams' do 
        is_expected.to match(
          {
            'lines' => {
              'edges' => [
                { 'node' => { 'name' => /\d+/i, 'kind' => 'tram' } },
                { 'node' => { 'name' => /\d+/i, 'kind' => 'tram' } },
                { 'node' => { 'name' => /\d+/i, 'kind' => 'bus' } },
                { 'node' => { 'name' => /\d+/i, 'kind' => 'bus' } }
              ]
            }
          }
        )
      end
    end

    describe 'one type only' do
      let(:query_string) do
        %{
          {
            lines(kind: BUS) {
              edges {
                node {
                  name
                  kind
                }
              }
            }
          }
        }
      end

      it 'return buses' do 
        is_expected.to match(
          {
            'lines' => {
              'edges' => [
                { 'node' => { 'name' => /\d+/i, 'kind' => 'bus' } },
                { 'node' => { 'name' => /\d+/i, 'kind' => 'bus' } }
              ]
            }
          }
        )
      end
    end
  end
end
