module Crawler
  module Cracow
    module Extract
      class Lines < Operation
        def call(page)
          links = page.links_with(class: 'linia')
          links += page.links_with(class: 'liniaZ')
          links += page.links_with(class: 'linia0')
          links += page.links_with(class: 'liniaO')
          out = links.inject({}) do |output, link|
            output[link.text.strip.to_i] = link.resolved_uri
            output
          end
          Success(out)
        end
      end
    end
  end
end
