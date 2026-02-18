class OfferProgram < ApplicationRecord
  has_many :offer_variants, dependent: :destroy

  scope :active, -> { where(active: true) }

  validates :key, presence: true, uniqueness: true

  def includes_list
    (includes_bullets || []).map(&:to_s)
  end
end
