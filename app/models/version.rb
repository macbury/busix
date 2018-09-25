class Version < ApplicationRecord
  has_many :lines, dependent: :destroy
  has_many :directions, through: :lines
  has_many :line_stops, through: :directions
  has_many :stops, dependent: :destroy
  validates :date, uniqueness: true, presence: true

  scope :for_date, -> (date) { self.where('date <= ?', date).order('date DESC') }

  def self.latest
    self.order('date DESC').first
  end

  def self.current
    for_date(Date.today).first || latest
  end
end
