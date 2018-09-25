module Crawler
  module Cracow
    module Extract
      class Stops < Operation
        STOPS_XPATH = '/html/body/table/tbody/tr/td/table/tr/td[2]/table/tr[2]/td/table/tr/td[1]/table/tr[2]/td/table/tr/td[1]'

        def call(page)
          stops = page.search(STOPS_XPATH).map do |td|
            link = td.at('a')
            name = td.text.strip
            link ? { name: name, url: link[:href] } : { name: name }
          end
          Success(stops)
        end
      end
    end
  end
end
