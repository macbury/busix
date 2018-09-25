module Crawler
  module Cracow
    module Extract
      class Kind < Operation
        KIND_XPATH = '/html/body/table/tbody/tr/td/table/tr/td[2]/table/tr[1]/td/table/tr[1]/td/table/tr/td[1]/img'
        KIND_REGEXP = /(tram|bus)/i
        def call(page)
          kind_img = page.at(KIND_XPATH)
          kind_match = kind_img[:src].match(KIND_REGEXP)
          if kind_match
            Success(kind: kind_match[1].to_sym)
          else
            Failure('Could not locate type of line')
          end
        end
      end
    end
  end
end
