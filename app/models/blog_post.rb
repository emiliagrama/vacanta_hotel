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
    before_save :set_published_at, if: -> { published? && published_at.blank? }
    before_save :clear_published_at, if: -> { !published? }

  private

  def set_published_at
    self.published_at = Time.current
  end

  def clear_published_at
    self.published_at = nil
  end

  def generate_slug
    self.slug = title.parameterize
  end
end
