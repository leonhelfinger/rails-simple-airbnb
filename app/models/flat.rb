class Flat < ApplicationRecord
  validates :name, :address, :description, :price_per_night, :number_of_guests, presence: true
  validates :price_per_night, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :number_of_guests, numericality: { only_integer: true, greater_than: 0 }

  scope :search, ->(query) {
    return all if query.blank?

    sanitized = "%#{sanitize_sql_like(query.strip.downcase)}%"
    where("LOWER(name) LIKE :q OR LOWER(address) LIKE :q", q: sanitized)
  }
end
