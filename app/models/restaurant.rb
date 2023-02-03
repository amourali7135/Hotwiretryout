class Restaurant < ApplicationRecord
  validates :name, presence: true
  has_many :reviews, dependent: :destroy

  scope :ordered, -> { order(id: :desc)}
end
