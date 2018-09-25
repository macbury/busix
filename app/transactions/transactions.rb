module Transactions
  extend Dry::Container::Mixin

  namespace 'crawler' do
    register('load_page') { Crawler::LoadPage.new }

    namespace 'extract' do
      register('lines') { Crawler::Cracow::Extract::Lines.new }
      register('stops') { Crawler::Cracow::Extract::Stops.new }
      register('directions') { Crawler::Cracow::Extract::Directions.new }
      register('departures') { Crawler::Cracow::Extract::Departures.new }
      register('current_date') { Crawler::Cracow::Extract::CurrentDate.new }
      register('kind') { Crawler::Cracow::Extract::Kind.new }
    end
  end
end
