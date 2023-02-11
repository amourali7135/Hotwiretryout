class LineItemDate < ApplicationRecord
  belongs_to :restaurant

  validates :date, presence: true, uniqueness: { scope: :restaurant_id }

  scope :ordered, -> { order(date: :asc) }
end
