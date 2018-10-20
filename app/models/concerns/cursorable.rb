module Cursorable
  extend ActiveSupport::Concern

  included do
    scope :by_cursor, -> (first, after) { limit(first).where('id > ?', after) }
  end
end
