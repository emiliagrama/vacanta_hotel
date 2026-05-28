class OfferVariant < ApplicationRecord
  belongs_to :offer_program
  
  scope :active, -> { where(active: true) }

  MEAL_PLANS = %w[demi completa].freeze
  DURATION_KINDS = %w[intensa prelungita].freeze
  ROOM_TYPES = %w[superioară].freeze

  validates :people_count, inclusion: { in: [1, 2] }
  validates :meal_plan, inclusion: { in: MEAL_PLANS }
  validates :duration_kind, inclusion: { in: DURATION_KINDS }
  validates :room_type, inclusion: { in: ROOM_TYPES }
  validates :nights, numericality: { only_integer: true, greater_than: 0 }
  validates :price_ron, numericality: { only_integer: true, greater_than: 0 }
end
