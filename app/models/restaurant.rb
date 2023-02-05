class Restaurant < ApplicationRecord
  # after_create_commit -> { broadcast_prepend_to "restaurants", partial: "restaurants/restaurant", locals: { restaurant: self }, target: "restaurants" }
  belongs_to :company

  validates :name, presence: true
  has_many :reviews, dependent: :destroy

  scope :ordered, -> { order(id: :desc) }

  # after_create_commit -> { broadcast_prepend_to "restaurants", partial: "restaurants/restaurant", locals: { restaurant: self }, target: "restaurants" }

  # after_create_commit -> { broadcast_prepend_to "restaurants", partial: "restaurants/restaurant", locals: { restaurant: self } }

  # after_create_commit -> { broadcast_prepend_to "restaurants" }
  # after_update_commit -> { broadcast_replace_to "restaurants" }
  # after_destroy_commit -> { broadcast_remove_to "restaurants" }

  # for sidekiq
  # after_create_commit -> { broadcast_prepend_later_to "restaurants" }
  # after_update_commit -> { broadcast_replace_later_to "restaurants" }
  # after_destroy_commit -> { broadcast_remove_to "restaurants" }

  # ultimate refactoring
  broadcasts_to ->(restaurant) { [ restaurant.company, "restaurants" ] }, inserts_by: :prepend
end
