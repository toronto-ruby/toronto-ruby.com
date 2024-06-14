class Event < ApplicationRecord
  validates :start_at, :name, :location, :presentation, presence: true

  enum :status, { draft: 0, published: 1 }, default: :draft

  scope :upcoming, -> { published.where(start_at: Time.zone.now...).order(start_at: :asc) }
  scope :past, -> { published.where(start_at: ...Time.zone.now).order(start_at: :desc) }

  def start_time
    start_at.in_time_zone('Eastern Time (US & Canada)').to_fs(:long_at)
  end

  def self.statuses_for_select
    statuses.map { |k, _v| [k.titleize, k] }
  end

  def self.status_selected(status)
    statuses = {
      '0' => 'draft',
      '1' => 'published'
    }

    statuses[status.to_s]
  end
end
