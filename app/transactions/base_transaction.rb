class BaseTransaction
  include Dry::Transaction(container: Transactions)

  def self.call(*args)
    new.call(*args)
  end
end
