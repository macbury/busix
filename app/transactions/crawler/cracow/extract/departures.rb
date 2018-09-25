module Crawler
  module Cracow
    module Extract
      class Departures < Operation
        DEPARTURES_XPATH = '/html/body/table/tbody/tr/td/table/tr/td[2]/table/tr[2]/td/table/tr/td[2]/table/tr[2]/td/table/tr'

        HEADER_MAPPING = {
          'godzina' => :hour,
          'dzień powszedni' => :normal,
          'soboty' => :saturday,
          'święta' => :holidays
        }

        def call(page)
          rows = page.search(DEPARTURES_XPATH).reject { |tr| !tr.search('table').empty? }

          headers = rows[0].search('td').map do |td|
            header = td.text.strip.downcase
            kind = HEADER_MAPPING[header]
            next if header.empty?
            return Failure("Could not map header #{header}") unless kind
            kind
          end

          departures = rows[1..-1].flat_map do |tr|
            tds = tr.search('td').map { |td| td.text.strip }
            hour = tds.delete_at(0).to_i.hours
            tds.map! { |text| text.empty? ? '0' : text }
            
            durations = []
            tds.each_with_index do |td, index|
              kind = headers[index+1]
              minutes = td.split(' ').map { |min| min.strip.to_i.minutes }
              minutes = [0.minutes] if minutes.empty?

              durations += minutes.map do |min|
                { day: kind, time: (hour + min) }
              end
            end
            durations
          end

          Success(departures)
        end
      end
    end
  end
end
