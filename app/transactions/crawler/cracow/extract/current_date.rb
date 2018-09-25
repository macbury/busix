module Crawler
  module Cracow
    module Extract
      class CurrentDate < Operation
        CURRENT_DATE_XPATH = '/html/body/table/thead/tr[3]/td/table/tr/td/label/a'
        NEW_DATE_XPATH = '/html/body/table/thead/tr[3]/td/table/tr[2]/td/div/label/a'
        DATE_PARAM = /rozklad=(?<year>\d{4})(?<month>\d{2})(?<day>\d{2})/i

        def call(page)
          links = [page.at(CURRENT_DATE_XPATH), page.search(NEW_DATE_XPATH)].flatten
          dates = links.map do |link|
            href = link[:href]
            { date: date_from_href(href), url: href }
          end
          
          Failure("Could not parse date: #{dates.inspect}") if dates.any? { |date| date[:date].nil? }
          Success(dates)
        end

        private

        def date_from_href(href)
          matched_date = href.match(DATE_PARAM)
          return unless matched_date
          Date.new(
            matched_date[:year].to_i, 
            matched_date[:month].to_i, 
            matched_date[:day].to_i
          )
        end
      end
    end
  end
end
