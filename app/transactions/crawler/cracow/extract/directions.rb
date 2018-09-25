module Crawler
  module Cracow
    module Extract
      class Directions < Operation
        DIRECTIONS_XPATH = '/html/body/table/tbody/tr/td/table/tr/td[2]/table/tr[1]/td/table/tr[1]/td/table/tr/td[3]/a'

        def call(page)
          directions = page.search(DIRECTIONS_XPATH).map { |link| { name: link.text.strip, url: link[:href] } }
          
          Success(directions)
        end
      end
    end
  end
end
