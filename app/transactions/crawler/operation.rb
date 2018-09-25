module Crawler
  class Operation
    include Dry::Transaction::Operation

    def self.call(*args)
      new.call(*args)
    end
  end
end
