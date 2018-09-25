module SimpleNameable
  extend ActiveSupport::Concern

  included do
    before_save :build_simple_name
  end

  def build_simple_name
    self.simple_name = name.gsub(/([\b \.\,\-])/i, '').downcase
  end
end
