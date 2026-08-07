class Event < ApplicationRecord
  # Meetups run about three hours; we don't track an explicit end time.
  DURATION = 3.hours

  validates :start_at, :name, :location, :description, presence: true

  enum :status, { draft: 0, published: 1 }, default: :draft

  # An event counts as upcoming until it's over, not until it starts.
  scope :upcoming, -> { published.where(start_at: (Time.zone.now - DURATION)...).order(start_at: :asc) }
  scope :past, -> { published.where(start_at: ...(Time.zone.now - DURATION)).order(start_at: :desc) }

  has_rich_text :description
  has_rich_text :location

  def start_time
    start_at.to_fs(:long_at)
  end

  def end_at
    start_at + DURATION
  end

  def over?
    Time.zone.now >= end_at
  end

  def map_url
    return if map_query.blank?

    "https://www.google.com/maps/search/?#{{ api: 1, query: map_query }.to_query}"
  end

  def self.statuses_for_select
    statuses.map { |k, _v| [k.titleize, k] }
  end

  def to_param
    slug
  end

  private

  # Locations are written as a venue name, then a street address, then optional
  # arrival instructions. Only the first two lines help a map search, so the
  # rest is dropped and the city is appended when it isn't already there.
  def map_query
    lines = location&.to_plain_text.to_s.split("\n").map(&:strip).reject(&:blank?).first(2)
    return '' if lines.blank?

    lines << city if city.present? && lines.none? { |line| line.include?(city.split(',').first.strip) }
    lines.join(', ')
  end
end
