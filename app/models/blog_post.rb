class BlogPost < ApplicationRecord
  has_one_attached :featured_image

  before_validation :generate_slug, if: -> { title.present? && slug.blank? }

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :excerpt, presence: true
  validates :body, presence: true

  scope :published, -> {
    where(published: true)
      .where.not(published_at: nil)
      .order(published_at: :desc)
  }

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
