class LineItemDate < ApplicationRecord
  belongs_to :restaurant

  validates :date, presence: true, uniqueness: { scope: :restaurant_id }

  scope :ordered, -> { order(date: :asc) }

  def previous_date
    restaurant.line_item_dates.ordered.where("date < ?", date).last
  end
end
