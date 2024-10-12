class Event < ApplicationRecord
  validates :start_at, :name, :location, :description, presence: true

  enum :status, { draft: 0, published: 1 }, default: :draft

  scope :upcoming, -> { published.where(start_at: Time.zone.now...).order(start_at: :asc) }
  scope :past, -> { published.where(start_at: ...Time.zone.now).order(start_at: :desc) }

  has_rich_text :description
  has_rich_text :location

  def start_time
    start_at.in_time_zone('Eastern Time (US & Canada)').to_fs(:long_at)
  end

  def self.statuses_for_select
    statuses.map { |k, _v| [k.titleize, k] }
  end

  def to_param
    slug
  end
end
