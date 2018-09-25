module Crawler
  class LoadPage < Operation
    URL = 'http://rozklady.mpk.krakow.pl/'

    def call(url = nil)
      page = fetch_page(url)
      Success(page)
    end

    private

    def fetch_page(url, retry_left=25)
      raise "Could not fetch: #{url | URL}" if retry_left <= 0
      page = mechanize.get(URL)
      page = mechanize.get(url) if url
      page
    rescue SocketError, Errno::ETIMEDOUT
      sleep 5
      fetch_page(url, retry_left-1)
    end

    def mechanize
      @mechanize ||= Mechanize.new do |config|
        config.follow_meta_refresh = true
        config.keep_alive = false
        config.user_agent = 'BusGraph'
        config.idle_timeout = 2
        config.log = Rails.logger
      end
    end
  end
end
